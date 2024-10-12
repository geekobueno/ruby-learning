class ConnectFour
  attr_reader :board, :current_player

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @current_player = "X"
  end

  def drop_piece(column)
    row = find_available_row(column)
    @board[row][column] = @current_player if row
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def find_available_row(column)
    (0..5).reverse_each do |row|
      return row if @board[row][column].nil?
    end
    nil
  end

  def check_win
    # Check for horizontal win
    (0..5).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player &&
                       @board[row][col + 1] == @current_player &&
                       @board[row][col + 2] == @current_player &&
                       @board[row][col + 3] == @current_player
      end
    end

    # Check for vertical win
    (0..2).each do |row|
      (0..6).each do |col|
        return true if @board[row][col] == @current_player &&
                       @board[row + 1][col] == @current_player &&
                       @board[row + 2][col] == @current_player &&
                       @board[row + 3][col] == @current_player
      end
    end

    # Check for diagonal win (upward slope)
    (0..2).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player &&
                       @board[row + 1][col + 1] == @current_player &&
                       @board[row + 2][col + 2] == @current_player &&
                       @board[row + 3][col + 3] == @current_player
      end
    end

    # Check for diagonal win (downward slope)
    (3..5).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player &&
                       @board[row - 1][col + 1] == @current_player &&
                       @board[row - 2][col + 2] == @current_player &&
                       @board[row - 3][col + 3] == @current_player
      end
    end

    false
  end

  def draw?
    @board.all? { |row| row.all? { |cell| !cell.nil? } }
  end
end