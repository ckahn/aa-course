class MyHashSet

  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.keys.include?(el)
  end

  def delete(el)
    if @store.keys.include?(el)
      @store.delete(el)
      return true
    else
      false
    end
  end

  def to_a
    @store.keys
  end

  def union(set2)
    (@store.keys + set2.keys).uniq
  end

  def intersect(set2)
    res = []
    set2.each do |x, v|
      if @store.keys.include?(x)
        res << x
      end
    end
    res
  end

  def minus(set2)
    res = []
    @store.each do |x, v|
      if !set2.keys.include?(x)
        res << x
      end
    end
    res
  end
end
