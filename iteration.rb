require 'set'

def factors(num)
  (1..num).select { |div| num % div == 0 }
end

class Array
  def bubble_sort
    dup.bubble_sort!
  end

  def bubble_sort!
    sorted = false

    until sorted 
      sorted = true
      (1...length).each do |idx|
        prev_num, curr_num = self[idx - 1], self[idx]
        
        if prev_num > curr_num
          sorted, self[idx - 1], self[idx] = false, curr_num, prev_num 
        end
      end
    end

    self
  end
end

def substring(string)
  substrings = []

  string.length.times do |idx|
    (1..string.length - idx).each do |length|
      substring = string[idx, length]

      substrings << substring unless substrings.include?(substring)
    end
  end

  substrings
end

def subwords(string)
  substrings = substring(string)
  dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
  substrings.select { |subs| dictionary.include?(subs) }
end

if $PROGRAM_NAME == __FILE__
  p [4, 6, 3, 2, 1].bubble_sort
  p substring("cat")
  p subwords("cat")
end
