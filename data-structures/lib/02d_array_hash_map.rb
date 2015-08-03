require_relative "02a_array_map"

class ArrayHashMap
  def initialize(size = 5)
    @size = size
    @buckets = Array.new(@size) { ArrayMap.new }
    @count = 0
  end

  # O(1) AVG
  def delete(k)
    return nil unless has_key?(k)

    @count -= 1
    @buckets[k.hash % @buckets.length].delete(k)
  end

  # O(1) AVG
  def get(k)
    @buckets[k.hash % @buckets.length].get(k)
  end
  alias_method :[], :get

  # O(1) amortized
  def set(k, v)
    if has_key?(k)
      @buckets[k.hash % @buckets.length].set(k, v)
      return
    end

    resize! if @count == @buckets.length

    @buckets[k.hash % @buckets.length].set(k, v)
    @count += 1

    v
  end
  alias_method :[]=, :set

  # O(1) AVG
  def has_key?(k)
    @buckets[k.hash % buckets.length].has_key?(k)
  end
  alias_method :include?, :has_key?

  private

  attr_reader :buckets, :count, :size

  # O(n)
  def resize!
    @size *= 2
    new_buckets = Array.new(@size) { ArrayMap.new }

    @buckets.each do |bucket|
      bucket.each do |k, v|
        new_buckets[k.hash % new_buckets.length].set(k, v)
      end
    end

    @buckets = new_buckets
  end
end
