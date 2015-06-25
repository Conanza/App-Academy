class Integer
  def double
    self * 2
  end
end

class Array
  def avg
    reduce(:+) / length.to_f
  end

  def median
    sorted = self.sort
    mid = length / 2
    length.odd? ? sorted[mid] : [sorted[mid], sorted[mid - 1]].avg
  end

  def my_each(&block)
    length.times { |index| block.call(self[index]) }
    
    self
  end

  def string_concat
    reduce(:+)    
  end
  
  def times_two
    map(&:double)
  end
end

if $PROGRAM_NAME == __FILE__
  puts "times_two test"
  puts [1, 2, 3, 4].times_two == [2, 4, 6, 8]

  p "my_each test"
  return_value = [1, 2, 3]
  return_value.my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end
  p return_value == [1, 2, 3]

  p "median tests"
  p [1,2,3].median == 2
  p [1,2,3,4].median == 2.5

  p "concat test"
  p ["Yay ", "for ", "strings!"].string_concat == "Yay for strings!"
end
