unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )
	require 'lingtestcase'
end

require 'linguistics'

require "test/unit"
require "linguistics/la/LatinVerb"

class TestLatinVerb < Test::Unit::TestCase
  def setup
    @tLV1st = Latin::LatinVerb.new %w(amō   amāre  amāvī  amatum)
    @tLV2nd = Latin::LatinVerb.new %w(moneō monēre monvī  monitum)
    @tLV3rd = Latin::LatinVerb.new %w(agō   agere  ēgī    actum)
    @tLV3IO = Latin::LatinVerb.new %w(capiō capere cēpī   captum)
    @tLV4th = Latin::LatinVerb.new %w(audiō audīre audīvī auditum)    
  end
  
  def teardown
    tLV1st = tLV2nd = tLV3rd = tLV3IO = tLV4th = nil
  end
  
  def test_basics    
    assert_equal(4, @tLV1st.four_pp.length)
    assert_equal("Latin::LatinWord", @tLV1st.four_pp[3].class.to_s)
    
    # Test conjugation correctness
    assert_equal("1",   @tLV1st.conjugation)
    assert_equal("2",   @tLV2nd.conjugation)
    assert_equal("3",   @tLV3rd.conjugation)
    assert_equal("3IO", @tLV3IO.conjugation)
    assert_equal("4",   @tLV4th.conjugation)
  end

  def test_basic_retrieval1
     latTense =  @tLV1st.active_voice_subjunctive_mood_pastperfect_tense.pop
     assert_equal(6,latTense.aggregate_nodes.length)
     assert_equal("amāvissēmus",latTense.aggregate_nodes[3].to_s)
  end

  def test_basic_retrieval2
    assert_equal("amāvissent", @tLV1st.active_voice_subjunctive_mood_pastperfect_tense_third_person_plural_number.to_s) 
  end
  
  def test_basic_retrieval3
    assert_equal("amāvisset, amāvissent",  
      @tLV1st.active_voice_subjunctive_mood_pastperfect_tense_third_person[0])
  end

  def test_basic_retrieval4
    assert_equal("amāvissem, amāvissēs, amāvisset", 
      @tLV1st.active_voice_subjunctive_mood_pastperfect_tense_singular_number[0])
  end
  
  def test_full_listing
    @tLV1st = Latin::LatinVerb.new %w(amō   amāre  amāvī  amatum)
    @tLV1st.full_conjugation
    @tLV1st.display_full_listing
  end
  
  def test_validity_check     
    assert_raise(RuntimeError) { @deponent        = Latin::LatinVerb.new ["hortor", "hortārī", "hortātus sum"]  }
    assert_raise(RuntimeError) { @semideponent    = Latin::LatinVerb.new ["gaudeō", "gaudēre", "gāvīsus sum"] }
    assert_raise(RuntimeError) { @irregular_esse  = Latin::LatinVerb.new %w(sum esse fuī futūrum) }
    assert_raise(RuntimeError) { @irregular_nolo  = Latin::LatinVerb.new %w(nōlō nōlle nōluī) }
  end
  
end

