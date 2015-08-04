require_relative "03a_doubly_linked_list"

# LLs are good for LRU Caches
# If we couldn't assume hashmap entries were ordered,
# we could use an LL to track LRU items

class LinkedListLRUCache
  attr_reader :links_hash

  def initialize(max_size, &prc)
    @prc = prc
    @max_size = max_size
    @links_hash = {} # we keep a links hash so we can jump straight to a specific link
    @linked_list = DoublyLinkedList.new
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      # remove the link
      link.remove
      # push it back onto the list
      return @linked_list.push(link.value).value[1]
    end

    # not quite right
    if @max_size == @links_hash.length
      link_kv = @linked_list.shift
      @links_hash.delete(link_kv[0])
    end

    value = @prc.call(key)
    @links_hash[key] = @linked_list.push([key, value])

    value
  end
end
