# Write a program that will find a route between two points in a maze
#
# ****************
# *         *   E*
# *    *    *  ***
# *    *    *    *
# *    *    *    *
# *    *    *    *
# *S   *         *
# ****************
#
# S being start and E being end 
#
# Read in the maze, try to explore through it to the end, 
# and print out a completed path
#
# ****************
# *XXXXXXXXX* XXE*
# *X   *   X* X***
# *X   *   X* X  *
# *X   *   X* X  *
# *X   *   X* X  *
# *S   *   XXXX  *
# ****************
#
# run program as a cmd line script, taking in maze file on the cmd line
#
# path through maze shouldn't be self intersecting
#
# after find a solution, write a version that guarantees the shortest path


#!/usr/bin/env ruby

class MazeSolver
  attr_reader :maze

  def initialize(filename)
    @maze = File.readlines(filename)
    @visitied_positions = [find_pos("S")]
  end

  def find_pos(place)
    maze.each_with_index do |row, i|
      row.each_with_index do |col, j|
        return [i, j] if col == place
      end
    end

    nil
  end

  def build_moves

  end

  def trace_path

  end

  def solve
    start = find_pos("S")
    finish = find_pos("E")
  end

  # def maze_each(&prc)
  #   self.each_with_index do |row, i|
  #     row.each_with_index do |col, j|
  #       prc.call(col)
  #     end
  #   end
  # end
end


if $PROGRAM_NAME == __FILE__
  if ARGV[0].empty?
    return
  else
    file = ARGV[0]
    maze = MazeSolver.new(file)
  end
end