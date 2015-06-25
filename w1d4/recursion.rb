
class Array
  def bsearch(target)
    return nil if empty?

    mid = length / 2
    current_number = self[mid]
    return mid if current_number == target

    left_half = self[0...mid]
    right_half = self[mid + 1..-1]

    if target > current_number
      rsearch = right_half.bsearch(target)
      rsearch.nil? ? nil : 1 + mid + rsearch
    else
      left_half.bsearch(target)
    end
  end

  def recursive_sum
    return 0 if empty?

    first + self.drop(1).recursive_sum
  end

  def iterative_sum
    inject(0, :+)
  end

  def deep_dup
    dup_array = []
    each { |el| dup_array << (el.is_a?(Array) ? el.deep_dup : el) }
    dup_array
  end

  def merge_sort
    return self if length <= 1

    left_half = self[0...length / 2]
    right_half = self[length / 2..-1]
  
    Array.merge(left_half.merge_sort, right_half.merge_sort)
  end

  def self.merge(array1, array2)
    merged = []
    until array1.empty? && array2.empty?
      num1, num2 = array1.first, array2.first
      if array1.empty? 
        merged << array2.shift
      elsif array2.empty?
        merged << array1.shift
      elsif num1 <= num2 
        merged << array1.shift
      else
        merged << array2.shift
      end
    end

    merged 
  end

  def subsets_rec
    return [[]] if empty?

    subset = take(length - 1)
    smaller_subsets = subset.subsets_rec
    
    bigger_subsets = []
    smaller_subsets.each do |subs|
      bigger_subsets << subs + [last]
    end

    smaller_subsets + bigger_subsets
  end

  def subsets_iterative
    subsets = []
    (0..length).each do |size|
      combination(size).each { |combo| subsets << combo }
    end
    subsets
  end
end

def range(start, finish)
  return [] if start > finish
  return [start] if start == finish
  [start] + range(start + 1, finish)
end

def exp1(b, exp)
  return 1 if exp.zero?

  b * exp1(b, exp - 1)
end

def exp2(b, exp)
  return 1 if exp.zero?
  return b if exp == 1

  temp = exp2(b, exp / 2)
  if exp.even?
    temp * temp
  else
    b * temp * temp
  end
end

def fib_iterative(n)
  fib = [0, 1]
  return [] if n.zero?
  return fib[0..n - 1] if n <= 2

  (n - 2).times { fib << fib.last + fib[-2] }
  fib
end

def fib_rec(n)
  return [] if n.zero?
  return [0] if n == 1
  return [0, 1] if n == 2

  new_fib = fib_rec(n - 1).last + fib_rec(n - 1)[-2]

  fib_rec(n - 1) + [new_fib]
end

def american_make_change(total, currency)
  change = []
  return change if currency.empty?

  num_currency = total / currency.first 
  remainder = total % currency.first
  num_currency.times { change << currency.first }

  change + american_make_change(remainder, currency.drop(1))
end

def efficient_change(total, currency)
  change = []
  return change if currency.empty? || total <= 0

  possible_change = []
  currency.each do |bill|
    next if bill > total
    remainder = total - bill

    possible_change << ([bill] + efficient_change(remainder, currency))
  end
  
  possible_change.min_by { |change| change.length }
end

# def subsets(array) 
#   return [[]] if array.empty?
  
#   subsets = []
#   (0...array.length).each do |idx|
#     dup_array = array.dup 
#     pick_single = dup_array.delete_at(idx)
    
#     subsets += ([[pick_single]] + [dup_array + [pick_single]] + 
#                   subsets(dup_array)).uniq
#   end

#   subsets.map(&:sort).uniq
# end
