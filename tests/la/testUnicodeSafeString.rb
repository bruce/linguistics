#!/usr/bin/env ruby 

unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )
	require 'lingtestcase'
end

require 'linguistics'

require 'linguistics/language/MacronConversions'
require 'linguistics/unicode/SGHUnicode'
require 'test/unit'

class TestUnicodeSafeString < Test::Unit::TestCase
  def setup
    # Setup 
    @testString=SGHUnicode::UnicodeSafeString.new("laudāre")
    @reverseString=SGHUnicode::UnicodeSafeString.new("monuī")
  end
  
  def test_simple  
    #Basic assignment test
    nullConstructor=SGHUnicode::UnicodeSafeString.new
    nullConstructor="foo"
    assert_equal("foo",nullConstructor)

    # Verify assignment / length / selected characters
    assert_equal("laudāre", @testString.to_s)
    assert_equal(7, @testString.length)
    assert_equal("d", @testString[3])
    assert_equal("ā", @testString[4])


    # Test simple ranges
    assert_equal("la", @testString[0..1])
    assert_equal("re", @testString[-2..-1])
    
    # Test out of bound condition

    assert_raise(RuntimeError){ @testString[300] }
    assert_raise(RuntimeError){ @testString[5..90] }
    assert_raise(RuntimeError){ @testString[-20..-10] }
    
    # Test reverse, overridden from String
    assert_equal("erādual",@testString.reverse)
  end
  
  def test_reverse
    assert_equal("īunom", @reverseString.reverse.to_s)
  end
end