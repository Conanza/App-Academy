class Hangman
  def initialize(guessing_player, checking_player)
    @guesser, @checker = guessing_player, checking_player
    @turns_taken = 0
  end

  def self.new_game
  end

  def run
    @checker.pick_secret_word
    length_of_word = @checker.send_secret_length
    @guesser.get_secret_length(length_of_word)
    puts "Word is #{length_of_word} letters long"

    until @checker.won? || @turns_taken >= 10
      @checker.display
      puts "Guess your letter: "
      guess = @guesser.guess_letter(@checker.confirm_guess(guess))
      @turns_taken += 1
      puts "#{@guesser.name} has #{10 - @turns_taken} turns left\n\n"
    end

    puts "#{@guesser.name} loses"
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
    @word_length = 0
    @guessed_letters = []
  end

  def guess_letter(guess)
    gets.chomp
  end

  def confirm_guess(guess)
    puts "Is this letter in your word?"
    response = gets.chomp.downcase
    if response == "y"
      puts "where?"
      indices = gets.chomp
      indices.split.each do |idx|
        @guessed_letters[idx.to_i] = guess
      end
    end
    @guessed_letters
  end

  def pick_secret_word
    puts "How long is your word?"
    @word_length = Integer(gets)
    @guessed_letters = Array.new(@word_length) { "_" }
  end

  def send_secret_length
    @word_length
  end

  def get_secret_length
  end

  def won?
    won = @guessed_letters.join.scan(/[a-z]/).count == @word_length
    if won
      puts "Computer wins"
      display
      exit
    else
      false
    end
  end

  def display
    puts @guessed_letters.join
  end
end

class ComputerPlayer
  attr_reader :name

  def initialize
    @name = "computer"
    @secret_word = nil
    @guessed_letters = []
    @words = File.readlines("dictionary.txt").map(&:chomp)
    @secret_length = nil
    @possible_words = @words.dup
  end

  def guess_letter(guessed_so_far)
    @possible_words.select! { |word| match?(word.split, guessed_so_far) }

    possible_words = @words.dup
    possible_words.select! { |word| word =~ /#{string}/ }


    string = @possible_words.join("")
    string.sort_by { |x| string.count(x.last)}

    random_letter = [*"a".."z"].sample
    puts "Computer guesses #{random_letter}"
    random_letter
  end

  def match?(word1, word2)
    word1.each_index do |idx|
      letter1 = word1[idx]
      letter2 = word2[idx]
      if [*"a".."z"].include?(letter1)
        return true if letter1 == letter2
      end
    end

    return false
  end

  def letter_frequency

  end

  def confirm_guess(guess)
    @guessed_letters << guess
  end

  def pick_secret_word
    @secret_word = @words.sample
  end

  def send_secret_length
    @secret_word.length
  end

  def get_secret_length(length_of_word)
    @secret_length = length_of_word
  end

  def display
    print "Secret word: "
    @secret_word.chars.each do |char|
      @guessed_letters.include?(char) ? print(char) : print("_")
    end
    puts
  end

  def won?
    won = @secret_word.chars.all? { |letter| @guessed_letters.include?(letter) }
    if won
      display
      puts "You win!"
      exit
    else
      false
    end
  end
end



checker = HumanPlayer.new("human")
guesser = ComputerPlayer.new
game = Hangman.new(guesser, checker)
game.run
