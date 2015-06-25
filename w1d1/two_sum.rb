class Array
  def two_sum
    results = []

    each_index do |i1|
      (i1 + 1...length).each do |i2|
        num1, num2 = self[i1], self[i2]
        results << [i1, i2] if num1 + num2 == 0
      end
    end

    results
  end
end

if $PROGRAM_NAME == __FILE__
  p [-1, 0, 2, -2, 1].two_sum == [[0, 4], [2, 3]]
end