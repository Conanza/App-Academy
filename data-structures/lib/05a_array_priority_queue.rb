class ArrayPriorityQueue
  def initialize
    @store = []
  end

  # O(n)
  def push(val, priority)
    idx = @store.index { |v, p| priority < p }
    if idx.nil?
      @store << [val, priority]
    else
      @store.insert(idx, [val, priority])
    end
  end

  # O(1) if we used a ring buffer
  def shift
    val, _ = @store.shift

    val
  end
end
