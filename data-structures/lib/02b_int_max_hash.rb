# How do we go from ArrayMap's O(n) operations and turn them into O(1)
# Imagine if we used ints as keys and there were only a limited of keys availabe

# Restrictions:
# - we can only store numbers as keys
# - the range of numbers is limited
# O(M): memory usage is proportional to max # of items stored

# We'd be given O(1) access and setting properties

class IntMaxHash
  def initialize(max_keys)
    @store = Array.new(max_keys)
  end

  # O(1)
  def get(key)
    @store[key]
  end

  # O(1)
  def include?(key)
    !!@store[key]
  end

  # O(1)
  def set(key, value)
    @store[key] = value
  end
end
