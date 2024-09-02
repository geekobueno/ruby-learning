class Code
  attr_reader :secret_code

  COLORS = %w[red blue green yellow orange purple]

  def initialize(secret_code = nil)
    @secret_code = secret_code || Array.new(4) { COLORS.sample }
  end

  def self.valid_guess?(guess)
    guess.length == 4 && guess.all? { |color| COLORS.include?(color) }
  end

  def feedback(guess)
    exact_matches = 0
    color_matches = 0

    remaining_secret = []
    remaining_guess = []

    # First pass: count exact matches
    guess.each_with_index do |color, index|
      if color == @secret_code[index]
        exact_matches += 1
      else
        remaining_secret << @secret_code[index]
        remaining_guess << color
      end
    end

    # Second pass: count color matches
    remaining_guess.each do |color|
      if remaining_secret.include?(color)
        color_matches += 1
        remaining_secret.delete_at(remaining_secret.index(color))
      end
    end

    { exact: exact_matches, color: color_matches }
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess
    puts "#{@name}, enter your guess (four colors separated by spaces):"
    gets.chomp.split.map(&:downcase)
  end

  def create_code
    puts "#{@name}, enter your secret code (four colors separated by spaces):"
    gets.chomp.split.map(&:downcase)
  end
end

class Computer < Player
  def initialize
    super("Computer")
  end

  def make_guess(previous_guesses, feedback)
    if previous_guesses.empty?
      Array.new(4) { Code::COLORS.sample }
    else
      previous_guesses.last.map.with_index do |color, index|
        feedback[:exact] > index ? color : Code::COLORS.sample
      end
    end
  end

  def create_code
    Array.new(4) { Code::COLORS.sample }
  end
end

class Game
  def initialize
    puts "Welcome to Mastermind!"
    puts "Do you want to be the code maker (enter 'maker') or the code guesser (enter 'guesser')?"
    role = gets.chomp.downcase

    if role == 'maker'
      @player = Player.new("Player")
      @computer = Computer.new
      @code = Code.new(@player.create_code)
    else
      @player = Player.new("Player")
      @computer = Computer.new
      @code = Code.new
    end
  end

  def play
    12.times do |turn|
      puts "\nTurn #{turn + 1}/12"
      guess = get_guess
      if Code.valid_guess?(guess)
        feedback = @code.feedback(guess)
        display_feedback(feedback)

        if feedback[:exact] == 4
          puts "Congratulations, #{@player.name}! You've guessed the code!"
          return
        end
      else
        puts "Invalid guess. Please try again."
      end
    end

    puts "Sorry, you've run out of turns! The secret code was #{@code.secret_code.join(', ')}."
  end

  private

  def get_guess
    if @code.secret_code
      @player.make_guess
    else
      @computer.make_guess([], {})
    end
  end

  def display_feedback(feedback)
    puts "Exact matches: #{feedback[:exact]}"
    puts "Correct colors but wrong positions: #{feedback[:color]}"
  end
end

# Start the game
game = Game.new
game.play
