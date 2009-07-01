# A mixin module for displaying LatinVerbs.  Data created by Latin::LatinConjugation is created
# and stored in @collections, an instance variable in a Latin::Latinverb.  A full chart for the 
# verb can by had by using "chart_view".  Other multiplex methods ("present_system" or
# "perfect system" ) can be used to load up the @collections iVar ( which can be manipulated
# as it is shared via attr_accessor)

module Latin
  module Display
    require 'pp'

=begin

Following stolen wholesale from:

http://www.ruby-forum.com/topic/134043 based on
comments by Jordan Callicoat

pad is used to help "trick" printf under 1.8x into
doing the right thing.  In 1.9 this will not be necessary.

=end

   def pad(n,s)
     shifter = (n - s.to_s.unpack("U*").length < 0)  ?
               0 :
               (n - s.to_s.unpack("U*").length)
               
     (" " * shifter ) + s.to_s
   end

   # Padded is a method used to help trick a pseudo printf
   # style of display when you have multibyte characters.
   
   def padded(*elems)
     out = []
     for elem in elems.pop
       out << pad(elem[0], elem[1])
     end
     out.join(" ")
   end


=begin rdoc

Transform is used to take a series of horizontal arrays, and then put them
into tuples in a 90 degree rotational transform.  That is:

  [ [uno dos tres] [un deux trois] [een twee drie] [unus duo tres] ]

into

 [ [uno un een unus] [dos deux twee duo] [tres trois drie tres] ]

It returns this transformed array as an array, just as what came in.

=end

   def transform(m)
     matrix_width  = m[0].length
     matrix_height = m.length
     m.each do |row|
       raise("Matrix was not square") unless (row.length == matrix_width)
     end

     matrix_width  -= 1
     matrix_height -= 1
     
     new_matrix = []

     0.upto(matrix_width) do |column_position| 
       tuple = []
       0.upto(matrix_height) do |horizontal_position| 
         tuple << m[horizontal_position][column_position]
       end
       new_matrix << tuple
     end
     return new_matrix
   end

=begin rdoc

A display method that uses Latin::LatinConjugation.full_listing to get a 
data structure that is iterated through to produce a full chart layout.

=end
     
  def display_full_listing
    puts " " * 15 + "Full Listing: #{@four_pp.join(', ')}"
    
    layout =[ [ "Present System",              0..2  ],
              [ "Perfect System",              3..5  ],
              [ "Present Passive System",      6..8  ],
              [ "Perfect Passive System",      9..11 ],
              [ "Subjunctive Active System",  12..15 ],
              [ "Subjunctive Perfect Active", 16..19 ] ]

    layout.each do |layout_pair|
          print "#{layout_pair[0]}\n"
          d_f_display_block(transform(@collections[layout_pair[1]].map{ |row| row.nodes}))
          print "\n\n"
        end

    puts "Imperatives"
    puts @collections[20]
    print "\n\n"

    
    @collections[21..22].each do |hash_struct|
      0.upto(hash_struct.keys.length-1) do |ctr|
         puts hash_struct[ctr]
         print "\n"
       end      
       print "\n" * 2
    end

  @collections = []
    
  end # end method display_full_listing

  # A method for displaying a LatinVerb's "queue" of things to display.  It also
  # flushes the @collections variable after execution, hence the "!".  LatinVerb's 
  # to_s method is a redirect to this command.  This allows us to stack multiple
  # lookup commands to single display.
  def display!(join_character)
    puts @collections.join(join_character)
    @collections = []
  end
  
  # A convenience method used to load up the display collection
  # and then to call display_full listing to create a chart.
  def chart_display
    self.full_conjugation
    self.display_full_listing
    
  end
  
  private
  
  def d_f_display_block(block)
    labels = [ "1st sg.", " 2nd sg.", "3rd sg.", 
               "1st pl.",  "2nd pl.", "3rd pl."]
               
    block.each_with_index do |tuple,i|
      row = [labels[i]] + tuple
      
      puts padded(row.map{|item| [ 15 ,item]})
    end

  end
  
  end # end Display module
end # End Latin