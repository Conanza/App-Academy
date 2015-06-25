
#   def my_sort!(&prc)
#     return self if length < 2

#     left, right = [], []
#     pivot = self[length / 2]

#     each_with_index do |el, idx|
#       next if idx == length / 2
#       prc.call(pivot, el) == -1 ? right << el : left << el
#     end

#     self[0...left.length] = left.my_sort!(&prc)
#     self[left.length] = pivot
#     self[left.length + 1..-1] = right.my_sort!(&prc)

#     self
#   end


class Array
  def my_each(&prc)
    length.times { |i| prc.call(self[i]) }

    self
  end

  def my_map(&prc)
    new_array = []
    my_each { |el| new_array << prc.call(el) }
    new_array
  end

  def my_select(&prc)
    new_array = []
    my_each { |el| new_array << el if prc.call(el) }
    new_array
  end

  def my_inject(&prc)
    dup_array = self.dup
    accumulator = dup_array.shift

    dup_array.my_each { |el| accumulator = prc.call(accumulator, el) }

    accumulator
  end

  def my_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    sorted = false
    until sorted
      sorted = true

      (1...length).each do |idx|
        prev_num, curr_num = self[idx - 1], self[idx]
        placement = prc.call(prev_num, curr_num)

        if placement > 0 
          sorted = false
          self[idx - 1], self[idx] = curr_num, prev_num
        end
      end
    end

    self
  end

  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

def eval_block(*args, &prc)
  block_given? ? prc.call(*args) : "NO BLOCK GIVEN" 
end

if __FILE__ == $PROGRAM_NAME
  array = [0,1,3,4]
  puts "my_each test"
  array.my_each { |x| puts(x + 1) }
  p array 

  puts "\nmy_map test"
  p array.my_map { |x| x + 1 }
  p array 

  puts "\nmy_select test"
  p array.my_select { |x| x >1 }
  p array 

  puts "\nmy_inject test"
  puts array.inject { |sum, n| sum + n ** 2 }
  p array

  puts "\nmy_sort test"
  unsorted_array = [4,1,6,3,1,7,2]
  p unsorted_array.my_sort { |x, y| x <=> y }
  p unsorted_array.my_sort { |x, y| y <=> x }
  p unsorted_array
  p unsorted_array.my_sort!
  p unsorted_array

  puts "\neval_block test"
  p eval_block(1, 2, 3)
  p eval_block(1, 2, 3) { |x, y, z| x + y + z }
  arr = [4, 5, 6]
  p eval_block(arr) { |x, y, z| x + y + z }
end
