class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[3, 2, 1, 0], [], []]
  end

  def move_disk(from, to)
    raise unless valid_move?(from, to)
    disk = @towers[from].pop
    @towers[to].push(disk)
  end

  def wins?
    @towers[0].empty? && (@towers[1].size == 4 || @towers[2].size == 4)
  end

  private

  def valid_move?(from, to)
    return false unless (from.between?(0, 2) && to.between?(0, 2))
    return false if @towers[from].empty?
    return false if @towers[to].last && (@towers[from].last > @towers[to].last)
    true
  end
end
