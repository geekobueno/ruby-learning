class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  # Add a node with the value to the end of the list
  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node until current.next_node.nil?
      current.next_node = new_node
    end
  end

  # Add a node with the value to the start of the list
  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  # Returns the total number of nodes in the list
  def size
    count = 0
    current = @head
    until current.nil?
      count += 1
      current = current.next_node
    end
    count
  end

  # Returns the first node (head)
  def head
    @head
  end

  # Returns the last node (tail)
  def tail
    current = @head
    return nil if current.nil?

    current = current.next_node until current.next_node.nil?
    current
  end

  # Returns the node at a specific index
  def at(index)
    current = @head
    count = 0
    while current
      return current if count == index

      current = current.next_node
      count += 1
    end
    nil
  end

  # Removes the last node from the list
  def pop
    return nil if @head.nil?

    if @head.next_node.nil?
      @head = nil
    else
      current = @head
      current = current.next_node until current.next_node.next_node.nil?
      current.next_node = nil
    end
  end

  # Returns true if the value is in the list, otherwise false
  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  # Returns the index of the node containing the value or nil if not found
  def find(value)
    current = @head
    index = 0
    until current.nil?
      return index if current.value == value

      current = current.next_node
      index += 1
    end
    nil
  end

  # Represent the list as a string
  def to_s
    current = @head
    list_str = ''
    until current.nil?
      list_str += "( #{current.value} ) -> "
      current = current.next_node
    end
    list_str += 'nil'
    list_str
  end

  # Insert a node at a specific index
  def insert_at(value, index)
    return prepend(value) if index == 0

    previous_node = at(index - 1)
    return if previous_node.nil?

    new_node = Node.new(value, previous_node.next_node)
    previous_node.next_node = new_node
  end

  # Remove the node at a specific index
  def remove_at(index)
    return @head = @head.next_node if index == 0

    previous_node = at(index - 1)
    return if previous_node.nil? || previous_node.next_node.nil?

    previous_node.next_node = previous_node.next_node.next_node
  end
end

# Test the LinkedList class
list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list.to_s
