class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  # Remove duplicates and sort array before building the tree
  def build_tree(array)
    array = array.uniq.sort
    build_tree_recursive(array, 0, array.size - 1)
  end

  # Recursive method to build the tree
  def build_tree_recursive(array, start_idx, end_idx)
    return nil if start_idx > end_idx

    mid_idx = (start_idx + end_idx) / 2
    node = Node.new(array[mid_idx])

    node.left = build_tree_recursive(array, start_idx, mid_idx - 1)
    node.right = build_tree_recursive(array, mid_idx + 1, end_idx)

    node
  end

  # Pretty print method (not mandatory but useful for visualization)
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Insert method
  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
    node
  end

  # Find method
  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  # Delete method
  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # Node to delete found
      if node.left.nil? && node.right.nil?
        return nil
      elsif node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      else
        min_value_node = find_min(node.right)
        node.data = min_value_node.data
        node.right = delete(min_value_node.data, node.right)
      end
    end
    node
  end

  # Find minimum value node (for deletion helper)
  def find_min(node)
    current_node = node
    current_node = current_node.left until current_node.left.nil?
    current_node
  end

  # Level-order (breadth-first) traversal
  def level_order
    return [] if @root.nil?
    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      result << node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    block_given? ? result.each { |n| yield n } : result
  end

  # In-order traversal
  def inorder(node = @root, result = [], &block)
    return result if node.nil?

    inorder(node.left, result, &block)
    block_given? ? yield(node.data) : result << node.data
    inorder(node.right, result, &block)
  end

  # Pre-order traversal
  def preorder(node = @root, result = [], &block)
    return result if node.nil?

    block_given? ? yield(node.data) : result << node.data
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
  end

  # Post-order traversal
  def postorder(node = @root, result = [], &block)
    return result if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    block_given? ? yield(node.data) : result << node.data
  end

  # Height method
  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  # Depth method
  def depth(node, root = @root)
    return -1 if root.nil?

    if node.data < root.data
      depth(node, root.left) + 1
    elsif node.data > root.data
      depth(node, root.right) + 1
    else
      0
    end
  end

  # Balanced? method
  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  # Rebalance method
  def rebalance
    values = inorder
    @root = build_tree(values)
  end
end
