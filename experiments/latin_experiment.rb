#!/usr/bin/ruby

BEGIN {
	$LOAD_PATH.unshift File::dirname(File::dirname( __FILE__ )) + "/lib"
	require 'linguistics'
}

Linguistics::use( :la )

def divider
  79.times{print "#"}
  print  "\n"
end

aFirstConjugationVerbLatinVerb = "amō amāre amāvī amatum".la.conjugate

aFirstConjugationVerbLatinVerb.display_full_listing #=> Prints pretty chart to the screen
divider
puts aFirstConjugationVerbLatinVerb.active_voice_indicative_mood_perfect_tense_first_person_plural_number
divider
# Empty the collections cache
aFirstConjugationVerbLatinVerb.collections.shift
puts aFirstConjugationVerbLatinVerb.active_voice_indicative_mood_imperfect_tense
