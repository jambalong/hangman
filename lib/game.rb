class Game
  def initialize
    @secret_word = random_secret_word
  end

  private

  def random_secret_word
    words = File.readlines('./google-10000-english-no-swears.txt')
    words.map(&:chomp).select { |word| word.length.between?(5, 12) }.sample
  end
end
