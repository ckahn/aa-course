class Array
  def my_uniq
    result = []
    (0...self.length).each do |idx|
       result << self[idx] unless result.include?(self[idx])
    end
    result
  end

  def two_sum
    result = []
    (0...(self.length - 1)).each do |idx1|
      ((idx1 + 1)...self.length).each do |idx2|
        if self[idx1] + self[idx2] == 0
          result << [idx1, idx2]
        end
      end
    end
    result
  end

  def my_transpose
    raise ArgumentError if self == []
    raise ArgumentError unless self.all? { |row| row.is_a?(Array) }
    raise ArgumentError unless self.all? { |row| row.size == self.size }

    result = Array.new(self.length) { []  } 
    (0...self.length).each do |row|
      (0...self.length).each do |col|
        result[row][col] = self[col][row]
      end
    end

    result
  end
end
