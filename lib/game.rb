require_relative 'display'

class Game
  attr_accessor :incorrect_guesses
  attr_reader :secret_word, :correct_letters, :incorrect_letters
  include Display

  def initialize
    @secret_word = random_secret_word.chars
    @correct_letters = secret_word.map { '_' }
    @incorrect_letters = []
    @incorrect_guesses = 0
  end

  def play
    update_display
    new_game
  end

  private

  def random_secret_word
    words = File.readlines('./google-10000-english-no-swears.txt')
    words.map(&:chomp).select { |word| word.length.between?(5, 12) }.sample.upcase
  end

  def update_display
    system 'clear'
    display_title
    display_hangman(incorrect_guesses)
    display_letters(correct_letters, incorrect_letters)
  end

  def valid_guess?(guess)
    guess.match?(/\p{Alpha}/) && guess.length == 1
  end

  def new_game
    loop do
      print "Make a guess: "
      guess = gets.chomp.upcase

      unless valid_guess?(guess)
        puts "Invalid Input. Please enter a single letter.\n\n"
        next
      end

      if secret_word.include?(guess)
        update_correct_letters(guess)
      else
        unless incorrect_letters.include?(guess)
          incorrect_letters << guess
          self.incorrect_guesses += 1
        end
      end
    
      update_display
    
      break if game_over?
    end
    
    puts game_won? ? "Congratulations!" : "Game Over!"
  end

  def game_over?
    incorrect_guesses == 7 || secret_word == correct_letters
  end
  
  def game_won?
    secret_word == correct_letters
  end

  def update_correct_letters(guess)
    positions = secret_word.each_index.select { |i| secret_word[i] == guess }
    correct_letters.map!.with_index { |letter, index| positions.include?(index) ? guess : letter }
  end
end
