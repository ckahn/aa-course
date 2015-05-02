require 'byebug'

class Array
  def my_uniq
    result = []
    self.each do |i|
      res << i unless result.include?(i)
    end
    res
  end

  def my_transpose
    transposed = Array.new(self.size) { [] }
    self.size.times do |row|
      self[row].size.times do |col|
        transposed[col][row] = self[row][col]
      end
    end
    transposed
  end

begin
  def two_sum
    result = []
    self.each_with_index do |n, idx1|
      self.each_with_index do |m, idx2|
        if m + n == 0 && idx1 != idx2 && idx1 < idx2
          result << [idx1, idx2]
        end
      end
    end
    result.sort
  end
end

=begin
  def my_transpose
    res = []
    i = 0
    while i < self.length
      temp = []
      self.each do |arr|
        temp << arr[i]
      end
      res << temp
      i += 1
    end
    res
  end
=end
end

if __FILE__ == $PROGRAM_NAME
  puts [1,2,2,2,2, 2, 3].my_uniq
  p [-1, 0, 2, -2, 1].two_sum
  p [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].my_transpose
end

def tower
  towers = [[1,2,3],
            [0,0,0],
            [0,0,0]]


  while towers[2] != [1, 2, 3]

    puts "Pick a pile."
    first = gets.chomp.to_i
    while first > towers.size-1
      puts "Pick a pile."
      first = gets.chomp.to_i
    end

    if towers[first].any? { |tower| tower != 0 }
      puts "Where do you want it?"
      second = gets.chomp.to_i
      towers[first].each_with_index do |disc, idx|
        if disc != 0
          val = disc
          idx2 = towers[second].size-1
          while idx2 >= 0
            if towers[second][idx2] == 0
              if towers[second][idx2+1] == nil || towers[second][idx2+1] > val
                towers[first][idx] = 0
                towers[second][idx2] = val
              end
              break
            end
            idx2 -= 1
          end
          break
        end
      end
    else
      puts "Try again"
    end
    p towers
  end
end

def num_to_s(num, base)
  
end
