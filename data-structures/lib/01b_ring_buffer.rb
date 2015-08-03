class RingBuffer
  attr_reader :length

  def initialize(n)
    @store = Array.new(n, nil)
    @capacity, @length, @start_idx = n, 0, 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    return nil unless length > 0
    val, self[length - 1] = self[length - 1], nil
    @length -= 1

    val
  end

  # O(1) amortized
  # O(n) W.C.
  def push(value)
    resize! if length == capacity

    @length += 1
    self[length - 1] = value

    self
  end

  # O(1)
  def shift
    return nil unless length > 0
    val, self[0] = self[0], nil
    @length -= 1
    @start_idx = (@start_idx + 1) % capacity

    val
  end

  # O(1) amortized
  # O(n) W.C.
  def unshift(value)
    resize! if length == capacity
    @start_idx = (@start_idx - 1) % capacity
    self[0] = value
    @length += 1

    self
  end

  private

  attr_reader :capacity, :start_idx, :store

  def check_index(index)
    unless index >= 0 && index < length
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = capacity * 2
    new_store = Array.new(new_capacity, nil)
    length.times { |i| new_store[i] = self[i] }

    @capacity = new_capacity
    @store = new_store
    @start_idx = 0
  end
end
