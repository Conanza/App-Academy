class Board
  attr_accessor :grid, :winner

  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @winner = nil
  end

  def [](pos)
    row, col = pos.first, pos.last
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos.first, pos.last
    @grid[row][col] = mark
  end

  def won?
    check_rows? || check_columns? || check_diags?
  end

  def check_rows?
    @grid.any? { |row| all_same?(row) }
  end

  def check_columns?
    @grid.transpose.any? { |col| all_same?(col) }
  end

  def check_diags?
    diag1 = (0..2).map { |i| @grid[i][i] }
    diag2 = [[0, 2], [1, 1], [2, 0]]
    diag2.map! { |x, y| @grid[x][y] }

    all_same?(diag1) || all_same?(diag2)
  end

  def all_same?(array)
    if array.all? { |value| value == :o }
      @winner = :o
    elsif array.all? { |value| value == :x }
      @winner = :x
    end
  end

  def empty?(pos)
    !self[pos]
  end

  def place_mark(pos, mark)
    valid_move?(pos, mark) ? self[pos] = mark : false
  end

  def valid_move?(pos, mark)
    return false unless pos.all? { |coord| coord.between?(0, grid.length - 1) }
    
    self[pos].nil?
  end

  def delete_mark(pos)
    self[pos] = nil
  end

  def render
    grid.each do |line|
      p line.map { |char| mapping(char) }.join(" | ")
    end
  end

  def mapping(char)
    case char
    when nil then return "_"
    when :o then return "O"
    when :x then return "X"
    end
  end
end

class Game
  def initialize(player1, player2)
    @players = player1, player2
  end

  def play
    board = Board.new
    until board.won?
      @players = @players.rotate(1)
      @players.last.go(board)
      board.render
      puts
    end

    puts "Congrats #{board.winner.to_s.upcase}!"
  end
end

class Player
  attr_accessor :sym

  def initialize(symbol)
    @sym = symbol
  end
end

class HumanPlayer < Player
  def go(board)
    puts "What's your X-coordinate?"
    x = Integer(gets)
    puts "What's your Y-coordinate?"
    y = Integer(gets)
    if !board.place_mark([x, y], sym)
      puts "Invalid move. Try again."
      go(board)
    end
  end
end

class ComputerPlayer < Player
  def go(board)
    #iterate through board checking for winning move
    winnable_move = false
    board.grid.each_index do |idx1|
      board.grid.each_index do |idx2|
        winnable_move = true if winning_move?(board, [idx1, idx2])
      end
    end

    unless winnable_move
      random_move(board)
    end
  end

  def winning_move?(board, pos)
    if board.place_mark(pos, sym)
      if board.won?
        true
      else
        board.delete_mark(pos)
        false
      end
    else
      false
    end
  end

  def random_move(board)
    coords = [0, 1, 2]
    until board.place_mark([coords.sample, coords.sample], sym)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  symbol = :x
  other_symbol = symbol == :x ? :o : :x
  me = HumanPlayer.new(symbol)
  com = ComputerPlayer.new(other_symbol)
  game = Game.new(me, com)
  game.play
end
