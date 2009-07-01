=begin rdoc

==DESCRIPTION

This is a method for storing the heuristics which are required to conjugate Latin verbs.

The methods are named in a voice_mood_tense vector ( e.g. active_indicative_present).

Class variables are used to allow speedy iteration thanks to Ruby's fantastic iterators.

Within the document I include references to the Wheelock chapter in which the structure
is mentioned.  The page references I cite are from the 6th Edition, Revised.

==AUTHOR

Steven G. Harms ( http://www.stevengharms.com)

=end

module Latin
  module Conjugation  
    
    ###############################################################################
    # Endings as module variables
    ###############################################################################
    
    # active_present_endings: ("ap_"-prefixed)
      @@ap_first_and_second_conjug_pers_endings = %w(s  t  mus  tis  nt)
      @@ap_third_conjug_pers_endings            = %w(o  is it   imus itis unt)
      @@ap_thirdIO_conjg_pers_endings           = %w(is it imus itis iunt)

    # active_imperfect_endings: ("ai_"-prefixed)
      @@ai_first_and_second_conjug_pers_endings = %w(bam bās bat bāmus bātis bant)
      @@ai_third_conjug_pers_endings            = %w(ēbam ēbās ēbat ēbāmus ēbātis ēbant)

    # active_future_endings: ("af_"-prefixed)
      @@af_one_two_endings = %w(bō bis bit bimus bitis bunt)
      @@af_other_endings   = %w(am ēs et ēmus ētis ent)

    # active_perfect_present: ("aperf"-prefixed)
      @@aperf_endings        = %w(istī it imus istis ērunt)
      @@aperf_past_endings   = @@pluperf_endings  = 
                               %w(eram erās erat erāmus erātis erant)
      @@aperf_future_endings = %w(erō eris erit erimus eritis erint)

    # passive endings
      @@passive_endings_first_and_second_conjg = 
        %w(r ris tur mur minī ntur)
      @@passive_endings_other                  =
        %w(r eris itur imur iminī untur)

      @@pass_perf_present_endings = %w(sum es est sumus estis sunt)    
      @@pass_perf_past_endings    = %w(eram erās erat erāmus erātis erant)
      @@pass_perf_future_endings  = %w(erō eris erit erimus eritis erint)

      @@pass_perf_subj_endings    = %w(sim sis sit simus sitis sint)    
      @@pass_pluperf_past_endings = %w(essem essēs esset essēmus essētis essent)

      
    # subjunctive tools
      # hash for getting a verb's subjunctive stem
      # based off the W[e] F[ea]r [A] L[ia]r mnemonic
      @@active_present_subjunctive_endings = {
        "1"   => lambda  { |x| return x + "ē"  },
        "2"   => lambda  { |x| return x + "eā" },
        "3"   => lambda  { |x| return x + "ā"  },
        "4"   => lambda  { |x| return x + "iā" },
        "3IO" => lambda  { |x| return x + "iā" }
      }
              
    ###############################################################################
    # Present System
    ###############################################################################

=begin rdoc

The canonical building block of learning to conjugate verbs in Latin.  Take the present
active infinitive, chop off the ending, and add the classic o,s,t,mus,tis,nt

Wheelock Reference, p. 4.  
  
=end    
    def active_indicative_present
      if @conjugation == "1" or 
         @conjugation == "2"
         return [ @first_pers_singular, 
               @@ap_first_and_second_conjug_pers_endings.collect{ |ending| Latin::LatinWord.new(@stem + ending)}
         ].flatten!
      elsif @conjugation == "3"
        return [ @@ap_third_conjug_pers_endings.collect{ |ending| Latin::LatinWord.new(stem + ending) } ].flatten!
      elsif @conjugation == "3IO" or 
            @conjugation=="4"
        return [ @first_pers_singular, 
                 @@ap_thirdIO_conjg_pers_endings.collect{ |ending| Latin::LatinWord.new(stem + ending) } 
               ].flatten!
       end
    end
  
=begin rdoc

Imperfect: Habitual action in the past.  The base + %w(bam bas bat bamus batis bant).

Wheelock Reference, p. 37.  

=end
    def active_indicative_imperfect
      if @conjugation == "1" or @conjugation == "2"
        return [@@ai_first_and_second_conjug_pers_endings.collect{|x| Latin::LatinWord.new(stem + x)}].flatten
      end
      if @conjugation == "3"
        return [@@ai_third_conjug_pers_endings.collect{|x| Latin::LatinWord.new(stem + x)}].flatten
      end
      if @conjugation=="3IO" or @conjugation=="4"
        [@@ai_third_conjug_pers_endings.collect do |x| 
          Latin::LatinWord.new(stem + "i" + x) end ].flatten!
      end
    end

    # Future action:  Future action.  The base + %w(bo bis bit bimus bitis bunt)
    def active_indicative_future
      if @conjugation == "1" or @conjugation=="2"
        return [@@af_one_two_endings.collect{|x| Latin::LatinWord.new(stem + x)}].flatten
      end    
      if @conjugation == "3"
        return [@@af_other_endings.collect{|x| Latin::LatinWord.new(stem + x)}].flatten
      end
      if @conjugation == "3IO" or @conjugation == "4"
        return [@@af_other_endings.collect{|x| Latin::LatinWord.new(stem + "i" + x)}].flatten
      end    
    end

    # Convenience method to pull all of the present system methods
    # and load their returns in an array
    def present_system
      storage = []
      
      storage << active_voice_indicative_mood_present_tense
      storage << active_voice_indicative_mood_imperfect_tense
      storage << active_voice_indicative_mood_future_tense
      
      return storage
    end

    ###############################################################################
    # Perfect System
    ###############################################################################

    # Action completed in the past
    # p. 77
    
    def active_indicative_perfect
      substem = @first_pers_perf[0..-2]
      return [@first_pers_perf.to_s, @@aperf_endings.collect{|x| substem+x.to_s}].flatten
    end
    
    # Action completed in the past
    # p. 77    

    def active_indicative_pastperfect
      substem = @first_pers_perf[0..-2]
       return [@@aperf_past_endings.collect{|x| substem+x}].flatten     
    end

    # Action completed in the past
    # p. 77
    
    def active_indicative_futureperfect
      substem = @first_pers_perf[0..-2]
      return [@@aperf_future_endings.collect{|x| substem+x}].flatten
    end
    
    # Convenience method to pull all of the perfect system methods
    # and load their returns in an array
     def perfect_system
       storage = []
       
       storage << active_voice_indicative_mood_perfect_tense
       storage << active_voice_indicative_mood_pastperfect_tense
       storage << active_voice_indicative_mood_futureperfect_tense
       
       return storage
     end

     def active_indicative
       present_system
       perfect_system
     end
     
     ###############################################################################
     # Present Passive System
     ###############################################################################
 
     # Passive voice, present tense
     # Wheelock, 117
     
     def passive_indicative_present
       if conjugation=="1" or conjugation=="2"
         local_pe=@@passive_endings_first_and_second_conjg.clone
         return [Latin::LatinWord.new(@first_pers_singular.to_s + "r"), 
           local_pe[1..-1].map{|x| Latin::LatinWord.new(@stem + x)}].flatten!
       end
       if conjugation=="3"
         return [Latin::LatinWord.new(@first_pers_singular+"r"), 
           @@passive_endings_other[1..-1].map{|x| Latin::LatinWord.new(stem + x)}].flatten!
       end
       if @conjugation == "3IO"
         base=stem+"i"
         return [Latin::LatinWord.new(@first_pers_singular+"r"), 
           @@passive_endings_other[1..-2].map{|x| Latin::LatinWord.new(stem + x)}, 
           Latin::LatinWord.new(base+@@passive_endings_other[-1])].flatten!
       end
       if @conjugation=="4"
         base=stem+"ī"
         return [Latin::LatinWord.new(@first_pers_singular+"r"), 
           @@passive_endings_first_and_second_conjg[1..-2].map{|x| Latin::LatinWord.new(base + x)},
           Latin::LatinWord.new(base+@@passive_endings_other[-1])].flatten!
       end
     end
     
     # Passive voice, present tense
     # Wheelock, 117     

     def passive_indicative_imperfect
       if conjugation=="1" or conjugation=="2"
         imperfect_stem = self.stem + "b\xc4\x81"
         return @@passive_endings_first_and_second_conjg.map{|x| Latin::LatinWord.new(imperfect_stem+x)}
       end
       if conjugation=="3" 
         ministem=self.stem + "ēbā"
         return @@passive_endings_first_and_second_conjg.map{|x| ministem + x}
       end
       if @conjugation == "3IO" or @conjugation=="4"
         base=stem+"iēbā"
         return [@@passive_endings_first_and_second_conjg.map{|x| base + x}].flatten!
       end
     end

     # Passive voice, present tense
     # Wheelock, 117
     
     def passive_indicative_future
       if conjugation=="1" or conjugation=="2"    
         fp_stem=@stem+"bi"
         standards = @@passive_endings_first_and_second_conjg[2..-1].map{|x| Latin::LatinWord.new(fp_stem + x)}
         standards.pop
         fp_stem.sub!(/.$/,'u')
         return [Latin::LatinWord.new(@stem + "b\xc5\x8dr"), 
           Latin::LatinWord.new(@stem + "beris"), standards, fp_stem+@@passive_endings_first_and_second_conjg.last].flatten!
       end
       if conjugation == "3"
         fp_stem=self.stem+"ē"
         standards = @@passive_endings_first_and_second_conjg[1..-1].map{|x| Latin::LatinWord.new(fp_stem + x)}
         return [Latin::LatinWord.new(@stem + "ar"), standards].flatten!      
       end
       if @conjugation == "3IO" or @conjugation=="4"
         ie_base=stem+"iē"
         return [Latin::LatinWord.new(stem+"ia"+@@passive_endings_first_and_second_conjg[0]), 
          @@passive_endings_first_and_second_conjg[1..-1].map{|x| Latin::LatinWord.new(ie_base + x)}].flatten!
       end    
     end     

     def passive_present_system
       storage = []

       storage << passive_voice_indicative_mood_present_tense
       storage << passive_voice_indicative_mood_imperfect_tense
       storage << passive_voice_indicative_mood_future_tense

       return storage
     end

     ###############################################################################
     # Present Passive System
     ###############################################################################
  
     # Action completed in the past
     # Wheelock, p. 122
     
      def passive_indicative_perfect
        @@pass_perf_present_endings.map{ |helping_verb| Latin::LatinWord.new("#{pass_perf_part} #{helping_verb}" ) }
      end

      # Action completed in the past
      # Wheelock, p. 122
      
      def passive_indicative_pastperfect
        @@pass_perf_past_endings.map{ |helping_verb| Latin::LatinWord.new("#{pass_perf_part} #{helping_verb}" ) }        
      end

      # Action completed in the past
      # Wheelock, p. 122

      def passive_indicative_futureperfect
        @@pass_perf_future_endings.map{ |helping_verb| Latin::LatinWord.new("#{pass_perf_part} #{helping_verb}" ) }
      end

      def passive_perfect_system
        storage = []

        storage << passive_voice_indicative_mood_perfect_tense
        storage << passive_voice_indicative_mood_pastperfect_tense
        storage << passive_voice_indicative_mood_futureperfect_tense

        return storage        
      end

      def passive_indicative
        present_system
        perfect_system
      end

     def indicative_mood
       present_system
       passive_present_system
       perfect_system
       passive_perfect_system
     end

     ###############################################################################
     # SUBJUNCTIVE MOOD
     ###############################################################################     
     
     # Active voice
     # Wheelock p. 187
     
     def active_subjunctive_present         
       if @conjugation =~ /^[12]/
         asp_base = @@active_present_subjunctive_endings[@conjugation].call(@stem[0..-2])
         return ['m',
            @@ap_first_and_second_conjug_pers_endings].flatten!.map do  |ending| 
              Latin::LatinWord.new(asp_base + ending) 
            end
        elsif @conjugation =~ /^3/ or @conjugation =~ /^4/
          asp_base = @@active_present_subjunctive_endings[@conjugation].call(@stem[0..-1])
           return ['m',
              @@ap_first_and_second_conjug_pers_endings].flatten!.map do  |ending| 
                Latin::LatinWord.new(asp_base + ending)          
           end
        else
          return @@active_present_subjunctive_endings
        end    
     end
     
     # Subjunctive mood, active voice, imperfect tense
     # Wheelock: p. 194
     
     def active_subjunctive_imperfect
       ['m', @@ap_first_and_second_conjug_pers_endings].flatten!.map do |ending| 
         Latin::LatinWord.new(@pres_act_inf + ending) 
       end 
     end
     
     # Subjunctive perfect
     # Wheelock 202
     
     def active_subjunctive_perfect
        asp_base = 
          Latin::LatinWord.new(first_pers_perf[0..first_pers_perf.length-2]) +
          "erī"
        return ['m', @@ap_first_and_second_conjug_pers_endings].flatten!.map do |ending|
          Latin::LatinWord.new(asp_base + ending)
        end
        
     end

     # Subjunctive perfect
     # Wheelock 203
          
     def active_subjunctive_pastperfect
       asp_base = @first_pers_perf[0..@first_pers_perf.length-2] + "issē"
       return ['m', @@ap_first_and_second_conjug_pers_endings].flatten!.map do |ending|
         Latin::LatinWord.new(asp_base + ending)
       end
     end

     def active_subjunctive_system
       storage = []

       storage << active_voice_subjunctive_mood_present_tense
       storage << active_voice_subjunctive_mood_imperfect_tense
       storage << active_voice_subjunctive_mood_perfect_tense
       storage << active_voice_subjunctive_mood_pastperfect_tense

       return storage
     end
     
     # Passive voice
     # Wheelock: p. 188
     def passive_subjunctive_present
       if @conjugation == "1" or @conjugation == "2"
         short_base = 
           @@active_present_subjunctive_endings[@conjugation].call(@stem[0..-2]) 
          return @@passive_endings_first_and_second_conjg.map do |ending| 
            Latin::LatinWord.new(short_base + ending)
          end
       elsif @conjugation =~ /^3/
         subjunctive_stem = @conjugation =~ /O$/i ? stem + "iā" : stem + "ā"
         return @@passive_endings_first_and_second_conjg.map do |ending|
           Latin::LatinWord.new(subjunctive_stem + ending)
         end
        elsif @conjugation =~ /^4/
          subjunctive_stem = stem + "iā"
          return @@passive_endings_first_and_second_conjg.map do |ending|
            Latin::LatinWord.new(subjunctive_stem + ending)
          end
        end
     end
    
     # Wheelock: 194
     def passive_subjunctive_imperfect
       base = Latin::LatinWord.new(@pres_act_inf.reverse).rest.reverse + "ē"
       return @@passive_endings_first_and_second_conjg.map do |ending| 
         Latin::LatinWord.new(base + ending)    
       end
     end

     # Wheelock: p. 203     
     def passive_subjunctive_perfect
       counter = -1
       @@pass_perf_subj_endings.map do |ending|
          counter += 1
          counter <=2 ? "[ #{perfect_passive_participle} ]" + " #{ending}" : 
            "[ #{pluralize_participial_listing(perfect_passive_participle)} ]" + 
            " #{ending}"
         end
     end
          
     # Wheelock: p. 203
     def passive_subjunctive_pastperfect
       counter = -1
       @@pass_pluperf_past_endings.map do |ending|
          counter += 1
          counter <=2 ? 
            "[ #{perfect_passive_participle} ]" + " " + ending : 
            "[ #{pluralize_participial_listing(perfect_passive_participle)} ]"+ 
            " " + ending
         end       
     end
     
     def passive_subjunctive_system
       storage = []

       storage << passive_voice_subjunctive_mood_present_tense
       storage << passive_voice_subjunctive_mood_imperfect_tense
       storage << passive_voice_subjunctive_mood_perfect_tense
       storage << passive_voice_subjunctive_mood_pastperfect_tense

       return storage
     end


     def subjunctive_mood
       subjunctive_active
       subjunctive_passive
     end    


     ###############################################################################
     # PARTICIPLES
     ###############################################################################
     
     def present_active_participle
       raise ("Bad nil") if  @participial_stem.nil?
       endings=%w(ns ntis)
       return endings.collect{ |x| Latin::LatinWord.new(@participial_stem+x.chomp)}.join(', ')
     end

     def future_active_participle
       mybase=@pass_perf_part.gsub(/u[sm]$/, "ūr")
       singular_endings=%w(us a um)
       return singular_endings.collect{|x| Latin::LatinWord.new(mybase+"#{x}".chomp)}.join(', ')

       return base
     end

     def perfect_passive_participle
       mybase=@pass_perf_part.sub(/u[sm]$/,'')
       singular_endings=%w(us a um)
       return singular_endings.collect{|x| Latin::LatinWord.new(mybase+"#{x}".chomp)}.join(', ')
     end

     def future_passive_participle
       mybase = participial_stem+"nd"
       singular_endings=%w(us a um)
       return singular_endings.collect{|x| Latin::LatinWord.new(mybase+"#{x}".chomp)}.join(', ')
     end

     def gerundive
       self.future_passive_participle
     end
     

     def participles
       @collections << {
         0 =>  ["Participles associated with:", definition_string],
         1 =>  ["Present Active Participle:"  , present_active_participle],
         2 =>  ["Future Active Participle:"   , future_active_participle],
         3 =>  ["Perfect Passive Participle"  , perfect_passive_participle],
         4 =>  ["Future Passive Participle"   , future_passive_participle]
        }     
        return @collections.last
     end     

     ###############################################################################
     # IMPERATIVES
     ###############################################################################     

     def imperatives
       return_hash=[]
       
       imperative_exceptions = {
         "ducere"   => %w(duc ducite),
         "dicere"   => %w(dic dicite),
         "facere"   => %w(fac facite),
         "ferre"    => %w(fer ferte),
         "nolere"   => %w(nolo nolite)
       }
       
       j = imperative_exceptions[@pres_act_inf].nil? ?
           nil :
           imperative_exceptions[@pres_act_inf]
         
       return j unless j.nil?
            
       if @pres_act_inf =~ /āre$/
         return_hash << [Latin::LatinWord.new(stem), Latin::LatinWord.new(stem+"te")]
       end                            
       if @pres_act_inf =~ /ēre$/       
         return_hash << [ Latin::LatinWord.new(stem), Latin::LatinWord.new(stem+"te")]
       end    
       if @pres_act_inf =~ /ere$/
         return_hash << [Latin::LatinWord.new(stem+"e"), Latin::LatinWord.new(stem+"ite")]
       end    
       if @pres_act_inf =~ /īre$/
         return_hash << [Latin::LatinWord.new(stem+"ī"), Latin::LatinWord.new(stem+"īte")]
       end
       
       @collections << return_hash.flatten!
       return @collections.last
       
     end     

     ###############################################################################
     # INFINITIVES
     ###############################################################################     
     def present_active_infinitive
       return @pres_act_inf
     end
     
     def perfect_active_infinitive
       return @first_pers_perf+"sse"
     end
     
     def future_active_infinitive
       return future_active_participle.sub(/,.*/,'') + " esse"
     end
     
     def present_passive_infinitive
       if @conjugation == "1"
         return  @pres_act_inf.gsub(/(.*)e$/,"\\1\xc4\xab")
       end
       if @conjugation == "2"
         return @pres_act_inf.gsub(/(.*)e$/,"\\1\xc4\xab")
       end    
       if @conjugation == "3IO"
           return @pres_act_inf.gsub(/(.*)ere$/,"\\1\xc4\xab")
       end
       if @conjugation == "3"
           return @pres_act_inf.gsub(/(.*)ere$/,"\\1\xc4\xab")
       end
       if @conjugation == "4"
         return @pres_act_inf.gsub(/(.*)e$/,"\\1\xc4\xab")
       end      
     end
     
     def perfect_passive_infinitive
       return perfect_passive_participle + " esse"
     end
     
     # Returns a hash that's enumerated 0-5.  Each one of those keys
     # points to an array.  The first element is a label, the second
     # element is the node.
     
     def infinitives
       @collections << {
         0 => ["Infinitives associated with:", definition_string ],
         1 => ["Present Active Infinitive:",   present_active_infinitive],
         2 => ["Perfect Active Infinitive:",   perfect_active_infinitive],
         3 => ["Future Active Infinitive:",    future_active_infinitive],
         4 => ["Present Passive Infinitive",   present_passive_infinitive],
         5 => ["Perfect Passive Infinitive",   perfect_passive_infinitive]
       }
       return @collections.last
     end
     
     # The big mamma-jamma, the one that loads up the verb in all phases and varieties
     def full_conjugation
       present_system
       perfect_system
       passive_present_system
       passive_perfect_system
       active_subjunctive_system
       passive_subjunctive_system
       imperatives
       participles
       infinitives
     end

     private
     
     # The singular endings change from singular to plural
     def pluralize_participial_listing(x)
       x.sub!(/us,/,   'ī,' )
       x.sub!(/a,/,    'ae,')
       x.sub!(/um.*$/, 'a'  )
     end       
  end # end module Conjugation
end # end module Latin
# >> ###############################################################################
