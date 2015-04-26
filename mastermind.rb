class Code
  attr_reader :code

  def initialize(arr)
    @code = arr
  end

  def self.random
    colors = [:r, :g, :b, :y, :o, :p]
    random_code = Array.new(4) { colors.sample }
    Code.new(random_code)
  end

  def self.parse(input)
    user_guess = input.split("").map(&:to_sym)
    Code.new(user_guess)
  end

  def exact_matches(other_code)
    counter = 0
    4.times do |i|
      counter += 1 if self.code[i] == other_code.code[i]
    end
    counter
  end

  def near_matches(other_code)
    non_exact_matches = remove_exact_matches(other_code)
    indices_of_near_matches = []

    non_exact_matches[0].each_index do |idx1|
      non_exact_matches[1].each_index do |idx2|
        first_code = non_exact_matches[0][idx1]
        second_code = non_exact_matches[1][idx2]

        if first_code == second_code &&
          !indices_of_near_matches.include?(idx2)
          indices_of_near_matches << idx2
          break
        end
      end
    end
    indices_of_near_matches.length
  end

  private

    def remove_exact_matches(other_code)
      # other_code_clone = other_code.code.dup
      # secret_code_clone = self.code.dup
      no_exact_codes = [[], []]
      4.times do |i|
        if self.code[i] != other_code.code[i]
          no_exact_codes[0] << self.code[i]
          no_exact_codes[1] << other_code.code[i]
        end
      end
      no_exact_codes
    end
end


class Game
  def initialize(code)
    @turns_taken = 0
    @secret_code_obj = code
  end

  def self.new_game
    game = Game.new(Code::random)
  end

  def run_game
    loop do
      puts "Pick four colors string from [r,g,b,y,o,p]"
      user_input = gets.chomp.downcase

      if valid_entry?(user_input)
        user_code_obj = Code::parse(user_input)
      else
        puts "Try another input"
        next
      end

      @turns_taken += 1
      game_status(user_code_obj)
      exact_num_matches = @secret_code_obj.exact_matches(user_code_obj)
      if win?(exact_num_matches)
        puts "YOU WIN"
        break
      elsif lose?(exact_num_matches)
        puts "YOU LOSE"
        break
      end
    end
  end

  private

    def game_status(user_code_obj)
      exact_num_matches = @secret_code_obj.exact_matches(user_code_obj)
      near_num_matches = @secret_code_obj.near_matches(user_code_obj)

      puts "Exact Matches = #{exact_num_matches} "
      puts "Near Matches  = #{near_num_matches}  "
      puts "Number of turns: #{@turns_taken}"
    end

    def lose?(exact_num_matches)
      @turns_taken > 10 && exact_num_matches < 4
    end

    def win?(exact_num_matches)
      @turns_taken <= 10 && exact_num_matches == 4
    end

    def valid_entry?(user_input)
      valid_length?(user_input) && valid_colors?(user_input)
    end

    def valid_length?(user_input)
      user_input_length = user_input.split("").length
      user_input_length == 4
    end

    def valid_colors?(user_input)
      colors = [:r, :g, :b, :y, :o, :p]
      user_input.chars.all? { |char| colors.include?(char.to_sym) }
    end
end

game = Game.new_game
game.run_game
# puts game.valid_entry?("rgby")
# puts game.valid_entry?("ajfksk")
# puts game.valid_entry?("zkdg")
