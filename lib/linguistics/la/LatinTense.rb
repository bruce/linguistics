=begin rdoc

==DESCRIPTION

This is a method for storing collections of Latin::LatinNode(s)

==AUTHOR

Steven G. Harms ( http://www.stevengharms.com)
=end
module Latin
  class LatinTense < Object

=begin rdoc

@verb_methods contains the metaprogrammatic methods that are called
to create each of the nodes in the LatinTense.  The nodes,
in order received, are stored in @aggregate_nodes. Lastly, the
original label ( passed as part of the constructor ) is stored
in @lobel

=end
    
    attr_reader :verb_methods, :aggregate_nodes, :label

=begin rdoc

Provided a label ( which defines the tense ) of the form "present" or 
imperfect, etc. and an array of nodes, a meta-structure, the
Latin::LatinTense object is constructed.


=end
    
    def initialize(label, array_of_latinNodes)
      @label = label
      @verb_methods = []
      @aggregate_nodes = []
      
      # Create methods for accessing each of the particular nodes
      
      array_of_latinNodes.each do |node|
        # Create a string by which we will name a method accessor of 
        # the node
        method_name = node.label.sub(/^.*tense_/,'')
        
        # For easy access of finding the added methods for access
        verb_methods << method_name

        # Actually create the methods for accessing the values
        self.class.send(:define_method, method_name) { 
          @collections.pop unless (
            (not defined? @collections) ||
            @collections.nil? )
            return node.value 
        }
        
        # Push the node values into an array, it should wind up like:
        # [node1, node2, node3].  It's just for convenience, really.
        @aggregate_nodes.push(node.value)        
      end
    end
 
    # Converts the aggregate nodes into an array prefixed by the label.
    def to_s
      return_string = "#{@label}: "
      @aggregate_nodes.each do |node|
        return_string +=  "#{node}, "
      end
      return_string.gsub!(/,\s+$/, '')
      return return_string
    end

    # This method is provided in the case that a number is not
    # provided but a person is.  This will lead to an ambiguity.
    # In the case of this ambiguity, we return both of the nodes.
    
    def method_missing(id,*args)      
      if id.to_s !~ /^\w+_number/ and 
         id.to_s =~ /person/
      %w(singular plural).map do |generatedNumber|
        call_symbol = ("#{generatedNumber}" + id.to_s).to_sym
        @verb_methods << call_symbol
        @aggregate_nodes << self.send(call_symbol)
        end
      else
        super(id)
      end
    end
    
    # Synonym lookup
    def nodes
      return @aggregate_nodes
    end
    
    def length
      @aggregate_nodes.length
    end
    
  end
end