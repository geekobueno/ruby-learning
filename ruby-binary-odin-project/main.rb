# main.rb

require_relative 'lib/tree'

# Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15) { rand(1..100) })

# Confirm the tree is balanced
puts "Is tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"

# Unbalance the tree by adding several numbers > 100
[101, 102, 103, 104, 105].each { |n| tree.insert(n) }

# Confirm the tree is unbalanced
puts "Is tree balanced after insertions? #{tree.balanced?}"

# Rebalance the tree
tree.rebalance

# Confirm the tree is balanced
puts "Is tree balanced after rebalancing? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order after rebalancing
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"

# Pretty print the final tree
tree.pretty_print
