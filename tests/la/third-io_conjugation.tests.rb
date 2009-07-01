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
class LatinVerbThirdIOConjugationTestCase < Linguistics::TestCase
    
  def initialize( *args )
    super
    Linguistics::use( :la )
  end
  
  def test_0000_loaded
    assert_respond_to Linguistics::LA, :conjugate
  end

  def setup
    @aThirdIO = Latin::LatinVerb.new %w(capiō capere cēpī   captum)
    
  end
  
  def test_display_call
    assert_nothing_raised(RuntimeError) { 
      @aThirdIO.full_conjugation
      @aThirdIO.display_full_listing  
     }
  end

  def test_exhaustive
      assert_equal("capiō",      @aThirdIO.active_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("capis",      @aThirdIO.active_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("capit",      @aThirdIO.active_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("capimus",    @aThirdIO.active_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("capitis",    @aThirdIO.active_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("capiunt",    @aThirdIO.active_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                                 
      assert_equal("capiēbam",   @aThirdIO.active_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("capiēbās",   @aThirdIO.active_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("capiēbat",   @aThirdIO.active_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("capiēbāmus", @aThirdIO.active_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("capiēbātis", @aThirdIO.active_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("capiēbant",  @aThirdIO.active_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                                 
      assert_equal("capiam",     @aThirdIO.active_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
      assert_equal("capiēs",     @aThirdIO.active_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
      assert_equal("capiet",     @aThirdIO.active_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
      assert_equal("capiēmus",   @aThirdIO.active_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
      assert_equal("capiētis",   @aThirdIO.active_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
      assert_equal("capient",    @aThirdIO.active_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
                    
      assert_equal("cēpī",      @aThirdIO.active_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("cēpistī",   @aThirdIO.active_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("cēpit",     @aThirdIO.active_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("cēpimus",   @aThirdIO.active_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("cēpistis",  @aThirdIO.active_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("cēpērunt",  @aThirdIO.active_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)
                                
      assert_equal("cēperam",   @aThirdIO.active_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("cēperās",   @aThirdIO.active_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("cēperat",   @aThirdIO.active_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("cēperāmus", @aThirdIO.active_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("cēperātis", @aThirdIO.active_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("cēperant",  @aThirdIO.active_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)
                                
      assert_equal("cēperō",    @aThirdIO.active_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
      assert_equal("cēperis",   @aThirdIO.active_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
      assert_equal("cēperit",   @aThirdIO.active_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
      assert_equal("cēperimus", @aThirdIO.active_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
      assert_equal("cēperitis", @aThirdIO.active_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
      assert_equal("cēperint",  @aThirdIO.active_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
                    
  # Passive Present 
                    
      assert_equal("capior",        @aThirdIO.passive_voice_indicative_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("caperis",       @aThirdIO.passive_voice_indicative_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("capitur",       @aThirdIO.passive_voice_indicative_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("capimur",       @aThirdIO.passive_voice_indicative_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("capiminī",      @aThirdIO.passive_voice_indicative_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("capiuntur",     @aThirdIO.passive_voice_indicative_mood_present_tense_third_person_plural_number.to_s)
                                    
      assert_equal("capiēbār",      @aThirdIO.passive_voice_indicative_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("capiēbāris",    @aThirdIO.passive_voice_indicative_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("capiēbātur",    @aThirdIO.passive_voice_indicative_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("capiēbāmur",    @aThirdIO.passive_voice_indicative_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("capiēbāminī",   @aThirdIO.passive_voice_indicative_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("capiēbāntur",   @aThirdIO.passive_voice_indicative_mood_imperfect_tense_third_person_plural_number.to_s)
                                    
      assert_equal("capiar",        @aThirdIO.passive_voice_indicative_mood_future_tense_first_person_singular_number.to_s)
      assert_equal("capiēris",      @aThirdIO.passive_voice_indicative_mood_future_tense_second_person_singular_number.to_s)
      assert_equal("capiētur",      @aThirdIO.passive_voice_indicative_mood_future_tense_third_person_singular_number.to_s)
      assert_equal("capiēmur",      @aThirdIO.passive_voice_indicative_mood_future_tense_first_person_plural_number.to_s)
      assert_equal("capiēminī",     @aThirdIO.passive_voice_indicative_mood_future_tense_second_person_plural_number.to_s)
      assert_equal("capientur",     @aThirdIO.passive_voice_indicative_mood_future_tense_third_person_plural_number.to_s)
                                    
  # Passive perfect 
      assert_equal("captum sum",    @aThirdIO.passive_voice_indicative_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("captum es",     @aThirdIO.passive_voice_indicative_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("captum est",    @aThirdIO.passive_voice_indicative_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("captum sumus",  @aThirdIO.passive_voice_indicative_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("captum estis",  @aThirdIO.passive_voice_indicative_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("captum sunt",   @aThirdIO.passive_voice_indicative_mood_perfect_tense_third_person_plural_number.to_s)    
                                    
      assert_equal("captum eram",   @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("captum erās",   @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("captum erat",   @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("captum erāmus", @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("captum erātis", @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("captum erant",  @aThirdIO.passive_voice_indicative_mood_pastperfect_tense_third_person_plural_number.to_s)                
                                    
      assert_equal("captum erō",    @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_first_person_singular_number.to_s)
      assert_equal("captum eris",   @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_second_person_singular_number.to_s)
      assert_equal("captum erit",   @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_third_person_singular_number.to_s)
      assert_equal("captum erimus", @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_first_person_plural_number.to_s)
      assert_equal("captum eritis", @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_second_person_plural_number.to_s)
      assert_equal("captum erint",  @aThirdIO.passive_voice_indicative_mood_futureperfect_tense_third_person_plural_number.to_s)
                    
  ### Subjunctives  
    # Active        
      assert_equal("capiam",     @aThirdIO.active_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("capiās",     @aThirdIO.active_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("capiat",     @aThirdIO.active_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("capiāmus",   @aThirdIO.active_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("capiātis",   @aThirdIO.active_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("capiant",    @aThirdIO.active_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                                 
      assert_equal("caperem",    @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("caperes",    @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("caperet",    @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("caperemus",  @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("caperetis",  @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("caperent",   @aThirdIO.active_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                                 
      assert_equal("cēperim",    @aThirdIO.active_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("cēperīs",    @aThirdIO.active_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("cēperit",    @aThirdIO.active_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("cēperīmus",  @aThirdIO.active_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("cēperītis",  @aThirdIO.active_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("cēperint",   @aThirdIO.active_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                                 
      assert_equal("cēpissem",   @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("cēpissēs",   @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("cēpisset",   @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("cēpissēmus", @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("cēpissētis", @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("cēpissent",  @aThirdIO.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
                   
      #passive     
      assert_equal("capiar",                           @aThirdIO.passive_voice_subjunctive_mood_present_tense_first_person_singular_number.to_s)
      assert_equal("capiāris",                         @aThirdIO.passive_voice_subjunctive_mood_present_tense_second_person_singular_number.to_s)
      assert_equal("capiātur",                         @aThirdIO.passive_voice_subjunctive_mood_present_tense_third_person_singular_number.to_s)
      assert_equal("capiāmur",                         @aThirdIO.passive_voice_subjunctive_mood_present_tense_first_person_plural_number.to_s)
      assert_equal("capiāminī",                        @aThirdIO.passive_voice_subjunctive_mood_present_tense_second_person_plural_number.to_s)
      assert_equal("capiantur",                        @aThirdIO.passive_voice_subjunctive_mood_present_tense_third_person_plural_number.to_s)
                   
      assert_equal("caperer",                          @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_first_person_singular_number.to_s)
      assert_equal("caperēris",                        @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_second_person_singular_number.to_s)
      assert_equal("caperētur",                        @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_third_person_singular_number.to_s)
      assert_equal("caperēmur",                        @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_first_person_plural_number.to_s)
      assert_equal("caperēminī",                       @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_second_person_plural_number.to_s)
      assert_equal("caperentur",                       @aThirdIO.passive_voice_subjunctive_mood_imperfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ captus, capta, captum ] sim",    @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_first_person_singular_number.to_s)
      assert_equal("[ captus, capta, captum ] sis",    @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_second_person_singular_number.to_s)
      assert_equal("[ captus, capta, captum ] sit",    @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_third_person_singular_number.to_s)
      assert_equal("[ captī, captae, capta ] simus",   @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_first_person_plural_number.to_s)
      assert_equal("[ captī, captae, capta ] sitis",   @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_second_person_plural_number.to_s)
      assert_equal("[ captī, captae, capta ] sint",    @aThirdIO.passive_voice_subjunctive_mood_perfect_tense_third_person_plural_number.to_s)
                   
      assert_equal("[ captus, capta, captum ] essem",  @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_first_person_singular_number.to_s)
      assert_equal("[ captus, capta, captum ] essēs",  @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_second_person_singular_number.to_s)
      assert_equal("[ captus, capta, captum ] esset",  @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_third_person_singular_number.to_s)
      assert_equal("[ captī, captae, capta ] essēmus", @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_first_person_plural_number.to_s)
      assert_equal("[ captī, captae, capta ] essētis", @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_second_person_plural_number.to_s)
      assert_equal("[ captī, captae, capta ] essent",  @aThirdIO.passive_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s)
                   
      # Imperatives
      assert_equal("cape",   @aThirdIO.imperatives[0].to_s)
      assert_equal("capite", @aThirdIO.imperatives[1].to_s)
                   
      # Participles
      assert_equal("capiēns, capientis",             @aThirdIO.present_active_participle )
      assert_equal("captūrus, captūra, captūrum",    @aThirdIO.future_active_participle)
      assert_equal("captus, capta, captum",          @aThirdIO.perfect_passive_participle)
      assert_equal("capiendus, capienda, capiendum", @aThirdIO.future_passive_participle)
                   
      # Infinitves 
      assert_equal("capere",                     @aThirdIO.present_active_infinitive.to_s)
      assert_equal("cēpīsse",                    @aThirdIO.perfect_active_infinitive)
      assert_equal("captūrus esse",              @aThirdIO.future_active_infinitive)
      assert_equal("capī",                       @aThirdIO.present_passive_infinitive)
      assert_equal("captus, capta, captum esse", @aThirdIO.perfect_passive_infinitive)    
  end  

end


