unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )
	require 'lingtestcase'
end

require 'linguistics'

require "test/unit"
require "linguistics/language/TenseBlock"

class TestLanguageTenseBlock < Test::Unit::TestCase
  def test_case_name
    j=TenseBlock.new( {
                        :boundaries => 'persons by numbers',
                        :numbers    => %w(Singular Plural),
                        :persons    => %w(First Second Third),
                        :tense      => 'present',
                      } 
                    )
    #j.to_s #=> array of all the names, create_matrix called implicitly
    assert_equal("foo".class, j.to_s.class)

    # Iterate over the values that build the matrix of names
    # j.create_matrix{|x| puts x }
    
    # Override the default wrapping lambda
    #j.create_matrix( lambda { |x,y| "<<#{x}++#{y}>>" } ){|x| puts x }
    
    #puts j.matrix

  end
end