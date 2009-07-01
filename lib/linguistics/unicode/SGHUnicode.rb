# == Synopsis
#
# SGHUnicode : A  module for dealing with Unicode headaches, as noted by [S]teven [G] [H]arms
#
# == Usage
#
#  load 'language/SGHUnicode.rb'
#
# == Description
#
# The class provides the class UnicodeSafeString. 
# 
# == Example Code
#
#   load 'language/MacronConversions.rb'
#
#
# == Dependencies
#
# None
#
# == Author
#
# Steven G. Harms, http://www.stevengharms.com
#

module SGHUnicode
  class UnicodeSafeString < Object
    attr_accessor :USS
    attr_reader   :multibyte, :length, :sanitized_array, :original_string
    
    # Initialize takes in a string that may or may not have 16 bit characters in it.  
    # It then scans the string to see if any of the characters have an ASCII value greater than 256.  
    #
    # If the string is, in fact, multibyte, then the instance methods 'first' and 'rest' can be used to
    # get a LISP-like cons and cdr of the string.  In the event that the 'first' is multibyte, USS recognizes
    # this and returns a string of the next _two_ bytes as a string ( i.e. you get the multibyte 'character' ).  
    #
    # Also provided is an 'each' function which operates as an iterator through the 'characters'
    #
    # Example: SGHUnicode::UnicodeSafeString.new(content)      # generic
    #
    # Example: SGHUnicode::UnicodeSafeString.new(laudāre)      #=> multibyte? is true
    #
    # Example: SGHUnicode::UnicodeSafeString.new(fizzlewump)   #=> multibyte? is false
    
    def initialize(*given)
      # Null constructor
      if given[0].nil?
        @USS = @original_string = ""
        @uncertain_string_as_array=@detect_multibyte_array=nil
        @length=0
        @multibyte=false
        return
      end

      evaluate_string(given[0])      
    end
 
    def evaluate_string(aString)
      
      if (
          (not defined? @original ) ||
            @original_string.nil? 
          )
        
        @USS = @original_string = aString

        # unpack the string into its constituent characters. If the element is
        # non-ascii, there will be a 0 enry, if not, it will all be 1's.
        @uncertain_string_as_array = @original_string.unpack('U*')

        # 1 if it's multibyte, 0 else. 
        @detect_multibyte_array=@uncertain_string_as_array.collect{ |char_value| char_value > 256 ? 1 : 0 }

        # A safe length to assume for the string based on the unpacked string
        @length = @detect_multibyte_array.length

        # Build a string-containing array

        @sanitized_array=[]
        each do|sanitized_char|
          @sanitized_array.push(sanitized_char)
        end

        # If we find a 0, then we have a multibyte character in here
        if (@detect_multibyte_array.include? 1)
          @multibyte=true
        else
          @USS=@original_string.chomp
        end    
  
      else
        @USS = aString

        # unpack the string into its constituent characters. If the element is
        # non-ascii, there will be a 0 enry, if not, it will all be 1's.
        @uncertain_string_as_array = aString.unpack('U*')

        # 1 if it's multibyte, 0 else. 
        @detect_multibyte_array=@uncertain_string_as_array.collect{ |char_value| char_value > 256 ? 1 : 0 }

        # A safe length to assume for the string based on the unpacked string
        @length = @detect_multibyte_array.length

        # Build a string-containing array

        @sanitized_array=[]
        each do|sanitized_char|
          @sanitized_array.push(sanitized_char)
        end

        # If we find a 0, then we have a multibyte character in here
        if (@detect_multibyte_array.include? 1)
          @multibyte=true
        else
          @multibyte=false
        end    

        @USS=aString.chomp

      end
      
    end
    
    # Assignment operator
    def self=() 
      puts "here"
    end
    
    def [](x)
      # We accommodate Fixnum's and Range's
      unless ( x.class.to_s =~ /(Fixnum|Range)/)
        return nil
     end   
      
      
      # Return an item
      if x.class.to_s == "Fixnum"
        # Out of range check
        if x > @length
          raise "Index out of bounds."
        else
          counter = 0
          sought_value = ""
          each do 
            |aChar|
            sought_value=aChar if x.to_i == counter
            counter=counter+1
          end 
          return sought_value          
        end
      elsif x.class.to_s == "Range"  
        # Fail if you put something out of range!
        if @detect_multibyte_array[x.begin].nil? or @detect_multibyte_array[x.end].nil?
          raise "Subsection request failed for Range"
        end
        # In case they're using the standard range notation
        if x.begin >= 0 and x.end <=@length
          counter = 0
          sought_values = Array.new
          each do 
            |aChar|
            if counter >= x.begin.to_i and counter <= (x.end.to_i < 0 ? x.end.to_i + @length : x.end.to_i)
              sought_values.unshift(aChar)
            end
            counter += 1
          end
          return sought_values.reverse.to_s
        # In case they're using the negative range notation
        elsif x.begin < 0 and x.end < 0
          return self[Range.new(@length+x.begin, @length+x.end)]
        end
      else
        puts "bad end"
        raise("Subsection request failed.")
      end
    end
    
    # Provides an 'each character' functionality for a string that may or may not contain
    # multibyte characters.  Should be used with a block, much like the traditional
    # Array.each{|x| blah x} invocation
    
    def each
      destructive_copy_content = @uncertain_string_as_array.clone
      destructive_copy_detect  = @detect_multibyte_array.clone
      
      index = -1 
      destructive_copy_detect.length.times do |safe_char|
        index +=1
        if destructive_copy_detect.shift == 0
          yield destructive_copy_content.shift.chr
        elsif
          yield [destructive_copy_content.shift].pack('U').to_s
        end
      end
    end

    # Provides the cons of the first character of the string.  
    # I think Python uses the same semantics.  I don't know though, I chose Ruby instead.
    
    def first
      return if @detect_multibyte_array[0].nil?
      if @detect_multibyte_array[0] == 0
        return @original_string[0].chr
      else
        return @original_string[0,2]
      end
    end
    
    # Provides the cons of the first character of the string
        
    def rest
      if @detect_multibyte_array[0] == 0
        return SGHUnicode::UnicodeSafeString.new(@original_string[1,@original_string.length])
      else
        return SGHUnicode::UnicodeSafeString.new(@original_string[2,@original_string.length])
      end     
    end
    
    # Accessor for testing presence of multibyte characters
    
    def multibyte?     
      return @multibyte
    end
    
    # Returns an array which has 1 in the character positions where a multibyte character was found
    def multibyte_locations
      return @detect_multibyte_array
    end

    # Reverse as inherited from string is dangerous!
    def reverse
      good_array=Array.new
      each{|letter| good_array.unshift(letter)}
      return good_array.to_s
    end

   # To retrieve the array into which the characters were initially unpacked
   def to_a
     return @sanitized_array
   end

   # So that this can be printed easily
 
   def to_s
     return @original_string
   end
  end
end