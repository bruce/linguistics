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
class LatinVerbThirdConjugationTestCase < Linguistics::TestCase
    
  def initialize( *args )
    super
    Linguistics::use( :la )
  end
  
  def test_0000_loaded
    assert_respond_to Linguistics::LA, :conjugate
  end

  def setup
    @aThird = Latin::LatinVerb.new %w(agō   agere  ēgī    actum)
    
  end
  
  def test_display_call
    assert_nothing_raised(RuntimeError) { 
      @aThird.full_conjugation
      @aThird.display_full_listing  
     }
  end
  
  def test_exhaustive
      assert_equal("ago",      @aThird.active_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("agis",     @aThird.active_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("agit",     @aThird.active_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("agimus",   @aThird.active_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("agitis",   @aThird.active_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("agunt",    @aThird.active_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                               
      assert_equal("agēbam",   @aThird.active_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("agēbās",   @aThird.active_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("agēbat",   @aThird.active_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("agēbāmus", @aThird.active_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("agēbātis", @aThird.active_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("agēbant",  @aThird.active_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                               
      assert_equal("agam",     @aThird.active_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
      assert_equal("agēs",     @aThird.active_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
      assert_equal("aget",     @aThird.active_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
      assert_equal("agēmus",   @aThird.active_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
      assert_equal("agētis",   @aThird.active_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
      assert_equal("agent",    @aThird.active_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
                    
      assert_equal("ēgī",      @aThird.active_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("ēgistī",   @aThird.active_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("ēgit",     @aThird.active_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("ēgimus",   @aThird.active_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("ēgistis",  @aThird.active_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("ēgērunt",  @aThird.active_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)
                               
      assert_equal("ēgeram",   @aThird.active_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("ēgerās",   @aThird.active_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("ēgerat",   @aThird.active_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("ēgerāmus", @aThird.active_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("ēgerātis", @aThird.active_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("ēgerant",  @aThird.active_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)
                               
      assert_equal("ēgerō",    @aThird.active_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
      assert_equal("ēgeris",   @aThird.active_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
      assert_equal("ēgerit",   @aThird.active_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
      assert_equal("ēgerimus", @aThird.active_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
      assert_equal("ēgeritis", @aThird.active_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
      assert_equal("ēgerint",  @aThird.active_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
                    
  # Passive Present 
                    
      assert_equal("agor",      @aThird.passive_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("ageris",    @aThird.passive_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("agitur",    @aThird.passive_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("agimur",    @aThird.passive_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("agiminī",   @aThird.passive_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("aguntur",   @aThird.passive_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                                
      assert_equal("agēbār",    @aThird.passive_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("agēbāris",  @aThird.passive_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("agēbātur",  @aThird.passive_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("agēbāmur",  @aThird.passive_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("agēbāminī", @aThird.passive_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("agēbāntur", @aThird.passive_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                                
      assert_equal("agar",      @aThird.passive_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
      assert_equal("agēris",    @aThird.passive_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
      assert_equal("agētur",    @aThird.passive_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
      assert_equal("agēmur",    @aThird.passive_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
      assert_equal("agēminī",   @aThird.passive_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
      assert_equal("agentur",   @aThird.passive_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
                    
  # Passive perfect 
      assert_equal("actum sum",    @aThird.passive_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("actum es",     @aThird.passive_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("actum est",    @aThird.passive_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("actum sumus",  @aThird.passive_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("actum estis",  @aThird.passive_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("actum sunt",   @aThird.passive_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)    
                                   
      assert_equal("actum eram",   @aThird.passive_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("actum erās",   @aThird.passive_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("actum erat",   @aThird.passive_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("actum erāmus", @aThird.passive_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("actum erātis", @aThird.passive_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("actum erant",  @aThird.passive_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)                
                                   
      assert_equal("actum erō",    @aThird.passive_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
      assert_equal("actum eris",   @aThird.passive_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
      assert_equal("actum erit",   @aThird.passive_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
      assert_equal("actum erimus", @aThird.passive_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
      assert_equal("actum eritis", @aThird.passive_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
      assert_equal("actum erint",  @aThird.passive_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
                    
  ### Subjunctives  
    # Active        
      assert_equal("agam",      @aThird.active_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("agās",      @aThird.active_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("agat",      @aThird.active_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("agāmus",    @aThird.active_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("agātis",    @aThird.active_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("agant",     @aThird.active_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                                
      assert_equal("agerem",    @aThird.active_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("ageres",    @aThird.active_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("ageret",    @aThird.active_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("ageremus",  @aThird.active_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("ageretis",  @aThird.active_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("agerent",   @aThird.active_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                                
      assert_equal("ēgerim",    @aThird.active_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("ēgerīs",    @aThird.active_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("ēgerit",    @aThird.active_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("ēgerīmus",  @aThird.active_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("ēgerītis",  @aThird.active_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("ēgerint",   @aThird.active_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                                
      assert_equal("ēgissem",   @aThird.active_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("ēgissēs",   @aThird.active_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("ēgisset",   @aThird.active_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("ēgissēmus", @aThird.active_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("ēgissētis", @aThird.active_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("ēgissent",  @aThird.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
                   
      #passive     
      assert_equal("agar",                          @aThird.passive_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("agāris",                        @aThird.passive_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("agātur",                        @aThird.passive_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("agāmur",                        @aThird.passive_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("agāminī",                       @aThird.passive_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("agantur",                       @aThird.passive_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                   
      assert_equal("agerer",                        @aThird.passive_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("agerēris",                      @aThird.passive_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("agerētur",                      @aThird.passive_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("agerēmur",                      @aThird.passive_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("agerēminī",                     @aThird.passive_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("agerentur",                     @aThird.passive_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ actus, acta, actum ] sim",    @aThird.passive_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("[ actus, acta, actum ] sis",    @aThird.passive_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("[ actus, acta, actum ] sit",    @aThird.passive_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("[ actī, actae, acta ] simus",   @aThird.passive_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("[ actī, actae, acta ] sitis",   @aThird.passive_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("[ actī, actae, acta ] sint",    @aThird.passive_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ actus, acta, actum ] essem",  @aThird.passive_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("[ actus, acta, actum ] essēs",  @aThird.passive_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("[ actus, acta, actum ] esset",  @aThird.passive_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("[ actī, actae, acta ] essēmus", @aThird.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("[ actī, actae, acta ] essētis", @aThird.passive_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("[ actī, actae, acta ] essent",  @aThird.passive_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
                   
      # Imperatives
      assert_equal("age",   @aThird.imperatives[0].to_s)
      assert_equal("agite", @aThird.imperatives[1].to_s)
                   
      # Participles
      assert_equal("agens, agentis",           @aThird.present_active_participle )
      assert_equal("actūrus, actūra, actūrum", @aThird.future_active_participle)
      assert_equal("actus, acta, actum",       @aThird.perfect_passive_participle)
      assert_equal("agendus, agenda, agendum", @aThird.future_passive_participle)
                   
      # Infinitves 
      assert_equal("agere",                   @aThird.present_active_infinitive.to_s)
      assert_equal("ēgīsse",                  @aThird.perfect_active_infinitive)
      assert_equal("actūrus esse",            @aThird.future_active_infinitive)
      assert_equal("agī",                     @aThird.present_passive_infinitive)
      assert_equal("actus, acta, actum esse", @aThird.perfect_passive_infinitive)    
  end
end


