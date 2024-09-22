module Enumerable
  # Your code goes here
  def my_map
    result = []
    each do |element|
      result << (block_given? ? yield(element) : element)
    end
    result
  end

  def my_inject(initial = nil)
    accumulator = initial
    each_with_index do |element, index|
      if accumulator.nil? && index == 0
        accumulator = element
      else
        accumulator = yield(accumulator, element)
      end
    end
    accumulator
  end

  def my_all?
    each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    for i in 0...self.size
      yield(self[i], i)
    end

    self
  end

  def my_any?
    each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    count = 0
    if block_given?
      each { |element| count += 1 if yield(element) }
    else
      each { count += 1 }
    end
    count
  end

  def my_none?
    each do |element|
      return false if yield(element)
    end
    true
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    # Check if a block is given
    return to_enum(:my_each) unless block_given?

    # Iterate through each element of the array
    for i in 0...self.length
      # Yield each element to the block
      yield(self[i])
    end

    # Return the original array
    self
  end
end
