def factors(num)
  (1..num).select { |div| num % div == 0 }
end

# def bubblesort(arr)
#   (arr.length - 1).times do
#     (arr.length - 1).times do |i|
#       arr[i], arr[i+1] = arr[i+1], arr[i] if arr[i] > arr[i+1]
#     end
#   end
#   arr
# end

class Array
  def bubble_sort
    self.dup.bubble_sort!
  end

  def bubble_sort!
    sorted = false

    until sorted 
      sorted = true
      (1...self.length).each do |idx|
        prev_num, curr_num = self[idx - 1], self[idx]
        
        if prev_num > curr_num
          sorted = false
          self[idx - 1], self[idx] = curr_num, prev_num 
        end
      end
    end
    self
  end
end

def substring(str)
  substrings = []

  str.each_char.with_index do |char, idx|
    (1..str.length - idx).each do |length|
      substring = str[idx, length]

      substrings << substring unless substrings.include?(substring)
    end
  end

  substrings
end

def subwords(str)
  substrs = substring(str)
  dict = File.readlines("dictionary.txt")
  substrs.select { |substr| dict.include?("#{substr}\n") }.map(&:chomp)
end


p [4, 6, 3, 2, 1].bubble_sort
p substring("cat")
p subwords("cat")