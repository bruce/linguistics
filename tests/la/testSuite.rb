unless defined? Linguistics::TestCase
	testsdir = File::dirname( File::dirname(File::expand_path( __FILE__ )) )
	$LOAD_PATH.unshift testsdir unless $LOAD_PATH.include?( testsdir )

	require 'lingtestcase'
end

require 'linguistics'

require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'
require 'testLatinWord'
require 'testUnicodeSafeString'
require 'testTenseBlock'
require 'testLatinVerb'
require 'first_conjugation.tests'
require 'second_conjugation.tests'
require 'third_conjugation.tests'
require 'third-io_conjugation.tests'
require 'fourth_conjugation.tests'


class TS_MyTests

  def initialize( *args )
    super
    Linguistics::use( :la )
  end

  def self.suite
    suite = Test::Unit::TestSuite.new
    suite << TestUnicodeSafeString.suite
    suite << TestLatinWord.suite
    suite << TestLanguageTenseBlock.suite
    suite << TestLatinVerb.suite
    suite << LatinVerbFirstConjugationTestCase.suite
    suite << LatinVerbSecondConjugationTestCase.suite
    suite << LatinVerbThirdConjugationTestCase.suite
    suite << LatinVerbThirdIOConjugationTestCase.suite
    suite << LatinVerbFourthConjugationTestCase.suite
    return suite
  end
end

Test::Unit::UI::Console::TestRunner.run(TS_MyTests)
