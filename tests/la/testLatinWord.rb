unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )
	require 'lingtestcase'
end

require 'linguistics'

require "test/unit"
require "linguistics/la/LatinWord"

class TestLatinWord < Test::Unit::TestCase
  def initialize( *args )
    super
    Linguistics::use( :la )
  end
  
  def test_case_name
    k=Latin::LatinWord.new("tezzzōaestēixēndyzēntpdqō1234568īm")

    # Make sure assignment worked
    assert_not_nil(k)
    
    # Make sure the macron rules were enforced
    assert_equal('o',k[5])
    assert_equal('i',k[k.length-2])


    flunk("Should have found multibyte") unless k.multibyte?
    
  end
end