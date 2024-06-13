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
      update_display
      
      print "Make a guess or save? "
      input = gets.chomp.downcase
    
      make_guess if input == 'guess'
      save_game if input == 'save'
      
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

  def save_game
    game_state = {
      secret_word: @secret_word,
      correct_letters: @correct_letters,
      incorrect_letters: @incorrect_letters,
      incorrect_guesses: @incorrect_guesses
    }

    print "Enter a name for your save file: "
    file_name = gets.chomp
    file_path = "./saved_games"

    Dir.mkdir(file_path) unless Dir.exist?(file_path)
    File.open("#{file_path}/#{file_name}", 'w') { |file| file.write(YAML.dump(game_state)) }

    puts "\nGame has been saved in: #{file_path}/#{file_name}"

    sleep 5
  end

  def make_guess
    loop do
      print "\nGuess: "
      guess = gets.chomp.upcase

      unless valid_guess?(guess)
        puts "Invalid Input. Please enter a single letter."
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
      
      break
    end
  end
end
