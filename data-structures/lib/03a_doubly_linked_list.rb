class Link
  attr_accessor :value, :next, :prev
  def initialize(val)
    @value = val
    @next, @prev = nil, nil
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    self.next, self.prev = nil, nil
  end
end

class SentinelLink < Link
  def initialize
    super(nil)
  end

  def remove
    raise "can't remove sentinel links"
  end
end

class DoublyLinkedList
  def initialize
    @start_sentinel = SentinelLink.new
    @end_sentinel = SentinelLink.new

    @start_sentinel.next, @end_sentinel.prev = @end_sentinel, @start_sentinel
  end

  def empty?
    @start_sentinel.next == @end_sentinel
  end

  # O(1)
  def push(value)
    new_link = Link.new(value)

    new_link.next = @end_sentinel
    new_link.prev = @end_sentinel.prev

    @end_sentinel.prev.next = new_link
    @end_sentinel.prev = new_link

    new_link
  end

  # O(1)
  def pop
    raise "can't pop from empty list" if empty?

    last_link = @end_sentinel.prev
    @end_sentinel.prev = last_link.prev
    last_link.prev.next = @end_sentinel
    last_link.prev, last_link.next = nil, nil

    last_link.value
  end

  # O(1)
  def shift
    raise "can't shift from empty list" if empty?
    first_link = @start_sentinel.next
    @start_sentinel.next = first_link.next
    first_link.next.prev = @start_sentinel
    first_link.next, first_link.prev = nil, nil

    first_link.value
  end

  # O(1)
  def unshift(value)
    new_link = Link.new(value)

    new_link.next = @start_sentinel.next
    new_link.prev = @start_sentinel

    @start_sentinel.next.prev = new_link
    @start_sentinel.next = new_link

    new_link
  end

  def inspect
    results = []
    link = @start_sentinel

    until link.next.nil?
      results << link.value
      link = link.next
    end

    results << link.value

    results
  end
end
