class DynamicArray
  def initialize(n)
    @store = Array.new(n, nil)
    @capacity = n
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  def length
    @length
  end
  alias_method :size, :length

  # O(1)
  def pop
    return nil unless length > 0
    val, self[@length - 1] = self[@length - 1], nil
    @length -= 1

    val
  end

  # O(1) amortized
  # O(n) W.C.
  def push(value)
    resize! if length == @capacity
    @length += 1
    self[@length - 1] = value

    self
  end

  # O(n)
  def shift
    return nil if length == 0
    val = self[0]
    (1...length).each { |i| self[i - 1] = self[i] }
    @length -= 1

    val
  end

  # O(n)
  def unshift(value)
    resize! if length == @capacity
    @length += 1
    (length - 1).downto(1) { |i| self[i] = self[i - 1] }
    self[0] = value

    self
  end

  private

  attr_reader :store, :capacity

  def check_index(index)
    unless index >= 0 && index < length
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = Array.new(new_capacity, nil)

    length.times { |i| new_store[i] = self[i] }

    @capacity = new_capacity
    @store = new_store
  end
end
