require_relative 'connect_four'

describe ConnectFour do
  describe "#initialize" do
    it "creates a 6x7 game board" do
      game = ConnectFour.new
      expect(game.board).to be_a(Array)
      expect(game.board.length).to eq(6)
      expect(game.board.all? { |row| row.length == 7 }).to be true
    end
  end

  describe "#drop_piece" do
    it "allows players to drop pieces" do
      game = ConnectFour.new
      game.drop_piece(0)
      expect(game.board[5][0]).to eq("X")
    end

    it "alternates players" do
      game = ConnectFour.new
      game.drop_piece(0)
      game.drop_piece(1)
      expect(game.current_player).to eq("X")
    end
  end

  describe "#check_win" do
    it "detects horizontal win" do
      game = ConnectFour.new
      game.board[5][0] = "X"
      game.board[5][1] = "X"
      game.board[5][2] = "X"
      game.board[5][3] = "X"
      expect(game.check_win).to be true
    end

    # ... (add tests for other win conditions)
  end

  describe "#draw?" do
    it "detects a draw" do
      game = ConnectFour.new
      # Fill the board with pieces
      (0..5).each do |row|
        (0..6).each do |col|
          game.board[row][col] = "X"
        end
      end
      expect(game.draw?).to be true
    end
  end
end