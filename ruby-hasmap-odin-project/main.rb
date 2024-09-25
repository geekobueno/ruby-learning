# main.rb
require_relative 'lib/hash_map'
require_relative 'lib/hash_set'

# Testing HashMap
puts "Testing HashMap"
hash_map = HashMap.new

hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('carrot', 'orange')
hash_map.set('dog', 'brown')

puts "Get 'apple': #{hash_map.get('apple')}" # red
puts "Has 'banana'? #{hash_map.has?('banana')}" # true
puts "Remove 'carrot': #{hash_map.remove('carrot')}" # orange
puts "Keys: #{hash_map.keys}" # ["apple", "banana", "dog"]
puts "Values: #{hash_map.values}" # ["red", "yellow", "brown"]
puts "Length: #{hash_map.length}" # 3
hash_map.clear
puts "Length after clear: #{hash_map.length}" # 0

# Testing HashSet
puts "\nTesting HashSet"
hash_set = HashSet.new

hash_set.add('apple')
hash_set.add('banana')
hash_set.add('carrot')
hash_set.add('dog')

puts "Has 'banana'? #{hash_set.has?('banana')}" # true
puts "Has 'frog'? #{hash_set.has?('frog')}" # false
puts "Remove 'banana': #{hash_set.remove('banana')}" # banana
puts "Has 'banana'? #{hash_set.has?('banana')}" # false
puts "Keys: #{hash_set.keys}" # ["apple", "carrot", "dog"]
puts "Length: #{hash_set.length}" # 3
hash_set.clear
puts "Length after clear: #{hash_set.length}" # 0
