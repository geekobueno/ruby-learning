# Iterative Fibonacci
def fibs(n)
  sequence = [0, 1]
  return sequence.take(n) if n <= 2

  (2...n).each do |i|
    sequence << sequence[i-1] + sequence[i-2]
  end
  sequence
end

# Recursive Fibonacci

def fibs_rec(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  sequence = fibs_rec(n - 1)
  sequence << sequence[-1] + sequence[-2]
  sequence
end

# Test both methods
puts "Iterative Fibonacci:"
puts fibs(8).inspect
puts fibs(10).inspect

puts "\nRecursive Fibonacci:"
puts fibs_rec(8).inspect
puts fibs_rec(10).inspect

# Recursive Fibonacci with print statement
def fibs_rec_print(n)
  puts 'This was printed recursively'
  return [0] if n == 1
  return [0, 1] if n == 2

  sequence = fibs_rec_print(n - 1)
  sequence << sequence[-1] + sequence[-2]
  sequence
end

puts "\nRecursive Fibonacci with print statement:"
puts fibs_rec_print(8).inspect