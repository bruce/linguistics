# == Synopsis
#
# MacronConversions:  module providing classes to convert macron (dis-)enabled strings into the opposite.
#
# == Usage
#
#  load 'language/MacronConversions.rb'
#
# == Description
#
# The class provides two classes: MacronConverter and MacronDeConverter.  In the event that you need to transform LaTeX-style markep into entities of some 
# sort, use the former class.  In the event that you need to down-sample macron-characters into LaTeX-style, use the latter.
# 
# == Example Code
#
#   load 'language/MacronConversions.rb'
#
#   # Basic conversion and advanced conversion
#
#   puts MacronConversions::MacronConverter.new("mon\\={e}re", 'mc')
#   puts MacronConversions::MacronConverter.new('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc')
#   
#   # Vanilla de-conversion
#   puts MacronConversions::MacronDeConverter.new("vanilla")
#   
#   # Complex de-conversion
#   puts MacronConversions::MacronDeConverter.new("laudāre")
#   
#   # Coup de grace
#   puts MacronConversions::MacronDeConverter.new(
#     MacronConversions::MacronConverter.new('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc').to_s)
#
# == Dependencies
#
# Requires the 'unicode/SGHUnicode' module
#
# == Author
#
# Steven G. Harms, http://www.stevengharms.com

module MacronConversions 
  require 'linguistics/unicode/SGHUnicode'
  
  LATEX_TO_MACRONS_CHARACTERS = {
    "\\={a}"   => "ā",
    "\\={e}"   => "ē",
    "\\={\\i}" => "ī",
    "\\={o}"   => "ō",
    "\\={u}"   => "ū",
    "\\={A}"   => "Ā",
    "\\={E}"   => "Ē",
    "\\={\\I}" => "Ī",
    "\\={O}"   => "Ō",
    "\\={U}"   => "Ū",
  }
  
  LATEX_TO_UTF8 ={
    "\\={a}"   => "\\xc4\\x81",
    "\\={e}"   => "\\xc4\\x93",
    "\\={\\i}" => "\\xc4\\xab",
    "\\={o}"   => "\\xc5\\x8d",
    "\\={u}"   => "\\xc5\\xab",
    "\\={A}"   => "\\xc4\\x80",
    "\\={E}"   => "\\xc4\\x92",
    "\\={\\I}" => "\\xc4\\xaa",
    "\\={O}"   => "\\xc5\\x8c",
    "\\={U}"   => "\\xc5\\xaa",
  }
  
  LATEX_TO_HTML_ENTITIES = {
    "\\={a}"   => "&#x101;",
    "\\={e}"   => "&#x113;",
    "\\={\\i}" => "&#x12b;",
    "\\={o}"   => "&#x14d;",
    "\\={u}"   => "&#x16b;",
    "\\={A}"   => "&#x100;",
    "\\={E}"   => "&#x112;",
    "\\={\\I}" => "&#x12a;",
    "\\={O}"   => "&#x14c;",
    "\\={U}"   => "&#x16a;",
  }

  class MacronConverter < Object

    attr_reader :convert
    
    # Initializer method expects to be provided a string to convert, and then one of three possible output
    # types:  high-numerical-code entities, UTF-8, and HTML entities.  Absent 
    # any specification, output format will default to HTML numbered entities.
    #
    # MacronConverter.new(laud\={a}re)    #-> laud&#x101;re
    #
    # MacronConverter.new(laud\={a}re, 'mc')  #-> laudāre
    
    def initialize(orig_string, output_target='mc')
      @orig_string = orig_string
      @target      = output_target
      @convert     = processString
    end

    # This allows a MacronConverter object to be printed with "puts"
    def to_s
      return @convert
    end
    
    def split(pattern)
      return @convert.split(pattern)
    end
    
    def to_a
      return @convert.split(/\s+/)
    end

##############################################################################
# PRIVATE METHODS
##############################################################################
        
    private 
    # Process string is the routine that scans a token for LaTeX macron codes.  
    # The method is recursive, the sentinel value is when the first RegEx scan 
    # of the string returns nil.  Upon the indetification of a macron-ized 
    # character, it passes that character to the private method 
    # MacronConverter#processChar
    
    def processString(s=@orig_string)      
      # All LaTeX Macron codes begin with an '=' token.  Scan for that using a 
      # RegEx.  The value is set to firstSlash.  
      
      firstSlash = s =~ /(\\=.*?\})/
      return s if $1.nil?
      
      testChar = $1
       
      # In the event that the first character is macron-bearing follow this 
      # case.  
      if firstSlash == 0
        return processChar(testChar).to_s +
         processString(s[firstSlash+testChar.length..s.length])
      end
      
      # In the more general case, we take the original string up to the first
      # macron-beginning-slash. We return that + running processChar on the
      # remainder of the string, that is return part_ok +
      # processString(the_rest).
      
      return s[0..firstSlash-1] + processChar(testChar).to_s +
       processString(s[firstSlash+testChar.length..s.length])
    end
     
    # Given a singular character, it does a hash-table lookup against the          
    # constant-defined LATEX_TO_UTF8 LATEX_TO_HTML_ENTITIES or    
    # LATEX_TO_MACRONS_CHARACTERS hashes and returns the value from the hash
   
    def processChar(c)
      if @target == 'utf8'
        return LATEX_TO_UTF8[c]
      end
      if @target == 'html'
        return LATEX_TO_HTML_ENTITIES[c]
      end
      if @target == "mc"
        return LATEX_TO_MACRONS_CHARACTERS[c]
      end
    end
  end
  
  class MacronDeConverter
    attr_reader :convert
    
    # In the construction, pass in the string that you wish to convert
    #
    # e.g. MacronDeConverter.new(laudāre means to praise) #-> laud\={a}re means to praise
    def initialize(content="No Content Provided - Consult Documentation")

      test_string=SGHUnicode::UnicodeSafeString.new(content)

      if test_string =~ /\&\#/
        @target = 'LATEX_TO_HTML_ENTITIES'
      elsif test_string =~ /[āēīōūĀĒĪŌŪ]/
        @target = 'LATEX_TO_MACRONS_CHARACTERS'
      elsif test_string =~ /\\\\x/
        @target = 'LATEX_TO_UTF8'
      else
        @target = nil
      end
      
      unless @target.nil?
        @reference_table=eval("MacronConversions::#{@target}")
        @reference_table.each{|x,y| @reference_table[y]=x}
        @convert = processString(test_string)
      else
        @convert = test_string
      end
    end

    # This allows a MacronDeConverter object to be printed with "puts"
    def to_s
      return @convert
    end
 
    private
    
    # Iterates through the characters, looking up the meta-descriptor
    # characters were found
    def processString(s)      
      unless s.nil?
         unless s.rest.empty?
           return processChar(s.first) + processString(s.rest) 
         else
           return processChar(s.first)
         end
      end
    end   
  
   # Looks up the character in the selected lookup chart.  Turns the
   # meta descriptor character \={e} into the glyph.
   
   def processChar(c)
     return @reference_table.key?(c) ? @reference_table[c] : c
   end

     
  end
  
end


