require 'linguistics/unicode/SGHUnicode'
require 'linguistics/language/TenseBlock'
require 'linguistics/la/LatinWord'
require 'linguistics/la/LatinNode'
require 'linguistics/la/LatinConjugation'
require 'linguistics/la/LatinDisplay'
require 'linguistics/la/LatinTense'

module Latin

=begin rdoc

== Description
  
LatinVerb is a class for turning a given 4-part string of:

 * active voice, present, first person singular:   amō, or amo
 * present, active infinitive: amāre, or amare
 * present, perfect, first person singular: amāvī, or amavi
 * perfect passive participle: amatum, or amatus

Into a fully-exploded, fully conjugated Latin verb ( like you would see in
chart forms on Wikipedia et in locis alteriis.  

These are traditionally given in Wheelock as:
<tt>amō, amāre, amāvī, amatum</tt>

Philosophically, in this class, we keep attributes and methods which are 
used to define the meta-structure of the verb.  The specific verb calls 
("Give me the present active participles" or "Give me the present tense
active indicative class") are handled metaprogrammatically and held
in Latin::LatinConjugation.

=end


  class LatinVerb < Latin::LatinWord
    include Latin::Conjugation
    include Latin::Display
=begin    

Scalar, created during initialization
These are iVar's pointing to the “four principal parts” of a Latin
verb.  

=end
    
    attr_reader :first_pers_singular, :pres_act_inf, 
                :first_pers_perf, :pass_perf_part, :conjugation

=begin    

Conjugation state, set by metapgrogrammatically handling the method
call.  Latin verbs have voice, mood, tense, number, and person.  The
:voice, :mood, etc. iVars will trap this.  The default mode
use case is to return all number / person “nodes” in a given 
tense.  As such, the number and person are not stored here as iVars.

=end
    
    attr_reader :voice, :mood, :tense, :number, :person
    
=begin    

Here are iVars that are used in calculation of nodes.

Stem is a place to store the verb stem e.g. amare=>ama, dicere => dic
Vector is the original method that's passed.  As mentioned above, we
take a metaprogrammatic approach to handling method calls to the 
object.  @vector records the method call that is trapped by
method_missing?(id,*opts)

Participal stem is used as the base for forming participles.

Response   is stored.  It is a hash
with only one pair: the name of the collection accessed, and the block
of nodes ( or a single node, if it has been defined in such an 
explicit fashion )

Collections is is where the displayable payload is stored.  

=end

    attr_reader :stem, :participial_stem, :vector, :response,
                :collections
    
=begin    

Array

Four_pp is an aray of the four principal parts ( headers on listings)

=end
    
    attr_reader :four_pp

=begin

##############################################################################
METHOD DECLARATION
##############################################################################

=end

=begin rdoc

<b>Arguments</b>:    Array containing 4 principal parts

<b>Attribs Used</b>: N/A

<b>Attribs Set</b>:  @four_pp, @first_pers_singular, @pres_act_inf, 
@first_pers_perf, @pass_perf_part, @four_pp, 
@voice_mood_matrix, @stem ( via #calculate_stem)

*Returns*:      Instance of LatinVerb

*Purpose*:  A LatinVerb is created by passing an array of the four principal 
parts that define a Latin Verb.  Typically these are: They are defined in an array: 
<tt>amō   amāre  amāvī  amatum</tt>.

=end
        
    def initialize(*params)
      
      # Creates an array of LatinWords for each of the passed-in parameters
      # Each principal part is given its own iVar
      
      @four_pp = params[0].map { |a_principal_part| Latin::LatinWord.new(a_principal_part) }    
      
      if @four_pp.length != 4 
        deponent_handler if @four_pp[2] =~ /sum$/
      end
      
      irregular_handler(@four_pp[1])
      
          
      @first_pers_singular, @pres_act_inf, 
      @first_pers_perf, @pass_perf_part = @four_pp

      # Create a top-level matrix that defines active_indicative / 
      # passive_indicative, etc.  
      #
      #                     ____________
      #                    |   | X | Y |
      #                    | 1 | a | b |
      #                    | 2 | c | d |
      #                    -------------
      #
      # In this case we have “voice by mood”
      
      @voice_mood_matrix = TenseBlock.new( {
                          :boundaries => 'voice by mood',
                          :voice      => %w(Active Passive),
                          :mood       => %w(Indicative Subjunctive),
                          :tense      => nil,
                          :default_p  => lambda {
                            |x,y| "#{x.downcase}_voice_#{y.downcase}_mood" 
                          }
                        } 
                      )

      # Given the 4 PP's, we can now derive the stem
      @stem = Latin::LatinWord.new(calculate_stem)
      
      # Set my conjugation
      @conjugation = evaluate_conjugation
      
      # Calculate participal stem
      @participial_stem = Latin::LatinWord.new(calculate_participial_stem)
      
      # Where to store things to-be displayed
      @collections = []

      
    end

=begin rdoc

*Arguments*:    Unrecognized method call, optional arguments

<b>Attribs Used</b>: N/A

<b>Attribs Set</b>:  @vector 

*Returns*:      Instance of LatinVerb

*Purpose*:  The method calls to a verb object can vary in over 100 ways, as such, coding that many methods seemed painful.  Accordingly, we trap the unknown method call, parse it, and set iVars.
            
Having identified the iVars, we are able to call a hash structure
containing lambdas to do the appropriate processing based on the “vector”
of voice, mood, tense, person, etc.

=end
    def method_missing(id, *args)    
      # We expect that method calls will be made to the object in the form:
      # V.active_voice_indicative_mood_present_tense.  Instead of having to 
      # create all these methods, we will look for unknown methods containing 
      # the pattern _voice_
   
      if id.to_s =~ /_voice_/
        
        @vector = id.to_s
        
        # This assignation needs to be done each call to the metaprog.
        # method because of the event that a verb was called for
        # a tense vector, and then a node vector.  The first instance's 
        # filling in of @number, @person will cause the second call to do
        # the wrong thing
        
        @number = @person = nil
        evaluate_method(id)

        # In the case that the instance has been used before to get 
        # a specific vector, then we want to clear it out
        @collections=[] if  not @person.nil? and not @collections.nil?
        
        generated_method = [@voice,@mood,@tense].join('_').to_sym
        
        raise("Method #{generated_method.to_} is not responded to!") unless 
          self.respond_to?(generated_method)

        raise ("FLAMING DETH:  pass to handler method returned nothing!") if 
          self.send(generated_method.to_sym).nil?
        
          
        @collections << 
          conjoin_nodes_with_labels(
            self.send(generated_method),
            TenseBlock.new( {
                                :boundaries => 'numbers by persons',
                                :numbers    => %w(Singular Plural),
                                :persons    => %w(First Second Third),
                                :tense      => 'present',
                              } 
                            )
          )
      else
        super(id)
      end
    end

    def to_s
      display!("\n")
    end
    
    def definition_string
      return @four_pp.join(', ').to_s
    end
=begin

##############################################################################
#   PRIVATE METHODS BELOW
##############################################################################

=end
    private 

=begin rdoc

*Arguments*:    None

*Attribs Used*: @pres_act_inf

*Attribs Set*:  None

*Returns*:      The “stem” of a Latin Verb

*Purpose*:      Based on the present active infinitive, identify the “stem” and set the @stem iVar.  
The method also returns the stem value.

=end

    def calculate_stem
      # For efficiency, if the iVar @stem is defined, don't go through this structure

      pres_act_inf = @pres_act_inf.to_s

      if pres_act_inf =~ /āre$/
        return pres_act_inf.gsub(/(.*)āre$/,'\\1ā')
      end
      if pres_act_inf =~ /ēre$/
        return pres_act_inf.gsub(/(.*)ēre$/,'\\1ē')
      end    
      if pres_act_inf =~ /ere$/
        if @first_pers_singular =~ /io$/
          return pres_act_inf.gsub(/(.*)ere$/,'\\1')
        else
          return pres_act_inf.gsub(/(.*)ere$/,'\\1')
        end
      end    
      if pres_act_inf =~ /īre$/
        return pres_act_inf.gsub(/(.*)īre$/,'\\1')
      end
    end
    
=begin rdoc


*Arguments*:    None

*Attribs Used*: @pres_act_inf

*Attribs Set*:  @conjugation

*Returns*:      The “stem” of a Latin Verb

*Purpose*:      Based on the present, active infinitive, decide on the conjugation.  This method requires that the endings be macron-ized in order to differentiate between _ere_ ( 2nd conjugation ) and _ere_ ( 4th conjugation).  It returns the value as a String: <tt>1</tt>, <tt>2</tt>, <tt>3</tt>, <tt>4</tt>, or <tt>3IO</tt> (e.g. <i>duco/ducere</i>)

=end

    def evaluate_conjugation
      ending = @pres_act_inf.get_last_three_characters
      returnValue = nil
      
      if ending =~ /āre$/
        returnValue = "1"
      end

      if ending =~ /ēre$/
        returnValue = "2"
      end    

      if ending =~ /ere$/
        if @first_pers_singular.get_last_three_characters =~ /iō$/
          returnValue = "3IO"
        else     
          returnValue = "3"
        end
      end

      if ending =~ /īre$/
        returnValue = "4"
      end    
      
      return returnValue
    end

=begin rdoc

Calculate the participial stem, used in forming participles.

=end

    def calculate_participial_stem
       raise("@pres_act_inf was nil!") if 
         @pres_act_inf.nil? or @first_pers_singular.nil?

       if @pres_act_inf.to_s =~ /(.*ā)re$/
        return $1
      end

      if @pres_act_inf.to_s =~ /(.*ē)re$/
        return $1
      end    

      if @pres_act_inf.to_s =~ /(.*)ere$/
        match=$1
        if @first_pers_singular =~ /iō/
          return match + "iē"  
        else
          return match + "e" 
        end
      end
          
      if @pres_act_inf.to_s =~ /(.*)īre$/
        return $1 + "iē" 
      end
    end
    
    
=begin

This is used to print out a full vector's nodes.  The value
of @vector is used as a title. The nodes that were produced
by means of the lambda are then printed out.

=end

    def conjoin_nodes_with_labels(nodes,labels)
      raise "conjoin_nodes failed to receieve a node or label set" if
        nodes.nil? or labels.nil?        
      paired_node_array=[]

      0.upto(labels.length-1) do |i| 
        paired_node_array.push(Latin::LatinNode.new(labels.matrix[i], 
          nodes[i], {:displayable => 'valuesonly'}) )
      end
      
      tense_label = @vector.capitalize!.split(/_/).join(' ')
      
      full_tense  =  Latin::LatinTense.new(tense_label, paired_node_array)
      
      if @person.nil? and @number.nil?     # For handling ...present_tense
         return full_tense
      elsif @number.nil? and not @person.nil? # number not defined; person yes
        
        # Find the methods that match the parameter that we were given
        matching_methods = 
         full_tense.verb_methods.map {|x|  x if x =~ /#{@person}/}.compact!

        # Call those methods and store the result to an array
        ambiguous_results = 
        matching_methods.map{|aMethod| full_tense.send(aMethod.to_sym)}
        
        # Return it
        return ambiguous_results.join(", ")
      elsif not @number.nil? and @person.nil?
        # This guy is really just the inverse of the above.

        # Find the methods that match the parameter that we were given
        matching_methods = 
         full_tense.verb_methods.map {|x|  x if x =~ /#{@number}/}.compact!

        # Call those methods and store the result to an array
        ambiguous_results = 
        matching_methods.map{|aMethod| full_tense.send(aMethod.to_sym)}
        
        # Return it
        return ambiguous_results.join(", ")
        
      elsif not @number.nil? and not @person.nil? # fully specified node
         locate_string = [@number,'number',@person,'person',].join('_')
         return full_tense.send(locate_string.to_sym)
      end

    end
    
    # This method is used internally to evaluate a method call that looks like 
    # a request for a conjugation.  The first descriptor pair is chopped off
    # from the given 'name' and the rest is held.  The given is sent through 
    # is recognized? where, if valid, an iVar is set.
    #
    # e.g. active_voice performs @voice=active
    #
    # Failure to successfully classify raises an exception
    #
    # If there is anything left in 'rest', then the function is recursively
    # called with 'rest'.
    #
    
    def evaluate_method(name)
      command = name.to_s.match(/(\w+?_){2}/).to_s
      rest    = name.to_s[command.to_s.length..name.to_s.length]
      
      # If you're at the last term, command does not get loaded
      # but rest stays the same.  
      if command !~ /\w/ and name == rest 
        command = rest
        rest    = nil 
      end
      
      # We've reached the end
      return if command !~ /\w/ and rest !~ /\w/

      # Recurse  
      evaluate_method(rest) if is_recognized?(command)  
      
    end
     
    # Given a string of the form "active_voice" ( or a "value/term" pair )
    # test its validity by Object.send(term.to_sym, value).
    
    def is_recognized?(datum)
      value, term = datum.split(/_/)
      term = "calculate_" + term
      send(term.to_sym, value)
      
      # Return true, because the 'send' call did not throw an exception
      return true
    end
   
    # Used to set the voice iVar OR raise an exception
    def calculate_voice(param)
      if param =~ /^(active|passive)$/i
        @voice = param
        return
      end
      raise "Unknown voice: #{param.to_s}, called."
    end

    # Used to set the voice iVar OR raise an exception    
    def calculate_mood(param)
      param.gsub!(/\W/, '')
      if param =~ /(indicative|subjunctive)/i
        @mood = param.downcase
        return
      end
      raise "Unknown mood: #{param.to_s}, called"
    end

    # Used to set the voice iVar OR raise an exception    
    def calculate_tense(param) 
      param.downcase!
      if @mood == "indicative"
        # All the legitimate moods in the indicative
        if param == "present"       or 
           param == "imperfect"     or 
           param == "future"        or 
           param == "perfect"       or 
           param == "pluperfect"    or 
           param == "pastperfect"   or
           param == "futureperfect" 
           @tense = param
         end 
      elsif @mood == "subjunctive"
        # All the legitimate moods in the subjunctive
        if param == "present"    or 
           param == "imperfect"  or 
           param == "perfect"    or 
           param == "pluperfect" or
           param == "pastperfect"
           @tense = param
        end
      else
        raise "Tense [#{param}] was found to be invalid."
      end
    end
    
    def calculate_person(param)
      @person = param.downcase
    end
  
    def calculate_number(param)
      @number = param.downcase
    end
    
    def deponent_handler
      raise "Sorry, we do not handle (semi-) deponent verbs at this time.  It's on the TODO list, thought!"
    end
    
    def irregular_handler(test_infinitive)
      if %w(esse nōlle).find{|irregular| test_infinitive.to_s == irregular}
        raise "Sorry, we do not handle irregular verbs at this time.  It's on the TODO list, thought!"
      end
    end
  end # ends the class
  
=begin rdoc

  == Dependencies

  None

  == Author

  Steven G. Harms, http://www.stevengharms.com

=end
end

