def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid..-1])

  merge(left, right)
end

def merge(left, right)
  result = []
  left_index = 0
  right_index = 0

  while left_index < left.length && right_index < right.length
    if left[left_index] <= right[right_index]
      result << left[left_index]
      left_index += 1
    else
      result << right[right_index]
      right_index += 1
    end
  end

  result.concat(left[left_index..-1])
  result.concat(right[right_index..-1])

  result
end

# Test the merge_sort method
puts "Merge Sort Test 1:"
puts merge_sort([3, 2, 1, 13, 8, 5, 0, 1]).inspect

puts "\nMerge Sort Test 2:"
puts merge_sort([105, 79, 100, 110]).inspect