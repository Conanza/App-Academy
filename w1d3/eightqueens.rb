class EightQueens
  def self.run_game
    new_board = EightQueens.new

    until new_board.complete?
      new_board.render
      puts "Make your move in row,col format (e.g. 1,2): "
      coords = gets.chomp.split(",").map(&:to_i)
      new_board.place_queen(coords)
    end

    puts "CONGRATS. YOU SOLVED IT"
  end

  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def render 
    @board.each do |row|
      puts row.map { |el| el.nil? ? "___" : "_#{el}_" }.join("|")
      puts
    end
  end

  def place_queen(pos)
    valid_move?(pos) ? self[pos] = :Q : puts("Can't put her there!\n")
  end

  def complete?
    @board.flatten.count(:Q) == 8
  end

  private

    def [](pos)
      @board[pos.first][pos.last]
    end

    def []=(pos, mark)
      @board[pos.first][pos.last] = mark
    end
    
    def valid_move?(pos)
      rows_empty?(pos.first) && cols_empty?(pos.last) && diags_empty?(pos)
    end

    def rows_empty?(row)
      @board[row].all? { |el| el.nil? }
    end

    def cols_empty?(col)
      @board.all? { |row| row[col].nil? }
    end

    def diags_empty?(pos)
      diag1 = build_decreasing_diag(pos)
      diag2 = build_increasing_diag(pos)

      diag1_state = diag1.all? { |pos| empty?(pos) }
      diag2_state = diag2.all? { |pos| empty?(pos) }

      diag1_state && diag2_state
    end

    def empty?(pos)
      self[pos].nil?
    end

    def build_decreasing_diag(start_pos)
      diag_positions = [start_pos]

      loop do 
        new_pos1 = [diag_positions.first[0] - 1, diag_positions.first[1] - 1]
        new_pos2 = [diag_positions.last[0] + 1, diag_positions.last[1] + 1]
      
        break unless on_board?(new_pos1) || on_board?(new_pos2)

        diag_positions.unshift(new_pos1) if on_board?(new_pos1)
        diag_positions << new_pos2 if on_board?(new_pos2)
      end

      diag_positions
    end

    def build_increasing_diag(start_pos)
      diag_positions = [start_pos]

      loop do 
        new_pos1 = [diag_positions.first[0] + 1, diag_positions.first[1] - 1]
        new_pos2 = [diag_positions.last[0] - 1, diag_positions.last[1] + 1]
      
        break unless on_board?(new_pos1) || on_board?(new_pos2)

        diag_positions.unshift(new_pos1) if on_board?(new_pos1)
        diag_positions << new_pos2 if on_board?(new_pos2)
      end

      diag_positions
    end

    def on_board?(pos)
      pos.first.between?(0, 7) && pos.last.between?(0, 7)
    end
end

if $PROGRAM_NAME == __FILE__
  EightQueens.run_game
end