=begin rdoc


==DESCRIPTION

Instead of simply storing a calculated node as a String ( or, better yet, as a Latin::LatinWord),
Latin::LatinNode serves as a structure for holding the meta-information about the node ( its
particular vector, i.e. @label ) as well as the actual value (@value).  

==AUTHOR

Steven G. Harms ( http://www.stevengharms.com)

=end

module Latin
  class LatinNode < Object

    attr_reader :label, :value   
    attr_accessor :display
 
=begin rdoc

Initialize with the metaprogrammatic value (label), the actual value of the node (value),
and optionally a hash that contains a value for the key :display.  This will specify whether,
when to_s is called, if only the label, only the node, or both are displayed.  The default
is node-only

=end

    def initialize(label,value,*params)
      @label,@value = label, value
      @display = params[0][:display].nil? ? "all" : params[0][:display]
    end

=begin rdoc

Print out the node, the node and label, or just the label based on the value
of @display.  See constructor for furhter details

=end
  
    def to_s
      if @display == "all" or @display.nil?
        return [label, value.to_s].join(':')
      elsif @display == 'labelsonly'
        return label
      elsif @display == 'valuesonly'
        return value.to_s
      end 
    end
  
  end
end