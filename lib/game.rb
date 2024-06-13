require_relative 'display'

class Game
  attr_reader :secret_word, :incorrect_guesses, :correct_letters, :incorrect_letters
  include Display

  def initialize
    @secret_word = random_secret_word
    @correct_letters = secret_word.chars.map! { '_' }
    @incorrect_letters = []
    @incorrect_guesses = 0
  end

  def play
    update_display
  end

  private

  def random_secret_word
    words = File.readlines('./google-10000-english-no-swears.txt')
    words.map(&:chomp).select { |word| word.length.between?(5, 12) }.sample.upcase
  end

  def update_display
    display_title
    display_hangman(incorrect_guesses)
    display_letters(correct_letters, incorrect_letters)
  end
end
