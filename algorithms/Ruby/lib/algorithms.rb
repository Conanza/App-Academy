# Write a method that will sum the digits of a positive integer.
# If it is greater than or equal to 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the "digital root".
# Do not use string conversion within your method.
def digital_root(number)
  return number if number < 10

  ones_digit = number % 10
  remainder = number / 10

  digital_root(ones_digit + remainder)
end

# Write a function that takes a message and an increment amount and outputs the same letters shifted by that amount in the alphabet.
# Assume lowercase and no punctuation.
# Preserve spaces.
def caesar_cipher(string, shift)
  string.gsub(/\w/) do |letter|
    ((letter.ord - "a".ord + shift) % 26 + "a".ord).chr
  end
end

# Write a function that takes two strings and returns the longest common substring.
def common_substrings(string_one, string_two)
  longest_substring = ""

  short_string = string_one.length > string_two.length ? string_two : string_one
  long_string = string_one.length <= string_two.length ? string_two : string_one

  short_string.length.times do |i|
    len = longest_substring.length + 1

    (len..short_string.length - i).each do |len|
      substring = short_string[i, len]

      longest_substring = substring if long_string.include?(substring)
    end
  end

  return longest_substring
end

# Write a function that takes an array of integers and returns their sum.
# Use recursion.
def sum_rec(numbers)
  return 0 if numbers.empty?

  numbers[0] + sum_rec(numbers.drop(1))
end

# Write a function which returns the first n elements from the fibonnacci sequence, given n.
def fibs(n)
  fibs_seq = [0, 1]

  return fibs_seq.take(n) if n <= 2

  (n - 2).times { fibs_seq << fibs_seq[-1] + fibs_seq[-2] }

  fibs_seq
end

# Write a function that takes a string and returns true if it's a palindrome, false if it's not.
# Your solution should take less time and memory than rebuilding the string backward and comparing the two.
def is_palindrome?(string)
  (0...(string.length / 2)).each do |i|
    return false if string[i] != string[-1 - i]
  end

  true
end

# Implement the Folding Cipher.
# It folds the alphabet in half and uses the adjacent letter.
# a <=> z, b <=> y, c <=> x, m <=> n.
def folding_cipher(string)
  a_to_z = ("a".."z").to_a
  cipher = Hash[a_to_z.zip(a_to_z.reverse)]

  string.gsub(/\w/) { |letter| cipher[letter] }
end

# Write a method that finds all the unique substrings for a word.
def uniq_subs(string)
  uniq_subs = {}

  string.length.times do |i|
    (1..string.length - i).each do |len|
      subs = string[i, len]

      uniq_subs[subs] = true
    end
  end

  uniq_subs.keys
end

# Given an array of integers (positive and negative) find the largest contiguous subsum (sum of a subarray).
# You can solve this trivially in O(n**2) time by considering all subarrays.
# Try to solve it in O(n) time with O(1) memory.
def lcs(array)
  max_sum = array.first || 0

  sum = 0
  array.each do |num|
    sum += num

    if sum > max_sum
      max_sum = sum
    elsif sum < 0
      sum = 0
    end
  end

  max_sum
end

# Write a function that takes a year (four digit integer) and returns an array with the 10 closest subsequent years that meet the following condition:
# the first two digits summed with the last two digits are equal to the middle two digits.
def silly_years(year)
  silly_years = []

  until silly_years.length == 10
    silly_years << year if is_silly_year?(year)
    year += 1
  end

  silly_years
end

def is_silly_year?(year)
  first_two = year.to_s[0..1].to_i
  last_two = year.to_s[2..3].to_i
  mid = year.to_s[1..2].to_i

  first_two + last_two == mid
end

# Given an array of integers, return all pairs that sum up to a specified value k.
# List the pairs in [min, max] order.
# Time complexity: O(n).
# Return a set.
def pair_sum(array, k)
  pairs = Set.new
  seen = Set.new

  array.each do |num|
    diff = k - num
    pairs << [[diff, num].min, [diff, num].max] if seen.include?(diff)

    seen << num
  end

  pairs
end

# Given a matrix of integers and coordinates of a rectangular region within the matrix.
# Find the sum of numbers falling inside the rectangle.
# Time complexity: O(number of rows * number of columns).
def matrix_region_sum(matrix, top_left_coords, bottom_right_coords)
  x_max = bottom_right_coords[1]
  x_min = top_left_coords[1]
  y_max = bottom_right_coords[0]
  y_min = top_left_coords[0]
  sum = 0

  (x_min..x_max).each do |x_coord|
    (y_min..y_max).each do |y_coord|
      sum += matrix[y_coord][x_coord]
    end
  end

  sum
end

# Implement Merge Sort (Hint: this typically involves a helper function)
def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = array[0...mid]
  right = array[mid..-1]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  merged_array = []

  until left.empty? || right.empty?
    if left.first > right.first
      merged_array << right.shift
    else
      merged_array << left.shift
    end
  end

  merged_array.concat(left).concat(right)
end

# Implement binary search.
# Return nil if the target isn't found.
def binary_search(array, target)
  return nil if array.empty?

  mid = array.length / 2
  test = array[mid]

  if test == target
    return mid
  elsif test > target
    return binary_search(array.take(mid - 1), target)
  else
    result = binary_search(array.drop(mid + 1), target)

    return result.nil? ? nil : 1 + mid + result
  end
end

# Given a list of numbers in an array, replace all the numbers
# with the product of all other numbers. Do this in O(n) time without
# using division.
def productify(array)
  products = [1] * array.length

  current_product = 1
  products.each_index do |i|
    products[i] *= current_product

    current_product *= array[i]
  end

  current_product = array.last
  (array.length - 2).downto(0) do |j|
    products[j] *= current_product

    current_product *= array[j]
  end

  products
end

# Write a function that takes an array and returns all of its subsets.
def subsets(array)

end

# Take a string and return the indices of the start/end of the longest palindrome it contains.
# Your palindrome checker could reverse the string and compare it to the original, but that takes extra memory.
# Instead, you should be able to solve the problem with O(1) memory.
def longest_palindrome(string)

end

# Given two arrays, find the intersection of both sets.
# It should be trivial to write an O(n**2) solution. Use sorting to solve in O(nlog(n)).
# Next, improve this to O(n) time (maybe use a non-array datastructure).
def fast_intersection(array_one, array_two)

end

# Write a function that takes two arrays of integers and returns an array with all the subsets commmon to both.
# Don't generate all subsets of both array, which would take time exponential time.
# Instead, directly generate the subsets of both.
def common_subsets(array_one, array_two)

end

# Given an array and index,
# find if it's possible to reach 0 by starting at the index
# and repeatedly moving left/right by the distance found at array[index].
def can_win?(array, index)

end

# Assume an array of length n, containing the numbers 1..n in jumbled order.
# "Sort" this array in O(n) time.
# You should be able to do this without looking at the input.
def sort1(array)

end

# Assume an array of length n with numbers in the range 1..N (N >= n).
# Sort this array in O(n + N) time.
# You may use O(N) memory.
def sort2(array, max_value)

end

# Say I give you an array of n strings, each of length k.
# Merge sort can sort this in O(knlog(n)), since comparing a pair of strings takes O(k) time.
# Sort the strings in O(kn).
# Hint: do not compare any two strings.
# All strings contain only lowercase letters a..z without whitespace or punctuation.
def sort3(array, length)

end

# Given an array, move all zeros to the end.
# The order of non-zero elements does not matter.
# Try to accomplish this in O(n) time and O(1) space.
def move_zeros(array)

end

# Implement the 'look and say' function.
#'Look and say' takes an input array and outputs an array.
# The output array describes the count of the elements in the input array as they appear in order.
def look_and_say(array)

end

# Implement a stack with a method max that returns the maximum value.
# It should run in O(1) time.
class MaxStack
  def initialize
    @store = []
  end

  def push(value)
    if @store.empty?
      @store << [value, value]
    else
      @store << [value, [self.max, value].max]
    end
  end

  def pop
    val, _ = @store.pop

    val
  end

  def max
    @store[-1][1]
  end
end
