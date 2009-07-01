#!/usr/bin/ruby -w
#
# Unit test for (Latin Verb Conjugation:  First conjugation:  /.*āre/.  
# Canonical example:  laudāre:  to praise) 
#
# Copyright (c) (2008-9) Steven G. Harms
# 

unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )
	require 'lingtestcase'
end

require 'linguistics'

### This test case tests ...
class LatinVerbFirstConjugationTestCase < Linguistics::TestCase
    
  def initialize( *args )
    super
    Linguistics::use( :la )
  end
  
  def test_0000_loaded
    assert_respond_to Linguistics::LA, :conjugate
  end

  def setup
    @aFirst = Latin::LatinVerb.new %w(amō amāre amāvī amatum)
    raise RuntimeException unless @aFirst
  end

  def teardown
    aFirst=0
  end

  def test_display_call
    assert_nothing_raised(RuntimeError) { 
      @aFirst.full_conjugation
      @aFirst.display_full_listing  
     }
  end

  def test_nodes_exhaustively
    assert_equal("amō",         @aFirst.active_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
    assert_equal("amās",        @aFirst.active_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
    assert_equal("amat",        @aFirst.active_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
    assert_equal("amāmus",      @aFirst.active_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
    assert_equal("amātis",      @aFirst.active_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
    assert_equal("amant",       @aFirst.active_voice_indicative_mood_present_tense_third_person_plural_number.to_s)

    assert_equal("amābam",      @aFirst.active_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
    assert_equal("amābās",      @aFirst.active_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
    assert_equal("amābat",      @aFirst.active_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
    assert_equal("amābāmus",    @aFirst.active_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
    assert_equal("amābātis",    @aFirst.active_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
    assert_equal("amābant",     @aFirst.active_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)

    assert_equal("amābō",       @aFirst.active_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
    assert_equal("amābis",      @aFirst.active_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
    assert_equal("amābit",      @aFirst.active_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
    assert_equal("amābimus",    @aFirst.active_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
    assert_equal("amābitis",    @aFirst.active_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
    assert_equal("amābunt",     @aFirst.active_voice_indicative_mood_future_tense_third_person_plural_number.to_s)

    assert_equal("amāvī",       @aFirst.active_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
    assert_equal("amāvistī",    @aFirst.active_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
    assert_equal("amāvit",      @aFirst.active_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
    assert_equal("amāvimus",    @aFirst.active_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
    assert_equal("amāvistis",   @aFirst.active_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
    assert_equal("amāvērunt",   @aFirst.active_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)

    assert_equal("amāveram",    @aFirst.active_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
    assert_equal("amāverās",    @aFirst.active_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
    assert_equal("amāverat",    @aFirst.active_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
    assert_equal("amāverāmus",  @aFirst.active_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
    assert_equal("amāverātis",  @aFirst.active_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
    assert_equal("amāverant",   @aFirst.active_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)

    assert_equal("amāverō",     @aFirst.active_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
    assert_equal("amāveris",    @aFirst.active_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
    assert_equal("amāverit",    @aFirst.active_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
    assert_equal("amāverimus",  @aFirst.active_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
    assert_equal("amāveritis",  @aFirst.active_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
    assert_equal("amāverint",   @aFirst.active_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)

# Passive Present

    assert_equal("amor",        @aFirst.passive_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
    assert_equal("amāris",      @aFirst.passive_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
    assert_equal("amātur",      @aFirst.passive_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
    assert_equal("amāmur",      @aFirst.passive_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
    assert_equal("amāminī",     @aFirst.passive_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
    assert_equal("amantur",     @aFirst.passive_voice_indicative_mood_present_tense_third_person_plural_number.to_s)

    assert_equal("amābar",      @aFirst.passive_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
    assert_equal("amābāris",    @aFirst.passive_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
    assert_equal("amābātur",    @aFirst.passive_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
    assert_equal("amābāmur",    @aFirst.passive_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
    assert_equal("amābāminī",   @aFirst.passive_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
    assert_equal("amābantur",   @aFirst.passive_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)

    assert_equal("amābor",      @aFirst.passive_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
    assert_equal("amāberis",    @aFirst.passive_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
    assert_equal("amābitur",    @aFirst.passive_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
    assert_equal("amābimur",    @aFirst.passive_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
    assert_equal("amābiminī",   @aFirst.passive_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
    assert_equal("amābuntur",   @aFirst.passive_voice_indicative_mood_future_tense_third_person_plural_number.to_s)

# Passive perfect
    assert_equal("amatum sum",   @aFirst.passive_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
    assert_equal("amatum es",    @aFirst.passive_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
    assert_equal("amatum est",   @aFirst.passive_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
    assert_equal("amatum sumus", @aFirst.passive_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
    assert_equal("amatum estis", @aFirst.passive_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
    assert_equal("amatum sunt",  @aFirst.passive_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)    

    assert_equal("amatum eram",    @aFirst.passive_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
    assert_equal("amatum erās",    @aFirst.passive_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
    assert_equal("amatum erat",    @aFirst.passive_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
    assert_equal("amatum erāmus",  @aFirst.passive_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
    assert_equal("amatum erātis",  @aFirst.passive_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
    assert_equal("amatum erant",   @aFirst.passive_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)                

    assert_equal("amatum erō",     @aFirst.passive_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
    assert_equal("amatum eris",    @aFirst.passive_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
    assert_equal("amatum erit",    @aFirst.passive_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
    assert_equal("amatum erimus",  @aFirst.passive_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
    assert_equal("amatum eritis",  @aFirst.passive_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
    assert_equal("amatum erint",   @aFirst.passive_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)

### Subjunctives
  # Active
    assert_equal("amem",         @aFirst.active_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
    assert_equal("amēs",         @aFirst.active_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
    assert_equal("amet",         @aFirst.active_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
    assert_equal("amēmus",       @aFirst.active_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
    assert_equal("amētis",       @aFirst.active_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
    assert_equal("ament",        @aFirst.active_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)

    assert_equal("amārem",       @aFirst.active_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
    assert_equal("amāres",       @aFirst.active_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
    assert_equal("amāret",       @aFirst.active_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
    assert_equal("amāremus",     @aFirst.active_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
    assert_equal("amāretis",     @aFirst.active_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
    assert_equal("amārent",      @aFirst.active_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)

    assert_equal("amāverim",     @aFirst.active_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
    assert_equal("amāverīs",     @aFirst.active_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
    assert_equal("amāverit",     @aFirst.active_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
    assert_equal("amāverīmus",   @aFirst.active_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
    assert_equal("amāverītis",   @aFirst.active_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
    assert_equal("amāverint",    @aFirst.active_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)

    assert_equal("amāvissem",    @aFirst.active_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
    assert_equal("amāvissēs",    @aFirst.active_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
    assert_equal("amāvisset",    @aFirst.active_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
    assert_equal("amāvissēmus",  @aFirst.active_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
    assert_equal("amāvissētis",  @aFirst.active_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
    assert_equal("amāvissent",   @aFirst.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)

  #passive
  assert_equal("amer",                             @aFirst.passive_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
  assert_equal("amēris",                           @aFirst.passive_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
  assert_equal("amētur",                           @aFirst.passive_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
  assert_equal("amēmur",                           @aFirst.passive_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
  assert_equal("amēminī",                          @aFirst.passive_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
  assert_equal("amentur",                          @aFirst.passive_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)

  assert_equal("amārer",                           @aFirst.passive_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
  assert_equal("amārēris",                         @aFirst.passive_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
  assert_equal("amārētur",                         @aFirst.passive_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
  assert_equal("amārēmur",                         @aFirst.passive_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
  assert_equal("amārēminī",                        @aFirst.passive_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
  assert_equal("amārentur",                        @aFirst.passive_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)

  assert_equal("[ amatus, amata, amatum ] sim",    @aFirst.passive_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
  assert_equal("[ amatus, amata, amatum ] sis",    @aFirst.passive_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
  assert_equal("[ amatus, amata, amatum ] sit",    @aFirst.passive_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
  assert_equal("[ amatī, amatae, amata ] simus",   @aFirst.passive_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
  assert_equal("[ amatī, amatae, amata ] sitis",   @aFirst.passive_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
  assert_equal("[ amatī, amatae, amata ] sint",    @aFirst.passive_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)

  assert_equal("[ amatus, amata, amatum ] essem",  @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
  assert_equal("[ amatus, amata, amatum ] essēs",  @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
  assert_equal("[ amatus, amata, amatum ] esset",  @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
  assert_equal("[ amatī, amatae, amata ] essēmus", @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
  assert_equal("[ amatī, amatae, amata ] essētis", @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
  assert_equal("[ amatī, amatae, amata ] essent",  @aFirst.passive_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)

  # Imperatives
  assert_equal("amā",    @aFirst.imperatives[0].to_s)
  assert_equal("amāte",  @aFirst.imperatives[1].to_s)

  # Participles
  assert_equal("amāns, amantis",                @aFirst.present_active_participle )
  assert_equal("amatūrus, amatūra, amatūrum",   @aFirst.future_active_participle)
  assert_equal("amatus, amata, amatum",         @aFirst.perfect_passive_participle)
  assert_equal("amandus, amanda, amandum",      @aFirst.future_passive_participle)

  # Infinitves
  assert_equal("amāre", @aFirst.present_active_infinitive.to_s)
  assert_equal("amāvīsse", @aFirst.perfect_active_infinitive)
  assert_equal("amatūrus esse", @aFirst.future_active_infinitive)
  assert_equal("amārī", @aFirst.present_passive_infinitive)
  assert_equal("amatus, amata, amatum esse", @aFirst.perfect_passive_infinitive)
  end
end


