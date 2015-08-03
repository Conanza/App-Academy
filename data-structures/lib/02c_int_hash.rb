require_relative "02a_array_map"

class IntHash
  def initialize
    @buckets = Array.new(4) { ArrayMap.new }
    @count = 0
  end

  # O(1) AVG
  def get(k)
    @buckets[k % @buckets.length].get(k)
  end

  # O(1) AVG
  def has_key?(k)
    @buckets[k % @buckets.length].has_key?(k)
  end

  # O(1) amortized
  def set(k, v)
    # O(1) AVG
    if has_key?(k)
      @buckets[k % @buckets.length].set(k, v)
      return
    end

    # O(n)
    resize! if @count == @buckets.length

    @buckets[k % @buckets.length].set(k, v)
    @count += 1
  end

  private

  # We resize to keep the proportion of n to the # of buckets <= 1
  # O(n) because it's based on the number of items we need to re-set
  def resize!
    new_buckets = Array.new(@buckets.length * 2) { ArrayMap.new }

    @buckets.each do |bucket|
      bucket.each do |k, v|
        new_buckets[k % new_buckets.length].set(k, v)
      end
    end

    @buckets = new_buckets
  end
end
