=begin rdoc

=Linguistics::LA

This module contains English-language linguistic functions for the Linguistics
module. It can be either loaded directly, or by passing some variant of 'la'
or 'lat' to the Linguistics::use method.

=end

module Linguistics::LA
  # Insert requires here
  
  Linguistics::DefaultLanguages << :la

	# Load in the secondary modules and add them to Linguistics::EN.
  require 'linguistics/la/LatinConjugation.rb'
  require 'linguistics/la/LatinDisplay.rb'
  require 'linguistics/la/LatinNode.rb'
  require 'linguistics/la/LatinTense.rb'
  require 'linguistics/la/LatinVerb.rb'
  require 'linguistics/la/LatinWord.rb'
  
  require 'linguistics/language/MacronConversions.rb'
  require 'linguistics/language/TenseBlock.rb'
  
  require 'linguistics/unicode/SGHUnicode.rb'
  
	###############
	module_function
	###############
	  
=begin rdoc

Conjugate takes a string which is assumed to be the four principal parts of a
Latin verb. If the verb is missing a part, as in the case of deponents or
other special cases, then the character - is to be passed

The string is broken apart to form the four principal parts that are expected
in the initalize routine of a LatinVerb object

=end
  
  def conjugate(verbString)
    processed_parts = Array.new
    verbString.split(/\s+/).each do |part| 
        ( part.to_s == "-" ) ? partprocessed_parts.push(nil) : processed_parts.push(part)
      end
    require 'pp'
    result = Latin::LatinVerb.new(processed_parts)
    result.full_conjugation
    return result
  end
end