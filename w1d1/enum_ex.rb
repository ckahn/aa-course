class Array

  def double(arr)
    arr.map { |num| num*2 }
  end

  def my_each
    idx = 0
    while idx < self.size
      yield(self[idx])
      idx += 1
    end
    self
  end

  def median
    return nil if self.empty?
    mid = self.length/2
    if mid %2 == 0
      self[mid]
    else
      (self[mid] + self[mid-1])/2.0
    end
  end


end

def concatenate(arr)
  arr.inject('') { |word, res| word + res }
end
