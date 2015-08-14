require_relative "05c_binary_heap_priority_queue"

class Array
  # TC: O(nlogn)
  # SC: can be done in place for O(1)
  # Consistent performance
  # Good when low on memory
  def heap_sort
    binheap = BinHeapPriorityQueue.new
    sorted_arr = []
    self.length.times { |i| binheap.push(self[i], self[i]) }
    binheap.length.times { |i| sorted_arr << binheap.shift }

    sorted_arr
  end
end
