require 'yaml'

module Display
  def display_title
    puts "Hangman"
  end
  def display_hangman(incorrect_guesses)
    stages = YAML.load_file('lib/stages.yml')
    puts stages[incorrect_guesses]
  end

  def display_letters(correct_letters, incorrect_letters)
    puts "#{correct_letters.join(' ')}"
    puts "> #{incorrect_letters.join}"
  end
end
