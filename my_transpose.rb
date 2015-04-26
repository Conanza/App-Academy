class Array
  def my_transpose
    transposed = Array.new(length) { Array.new(length) }

    each_index do |y|
      each_index do |x|
        transposed[y][x] = self[x][y]
      end
    end

    transposed
  end
end

p [[0, 1, 2],
   [3, 4, 5],
   [6, 7, 8]].my_transpose == [[0, 3, 6], 
                               [1, 4, 7], 
                               [2, 5, 8]]
