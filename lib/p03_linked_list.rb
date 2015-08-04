class LinkedListNode
  attr_accessor :value, :next_node, :prev_node
  def initialize(value = nil, next_node = nil, prev_node = nil)
    @value = value
    @next_node = next_node
    @prev_node = prev_node
  end
end

class LinkedList
  attr_reader :final, :root
  def initialize
    @root = LinkedListNode.new(:_root)
    @final = LinkedListNode.new(:_last)
    @root.next_node = @final
    @final.prev_node = @root
  end

  def empty?
    @root.next_node == @final 
  end

  def first
    return nil if empty?  
    @root.next_node
  end

  def last
    return nil if empty?
    @final.prev_node
  end

  def insert(val)
    successor = @root.next_node
    node = LinkedListNode.new(val)

    # reassign the double links
    node.next_node = successor
    successor.prev_node = node

    node.prev_node = @root
    @root.next_node = node
  end

  def include?(val)
    current = @root

    until current == @last
      return true if current.value == val
      current = current.next_node
    end

    false
  end

  def remove(val)
    return nil unless include?(val)

    prev = @root
    current = prev.next_node
    until current.value == val
      prev = current
      current = current.next_node
    end

    # reassign pointers in both directions
    prev.next_node = current.next_node
    prev.next_node.prev_node = prev 

    current.value
  end
end


# puts "TESTING"
#
# link = LinkedList.new
#
# 10.times do |num|
#   link.insert(num)
# end
#
# puts "traverse forward"
# node = link.root
# until node == nil
#   puts node.value
#   node = node.next_node
# end
# puts
# puts "traverse back"
#
# node = link.final
# until node == nil
#   puts node.value
#   node = node.prev_node
# end
# puts
# puts "remove 4"
# link.remove(4)
# puts "traverse forward"
# node = link.root
# until node == nil
#   puts node.value
#   node = node.next_node
# end
# puts
# puts "traverse back"
#
# node = link.final
# until node == nil
#   puts node.value
#   node = node.prev_node
# end
