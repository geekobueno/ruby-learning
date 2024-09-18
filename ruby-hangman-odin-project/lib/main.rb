require 'yaml'

class Hangman
  attr_accessor :word, :guesses, :incorrect_guesses, :correct_guesses, :max_attempts

  def initialize(word, max_attempts = 6)
    @word = word.downcase
    @max_attempts = max_attempts
    @guesses = []
    @incorrect_guesses = []
    @correct_guesses = Array.new(@word.length, '_')
  end

  def guess_letter(letter)
    letter.downcase!
    if @guesses.include?(letter)
      puts "You already guessed '#{letter}'"
    elsif @word.include?(letter)
      puts "Correct guess: #{letter}"
      @word.chars.each_with_index do |char, index|
        @correct_guesses[index] = letter if char == letter
      end
      @guesses << letter
    else
      puts "Incorrect guess: #{letter}"
      @incorrect_guesses << letter
      @guesses << letter
    end
  end

  def won?
    !@correct_guesses.include?('_')
  end

  def lost?
    @incorrect_guesses.size >= @max_attempts
  end

  def display
    puts "Word: #{@correct_guesses.join(' ')}"
    puts "Incorrect guesses: #{@incorrect_guesses.join(', ')}"
    puts "Remaining attempts: #{@max_attempts - @incorrect_guesses.size}"
  end

  def save_game(filename)
    File.open(filename, 'w') { |file| file.write(YAML.dump(self)) }
    puts "Game saved!"
  end

  def self.load_game(filename)
    if File.exist?(filename)
      YAML.safe_load(File.read(filename), permitted_classes: [Hangman])
    else
      puts "File not found!"
      nil
    end
  end
  
end

def load_dictionary
  File.readlines('../google-10000-english-no-swears.txt').map(&:chomp).select { |word| word.length.between?(5, 12) }
end

def start_game
  dictionary = load_dictionary
  secret_word = dictionary.sample
  game = Hangman.new(secret_word)

  while true
    game.display

    if game.won?
      puts "Congratulations, you won!"
      break
    elsif game.lost?
      puts "You lost! The word was: #{game.word}"
      break
    end

    print "Guess a letter or type 'save' to save the game: "
    input = gets.chomp

    if input.downcase == 'save'
      print "Enter a filename to save the game: "
      filename = gets.chomp
      game.save_game(filename)
      break
    else
      game.guess_letter(input)
    end
  end
end

def load_saved_game
  print "Enter the filename of the saved game: "
  filename = gets.chomp
  Hangman.load_game(filename)
end

def main
  puts "Welcome to Hangman!"
  print "Type 'new' to start a new game or 'load' to load a saved game: "
  choice = gets.chomp.downcase

  case choice
  when 'new'
    start_game
  when 'load'
    game = load_saved_game
    if game
      while true
        game.display

        if game.won?
          puts "Congratulations, you won!"
          break
        elsif game.lost?
          puts "You lost! The word was: #{game.word}"
          break
        end

        print "Guess a letter or type 'save' to save the game: "
        input = gets.chomp

        if input.downcase == 'save'
          print "Enter a filename to save the game: "
          filename = gets.chomp
          game.save_game(filename)
          break
        else
          game.guess_letter(input)
        end
      end
    end
  else
    puts "Invalid choice!"
  end
end

if __FILE__ == $0
  main
end
