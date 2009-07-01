=begin rdoc

== Synopsis

TenseBlock:  module used to fabricate methods used for verb node construction

== Description

Generating all the methods associated with a full conjugation of a verb in Latin is exceedingly long.  A verb can be classified as

 def active_voice
  def indicative_mood
   def simple_present_tense
    def singular_number
     def first_person

Recognizing this, we need a way to generate a listing of an atomic structure, a "tense matrix": foreach number, each person has a value.

By passing in a matrix description in natural language ( "person by number") default values which define 
the <i>n</i>-many "<tt>person</tt>S" and "<tt>number</tt>S" are expected.  

Using a reasonable assumption that methods should be produced as 

<tt>tense_parameter</tt>\_tense\_<tt>personValue</tt>\_person\_<tt>numberValue</tt>\_number, 

we fabricate a matrix of method names.  

This can be overridden by changing the lambda defined in initialization ( :default_p )

This matrix can be accessed as an array through the TenseBlock#matrix method.  

A listing of the the matrix values can be acquired via the TenseBlock.to_s method.

== Example Code

 j.to_s #=> array of all the names, create_matrix called implicitly
        # as part of TenseBlock.new().  Default lambda used.
 
 # Iterate over the values that build the matrix of names
 j.create_matrix(Optional: lambda to override :default_p{|x| puts x }
 
 # Override the default wrapping lambda
 j.create_matrix( lambda { |x,y| "<<#{x}++#{y}>>" } ){|x| puts x }

== Author

Steven G. Harms, http://www.stevengharms.com

=end

class TenseBlock < Object
  attr_reader :boundaries, :definition, :matrix

=begin rdoc

  Initialize expects an initializing hash.
  
  :<b>boundaries</b>:: Defines the breadth and height of the two-dimensional matrix
  
  :<b>default_p</b>:: As pairs in the matrix are established, an action is taken with them.  The default action is described above.  In the case that this should be overridden assign a lambda to this key ( see examples, above ).  You may also gain dynamicity over these pairs by calling the TenseBlock#create_matrix method with a lambda passed as the single argument.
  
  :<b>tense</b>::  This value will be interpolated into a string "tenseValue_tense_" which will be _prepended_ to all value pairs that are output by the lambda in :default_p ( again, barring that that lambda is overridden as described above ).
  
=end 

  def initialize(parameters)
    
    # The anonymous hash passed in 
    @definition     = parameters
    @boundaries     = definition[:boundaries].split(/\s+by\s+/)
    
    @default_action = lambda do |firstElement,secondElement| 
                   return "#{firstElement.downcase}_" +
                          "#{boundaries[0][0..boundaries[0].length-2]}_" +
                          "#{secondElement.downcase}_" +
                          "#{boundaries[1][0..boundaries[1].length-2]}" 
                      end
                      

    @default_action = @definition[:default_p] unless 
      @definition[:default_p].nil? 

    @tense_wrapping_lambda = lambda do | action_produced_item |
      if @definition[:tense].nil?
        return action_produced_item
      else
        return"#{@definition[:tense]}_tense_#{action_produced_item}" 
      end
    end
    
    @matrix=create_matrix
  end

=begin rdoc

This is the critical method of the class.

Based on the boundaries described in the initializing key “:boundaries” a horizontal and
vertical aspect is determined.

Foreach element in the horizontal aspect, we pair foreach element within the vertical aspect.

These pairs are then subjuct to a lambda.  The default lambda can be overridden by passing a lambda
during the call to create_matrix.  If the method has an ancillary block, the result is yielded,
if we are not in block-context, the value is stored in a local array and is returned at the
conclusion of the method.

Barring a call-specific lambda, the default lambda is called.  This can be overridden in the 
initialization.  Again, if called in block context the value is yielded up, if not, it is added
into the array returned at the end of the method call.

TenseBlock.initialize makes a call to create matrix so it is most wise to define the default lambda
at initialization.

=end

  def create_matrix(alternate_lambda=nil)
    horizontal_aspect = @definition[@boundaries[0].to_sym]
    vertical_aspect   = @definition[@boundaries[1].to_sym]
    fabrication       = []

    raise "Aspect was nil, did you define hash collections for each boundary?" if horizontal_aspect.nil? or vertical_aspect.nil?

    horizontal_aspect.each do |h|
      vertical_aspect.each do|v|
        
        # If an alternate_lambda was provided...
        if not alternate_lambda.nil?
          fabrication.unshift(alternate_lambda.call(h,v))
          yield fabrication.first if block_given?
        # Otherwise, do the default action and wrap it in the tense-wrapping feature
        elsif not @default_action.nil?
          fabrication.unshift(@tense_wrapping_lambda.call(@default_action.call(h,v)))
          yield fabrication.first if block_given?
        end
        
      end
    end 
    
    return fabrication.reverse unless block_given?
  end
  
  # The matrix of nodes, represented as a string.
  
  def to_s
    @matrix.to_s
  end

  # The number of elements created in the the matrix.  For a 2x2 
  # matrix, this value would be 4.
  
  def length
    return create_matrix.length
  end
  
end