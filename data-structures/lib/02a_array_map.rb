class ArrayMap
  def initialize
    @store = []
  end

  # O(n)
  def set(k, v)
    @store.each do |kvpair|
      next unless kvpair[0] == k

      kvpair[1] = v
      return
    end

    @store << [k, v]
  end

  # O(n)
  def get(k)
    @store.each do |kvpair|
      next unless kvpair[0] == k
      return kvpair[1]
    end

    nil
  end

  # O(n)
  def has_key?(k)
    @store.any? { |kvpair| kvpair[0] == k }
  end

  def each(&prc)
    @store.each do |item|
      prc.call(item)
    end
  end
end
