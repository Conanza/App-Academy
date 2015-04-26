class TowersOfHanoi
  def self.build_towers(n)
    [(1..n).to_a, [], []]
  end

  attr_reader :towers

  def initialize(num_discs)
    @towers = self.class.build_towers(num_discs)
  end

  def play
    until won? 
      display
      move_from, move_to = get_move(:from), get_move(:to)

      make_move(move_from, move_to)
    end

    display
    puts "Congrats!! You made it"
  end

  private

    def display
      p towers
    end

    def get_move(arg)
      puts "Which position do you want to move a disc #{arg}? Choose 0, 1, or 2: "
      
      begin
        Integer(gets)
      rescue
        puts "Please select a number between 0-2"
        retry
      end
    end

    def make_move(from, to)
      if valid_move?(from, to)
        towers[to].unshift(towers[from].shift)
      else
        puts "---TRY ANOTHER MOVE---"
      end
    end

    def valid_move?(from, to)
      return false unless from.between?(0, 2)
      return false unless to.between?(0,2)
      return false if from == to
      return false if towers[from].empty?
      return true if towers[to].empty? || towers[from].first < towers[to].first
    end

    def won?
      @towers.first.empty? && @towers.drop(1).any? { |tower| tower.empty? }
    end
end

if $PROGRAM_NAME == __FILE__
  puts "How many discs would you like to play with?"
  game = TowersOfHanoi.new(Integer(gets))
  game.play
end

