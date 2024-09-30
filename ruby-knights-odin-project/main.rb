require 'set'

def knight_moves(start, finish)
  queue = [[start, [start]]]
  visited = Set.new([start])
  
  moves = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2],
    [1, -2], [1, 2], [2, -1], [2, 1]
  ]

  until queue.empty?
    current, path = queue.shift

    return path if current == finish

    moves.each do |dx, dy|
      next_move = [current[0] + dx, current[1] + dy]
      
      if valid_move?(next_move) && !visited.include?(next_move)
        visited.add(next_move)
        queue.push([next_move, path + [next_move]])
      end
    end
  end

  []  # Return empty array if no path found
end

def valid_move?(position)
  position[0].between?(0, 7) && position[1].between?(0, 7)
end

# Example usage and output
start = [3, 3]
finish = [4, 3]
path = knight_moves(start, finish)

puts "You made it in #{path.size - 1} moves!  Here's your path:"
path.each { |position| puts position.inspect }