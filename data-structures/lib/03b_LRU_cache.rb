# An LRU Cache with ruby hash
# This is easy because ruby hashes are ordered

class LRUCache
  def initialize(max_size, &prc)
    @store = {}
    @max_size = max_size
    @prc = prc
  end

  def [](key)
    if @store.has_key?(key)
      value = @store.delete(key)
    else
      eject! if @store.length == @max_size
      value = @prc.call(key)
    end

    @store[key] = value

    value
  end

  private

  def eject!
    key, _ = @store.first
    @store.delete(key)
  end
end
