class Array
  def my_each(&proc)
    i = 0
    while i < self.length
      proc.call(self[i])
      i += 1
    end
  end

  def my_map(&proc)
    result = []
    i = 0
    while i < self.length
      result[i] = proc.call(self[i])
      i += 1
    end
    result
  end

  def my_select(&proc)
    result = []
    i = 0
    while i < self.length
      result << self[i] if proc.call(self[i])
      i += 1
    end
    result
  end

  def my_inject(&proc)
    result = 0
    self.my_each do |el|
      result = proc.call(result, el)
    end
    result
  end

  def my_sort!(&proc)
    sorted = false
    until sorted
      sorted = true
      (self.size - 1).times do |idx|
        if proc.call(self[idx], self[idx + 1]) > 0
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def my_sort(&proc)
    self.dup.my_sort!(&proc)
  end
end

def eval_block(*args, &proc)
  return "NO BLOCK GIVEN" unless proc
  proc.call(*args)
end
