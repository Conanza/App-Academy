require_relative "05c_binary_heap_priority_queue"

class Array
  def heap_sort
    binheap = BinHeapPriorityQueue.new
    sorted_arr = []
    self.length.times { |i| binheap.push(self[i], self[i]) }
    binheap.length.times { |i| sorted_arr << binheap.shift }

    sorted_arr
  end
end
