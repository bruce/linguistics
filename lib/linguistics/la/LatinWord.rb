# == Synopsis
#
# Latin : A  module for dealing with textual issues around manipulation of strings containing Latin words
#
# == Usage
#
#  load 'latin/LatinSting.rb'
#
# == Description
#
# The class provides the class LatinString. 
# 
# == Example Code
#
#   load 'language/MacronConversions.rb'
#
# == Inherits From
#
#   SGHUnicode::UnicodeSafeString
#
# == Dependencies
#
# None
#
# == Author
#
# Steven G. Harms, http://www.stevengharms.com
#

require 'linguistics/unicode/SGHUnicode'

module Latin
  class LatinWord < SGHUnicode::UnicodeSafeString
    
    @@macron_table = {"\xc4\x81" => 'a', 
                      "\xc4\x93" => 'e',
                      "\xc4\xab" => 'i',
                      "\xc5\x8d" => 'o',
                      "\xc5\xab" => 'u',
                      "\xc4\x80" => 'A',
                      "\xc4\x92" => 'E',
                      "\xc4\xaa" => 'I',
                      "\xc5\x8c" => 'O',
                      "\xc5\xaa" => 'U',
                      }
    
    attr_reader :ending
    
    def initialize(*construct)
      super(*construct)
      fix_macrons!
    end

    # Gets the last three characters of a latinWord.  This is useful
    # when evaluating the endings of verbs.
    
    def get_last_three_characters(mode=:string, *aString)
      source_array=to_a[-3,3]
      if mode.to_sym == :string
        return source_array.to_s
      elsif mode.to_sym == :array
        return source_array
      end
    end
  
    # This “fixes”  the macrons in a string as defined in Wheelock's 
    # introduction.  Per the text there are three occasions where the
    # long sound of a macron must be shortened.
    #
    # Three rules:  Long vowels are shortened when they are followed
    # 1.  by another vowel
    # 2.  by m/r/t at the end of a word
    # 3.  by nt or nd anywhere
    
    def fix_macrons!
       # Get a mutable copy
       mutator = Array.new(@sanitized_array)

       # Vowels       
       @sanitized_array.each_with_index do |e, i|
         next if multibyte_locations[i] == 0
         if is_a_vowel(@sanitized_array[i+1])
           mutator[i] = @@macron_table[e]
         end
       end

       # m/r/t
       if @sanitized_array.last =~ /[mrt]/
         unless @@macron_table[@sanitized_array[length-2]].nil?
           mutator[length-2]=@@macron_table[mutator[length-2]]
         end         
       end
       
       #n[td]
       @sanitized_array.each_with_index do |e, i|
         if e == "n" and 
            @sanitized_array[i+1] =~ /[td]/ and not
             @@macron_table[@sanitized_array[i-1]].nil?
           mutator[i-1]=@@macron_table[@sanitized_array[i-1]]
         end
       end
       
       evaluate_string(mutator.to_s)
    end

    def unpack(pattern)
      return @USS.unpack(pattern)
    end
    
    def gsub(pattern, replacement)
      return @USS.gsub(pattern, replacement)
    end

    def sub(pattern, replacement)
      return @USS.sub(pattern, replacement)
    end
    
    def =~(pat)
      return @USS.match(pat)
    end
    
    def +(component)
      return @USS + component
    end
    
    def unpack(formatter)
      return @USS.unpack(formatter)
    end
    
    def sub!(pattern,replacement)
      evaluate_string(@USS.sub(pattern,replacement))
    end
    
    def match(pattern)
      return @USS.match(pattern)
    end
    
    def to_s
      return @USS
    end

##############################################################################
# PRIVATE METHODS
##############################################################################
    
    private 
    
    def is_a_vowel(c)
      return true  if c =~ /[aeiou]/i 
      return false if @@macron_table[c].nil?
      return true  if @@macron_table[c] != nil
      return false
    end


  end
end

