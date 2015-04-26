class MyHashSet
  def initialize
    @store = {}
  end

  def delete(el)
    !!@store.delete(el)
  end

  def include?(el)
    store.has_key?(el) 
  end

  def insert(el)
    store[el] = true
  end

  def to_a
    store.keys
  end

  def union(set2)
    new_set = MyHashSet.new
    new_set.store = store.merge(set2.store)
    new_set
  end

  def intersect(set2)
    new_set = MyHashSet.new
    new_set.store = store.select { |el| set2.store.include?(el) }
    new_set
  end

  def minus(set2)
    new_set = MyHashSet.new
    new_set.store = store.reject { |el| set2.store.include?(el) }
    new_set
  end

  protected

    attr_accessor :store
end


if $PROGRAM_NAME == __FILE__
  set1 = MyHashSet.new
  10.times { |value| set1.insert(value) }
  set2 = MyHashSet.new
  set2.insert(15)

  puts set1.include?(5) == true
  puts set1.delete(5) == true
  puts set1.delete(5) == false
  puts set1.include?(5) == false
  puts set1.include?(11) == false
  puts set1.to_a == [0, 1, 2, 3, 4, 6, 7, 8, 9]
  puts set1.union(set2).to_a == [0, 1, 2, 3, 4, 6, 7, 8, 9, 15]
  set2.insert(9)
  puts set1.intersect(set2).to_a == [9]
  puts set1.minus(set2).to_a == [0, 1, 2, 3, 4, 6, 7, 8]
end