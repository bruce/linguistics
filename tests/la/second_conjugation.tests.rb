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
class LatinVerbSecondConjugationTestCase < Linguistics::TestCase
    
  def initialize( *args )
    super
    Linguistics::use( :la )
  end
  
  def test_0000_loaded
    assert_respond_to Linguistics::LA, :conjugate
  end
  def setup
    @aSecond = Latin::LatinVerb.new %w(moneō monēre monuī  monitum)
    
  end
  
  def test_display_call
    assert_nothing_raised(RuntimeError) { 
      @aSecond.full_conjugation
      @aSecond.display_full_listing  
     }
  end
  
  def test_exhaustive
        assert_equal("moneō",   @aSecond.active_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
        assert_equal("monēs",   @aSecond.active_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
        assert_equal("monet",   @aSecond.active_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
        assert_equal("monēmus", @aSecond.active_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
        assert_equal("monētis", @aSecond.active_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
        assert_equal("monent",  @aSecond.active_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                     
        assert_equal("monēbam",   @aSecond.active_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
        assert_equal("monēbās",   @aSecond.active_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
        assert_equal("monēbat",   @aSecond.active_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
        assert_equal("monēbāmus", @aSecond.active_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
        assert_equal("monēbātis", @aSecond.active_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
        assert_equal("monēbant",  @aSecond.active_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monēbō",    @aSecond.active_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
        assert_equal("monēbis",   @aSecond.active_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
        assert_equal("monēbit",   @aSecond.active_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
        assert_equal("monēbimus", @aSecond.active_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
        assert_equal("monēbitis", @aSecond.active_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
        assert_equal("monēbunt",  @aSecond.active_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
                     
        assert_equal("monuī",     @aSecond.active_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
        assert_equal("monuistī",  @aSecond.active_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
        assert_equal("monuit",    @aSecond.active_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
        assert_equal("monuimus",  @aSecond.active_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
        assert_equal("monuistis", @aSecond.active_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
        assert_equal("monuērunt", @aSecond.active_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monueram",   @aSecond.active_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
        assert_equal("monuerās",   @aSecond.active_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
        assert_equal("monuerat",   @aSecond.active_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
        assert_equal("monuerāmus", @aSecond.active_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
        assert_equal("monuerātis", @aSecond.active_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
        assert_equal("monuerant",  @aSecond.active_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monuerō",    @aSecond.active_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
        assert_equal("monueris",   @aSecond.active_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
        assert_equal("monuerit",   @aSecond.active_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
        assert_equal("monuerimus", @aSecond.active_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
        assert_equal("monueritis", @aSecond.active_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
        assert_equal("monuerint",  @aSecond.active_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)

    # Passive Present

        assert_equal("moneor",   @aSecond.passive_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
        assert_equal("monēris",  @aSecond.passive_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
        assert_equal("monētur",  @aSecond.passive_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
        assert_equal("monēmur",  @aSecond.passive_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
        assert_equal("monēminī", @aSecond.passive_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
        assert_equal("monentur", @aSecond.passive_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                     
        assert_equal("monēbar",    @aSecond.passive_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
        assert_equal("monēbāris",  @aSecond.passive_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
        assert_equal("monēbātur",  @aSecond.passive_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
        assert_equal("monēbāmur",  @aSecond.passive_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
        assert_equal("monēbāminī", @aSecond.passive_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
        assert_equal("monēbantur", @aSecond.passive_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monēbor",    @aSecond.passive_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
        assert_equal("monēberis",  @aSecond.passive_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
        assert_equal("monēbitur",  @aSecond.passive_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
        assert_equal("monēbimur",  @aSecond.passive_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
        assert_equal("monēbiminī", @aSecond.passive_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
        assert_equal("monēbuntur", @aSecond.passive_voice_indicative_mood_future_tense_third_person_plural_number.to_s)

    # Passive perfect
        assert_equal("monitum sum",   @aSecond.passive_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
        assert_equal("monitum es",    @aSecond.passive_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
        assert_equal("monitum est",   @aSecond.passive_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
        assert_equal("monitum sumus", @aSecond.passive_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
        assert_equal("monitum estis", @aSecond.passive_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
        assert_equal("monitum sunt",  @aSecond.passive_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)    
                     
        assert_equal("monitum eram",   @aSecond.passive_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
        assert_equal("monitum erās",   @aSecond.passive_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
        assert_equal("monitum erat",   @aSecond.passive_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
        assert_equal("monitum erāmus", @aSecond.passive_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
        assert_equal("monitum erātis", @aSecond.passive_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
        assert_equal("monitum erant",  @aSecond.passive_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)                
                     
        assert_equal("monitum erō",    @aSecond.passive_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
        assert_equal("monitum eris",   @aSecond.passive_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
        assert_equal("monitum erit",   @aSecond.passive_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
        assert_equal("monitum erimus", @aSecond.passive_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
        assert_equal("monitum eritis", @aSecond.passive_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
        assert_equal("monitum erint",  @aSecond.passive_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)

    ### Subjunctives
      # Active
        assert_equal("moneam",   @aSecond.active_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
        assert_equal("moneās",   @aSecond.active_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
        assert_equal("moneat",   @aSecond.active_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
        assert_equal("moneāmus", @aSecond.active_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
        assert_equal("moneātis", @aSecond.active_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
        assert_equal("moneant",  @aSecond.active_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                     
        assert_equal("monērem",   @aSecond.active_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
        assert_equal("monēres",   @aSecond.active_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
        assert_equal("monēret",   @aSecond.active_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
        assert_equal("monēremus", @aSecond.active_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
        assert_equal("monēretis", @aSecond.active_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
        assert_equal("monērent",  @aSecond.active_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monuerim",   @aSecond.active_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
        assert_equal("monuerīs",   @aSecond.active_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
        assert_equal("monuerit",   @aSecond.active_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
        assert_equal("monuerīmus", @aSecond.active_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
        assert_equal("monuerītis", @aSecond.active_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
        assert_equal("monuerint",  @aSecond.active_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                     
        assert_equal("monuissem",   @aSecond.active_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
        assert_equal("monuissēs",   @aSecond.active_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
        assert_equal("monuisset",   @aSecond.active_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
        assert_equal("monuissēmus", @aSecond.active_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
        assert_equal("monuissētis", @aSecond.active_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
        assert_equal("monuissent",  @aSecond.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)

      #passive
      assert_equal("monear",                              @aSecond.passive_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("moneāris",                            @aSecond.passive_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("moneātur",                            @aSecond.passive_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("moneāmur",                            @aSecond.passive_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("moneāminī",                           @aSecond.passive_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("moneantur",                           @aSecond.passive_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                   
      assert_equal("monērer",                             @aSecond.passive_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("monērēris",                           @aSecond.passive_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("monērētur",                           @aSecond.passive_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("monērēmur",                           @aSecond.passive_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("monērēminī",                          @aSecond.passive_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("monērentur",                          @aSecond.passive_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ monitus, monita, monitum ] sim",    @aSecond.passive_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("[ monitus, monita, monitum ] sis",    @aSecond.passive_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("[ monitus, monita, monitum ] sit",    @aSecond.passive_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("[ monitī, monitae, monita ] simus",   @aSecond.passive_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("[ monitī, monitae, monita ] sitis",   @aSecond.passive_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("[ monitī, monitae, monita ] sint",    @aSecond.passive_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ monitus, monita, monitum ] essem",  @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("[ monitus, monita, monitum ] essēs",  @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("[ monitus, monita, monitum ] esset",  @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("[ monitī, monitae, monita ] essēmus", @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("[ monitī, monitae, monita ] essētis", @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("[ monitī, monitae, monita ] essent",  @aSecond.passive_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
                   
      # Imperatives
      assert_equal("monē",   @aSecond.imperatives[0].to_s)
      assert_equal("monēte", @aSecond.imperatives[1].to_s)
                   
      # Participles
      assert_equal("monēns, monentis",                 @aSecond.present_active_participle )
      assert_equal("monitūrus, monitūra, monitūrum",   @aSecond.future_active_participle)
      assert_equal("monitus, monita, monitum",         @aSecond.perfect_passive_participle)
      assert_equal("monendus, monenda, monendum",      @aSecond.future_passive_participle)

      # Infinitves
      assert_equal("monēre",                        @aSecond.present_active_infinitive.to_s)
      assert_equal("monuīsse",                      @aSecond.perfect_active_infinitive)
      assert_equal("monitūrus esse",                @aSecond.future_active_infinitive)
      assert_equal("monērī",                          @aSecond.present_passive_infinitive)
      assert_equal("monitus, monita, monitum esse", @aSecond.perfect_passive_infinitive)    
  end              


end


