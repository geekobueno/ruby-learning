class Board
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
  end

  def display
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts "---|---|---"
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts "---|---|---"
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
  end

  def update_board(row, col, symbol)
    if @board[row][col] == " "
      @board[row][col] = symbol
      true
    else
      false
    end
  end

  def win?
    # Check rows, columns, and diagonals
    lines = @board + @board.transpose + diagonals
    lines.any? { |line| line.uniq.size == 1 && line.first != " " }
  end

  def full?
    @board.flatten.none? { |cell| cell == " " }
  end

  private

  def diagonals
    [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]
    ]
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @board = Board.new
    @players = [Player.new("Player 1", "X"), Player.new("Player 2", "O")]
    @current_player = @players.first
  end

  def play
    until game_over?
      @board.display
      row, col = get_move
      if @board.update_board(row, col, @current_player.symbol)
        switch_turns
      else
        puts "Invalid move! Try again."
      end
    end

    @board.display
    if @board.win?
      switch_turns
      puts "#{@current_player.name} wins!"
    else
      puts "It's a draw!"
    end
  end

  private

  def switch_turns
    @current_player = @players.reverse!.first
  end

  def get_move
    loop do
      print "#{@current_player.name}, enter your move (row and column) separated by space (0-2): "
      input = gets.chomp.split.map(&:to_i)
      return input if input.size == 2 && input.all? { |n| n.between?(0, 2) }
      puts "Invalid input. Please enter two numbers between 0 and 2."
    end
  end

  def game_over?
    @board.win? || @board.full?
  end
end

# Start the game
game = Game.new
game.play
