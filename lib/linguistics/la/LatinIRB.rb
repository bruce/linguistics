#!/usr/bin/env ruby

=begin rdoc

== Synopsis

LatinIRB:  An IRB-based environment for working with Latin::LatinVerbs items.  LatinIRB
provides a space for command-line based exploration of Latin Verbs following into the 
find standard paradigms described by Wheelock as:  1st, 2nd, 3rd, 3rd-"IO", and 4th conjugations.

Upon opening the script, the student may play with verbs offered for exploration.  These are the standard:

     Varible  :            Parts            : meaning
  * LatinVerb.   : amō   amāre  amāvī  amatum  : to love / like
  * @aSecond  : moneō monēre monvī  monitum : to warn / advise
  * @aThird   : agō   agere  ēgī    actum   : to do / lead / undertake
  * @aThirdIO : capiō capere cēpī   captum  : to grab / seize
  * @aFourth  : audiō audīre audīvī auditum : to hear

== Usage

./LatinIRB

== Viewing

The environment takes advantage of Ruby's UTF-8 support to display the verbs with macrons ( notation representing
tho quantity of the vowels ).  I recommend that you use urxvt ( what I use ) or Apple's Terminal.app for 
viewing these entries.

== Macrons

As mentioned above, to help in pronunciation, the LatinIRB, and the Latin:: module that provides its functions,
is macron aware.  Provided it is given macrons in the initialization ( see below ) it knows when to shorten
the macron and when to preserve it.  Character palette access for these glyphs is annoying.  Looking to
LaTeX I found an ASCII-based standard for macron entry and provide it here for use in entry.

The array of four principle parts can be gained by issuing the following:

  MacronConverter.new('\={e}duc\={o} \={e}duc\={a}re \={e}duc\={a}v\={\i} \={e}ducatus')
  
This can be passed to the LatinVerb constructor ( see below )

== Generating Verbs

Typically, in the code I have used the macron-ized character because Textmate and my Terminal of choice
both understand it.

  LatinVerb.new %w(amō   amāre  amāvī  amatum)

another way is:
  
   converted_metachar=MacronConverter.new('\={e}duc\={o} \={e}duc\={a}re \={e}duc\={a}v\={\i} \={e}ducatus')
   anLV=LatinVerb.new(converted_metachar.to_a)

Thereafter you can execute :
  anLV.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number #=> [ ēducatī, ēducatae, ēducata ] essēmus

== Executing Methods  

Every verb in latin is a "vector" comprised of the voice / mood / tense / number / and person

=== Chart View

To view the chart of a verb, use LatinVerb.chart_display.  This is a basic chart that will
look familiar to students.  

=== Singular Vector

As such methods are of the form 

  (active|passive)_voice_(indicative|subjunctive)_mood_(present|imperfect|perfect|pastperfect|futureperfect|etc.)tense_first_person_singular_number

This will return a single value.  Where the result is ambiguous ( e.g. 'number' is not provided ) multiple values are returned.
an exhaustive list of options follows below.

=== Multiplex Vectors

Several convenience methods exist which load multiple tenses at the same time such as "present system" or "perfect system".  These
methods load the tenses into the @collections iVar associated with the LatinVerb.  This value can be accessed as @collections
is shared per attr_reader

=== Chart View

By using the LatinDisplay.chart_view, a chart, much like what is found in verb references can be had for the verb.  This is a
_very_ handy method.

=== Comprehensive List of Singular Vectors

  * LatinVerb.active_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
             
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.active_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
             
  * LatinVerb.active_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)
   
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.passive_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
             
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.passive_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
             
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)    
  *          
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)                
  *          
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
             
             
  * LatinVerb.active_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
  *          
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
  * LatinVerb.passive_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
             
  * LatinVerb.imperatives[0].to_s)
  * LatinVerb.imperatives[1].to_s)
             
  * LatinVerb.present_active_participle )
  * LatinVerb.future_active_participle)
  * LatinVerb.perfect_passive_participle)
  * LatinVerb.future_passive_participle)
             
  * LatinVerb.present_active_infinitive.to_s)
  * LatinVerb.perfect_active_infinitive)
  * LatinVerb.future_active_infinitive)
  * LatinVerb.present_passive_infinitive)
  * LatinVerb.perfect_passive_infinitive)  
=end

require 'latin/LatinVerb'
require 'language/MacronConversions'
require 'irb'
require 'irb/completion'

include MacronConversions
include Latin

@aFirst   = Latin::LatinVerb.new %w(amō   amāre  amāvī  amatum)
@aSecond  = Latin::LatinVerb.new %w(moneō monēre monvī  monitum)
@aThird   = Latin::LatinVerb.new %w(agō   agere  ēgī    actum)
@aThirdIO = Latin::LatinVerb.new %w(capiō capere cēpī   captum)
@aFourth  = Latin::LatinVerb.new %w(audiō audīre audīvī auditum)

IRB.start    

=begin rdoc

== Conclusion

Enjoy and explore mundus latinae

== Author

Steven G. Harms ( sgharms@stevengharms.com )

== Thanks

Thanks to the Austin Ruby coders group who answered questions that helped me put this all together.  Thanks also
to the Reject^{2} conference at the Lone Star Ruby Conference 2008 who helped me think through some of the
metaprogrammatic approaches.  Thanks to Professor James Burleson of Austin Community College who insisted,
old-style, of a mastery of the rote basics of Latin.  Thanks also to Lauren Roth ( http://www.laurennroth.com)
for her support and encouragement and understanding of my pre-dawn hack sessions.
  
=end
