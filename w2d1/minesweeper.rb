require 'byebug'

class Tile
  attr_accessor :flagged, :bombed, :board, :revealed, :fringe,
                :adjacent_bombs, :interior

  def initialize(board, pos)
    @interior = false
    @board = board
    @revealed = false
    @bombed = false
    @flagged = false
    @pos = pos
    @adjacent_bombs = 0
    @fringe = false
  end

  def bomb?
    @bombed
  end

  def neighbors
    # try to use [-1, 0, 1].permutation(2).to_a instead
    diffs = [-1, 0, 1]
    arr = []
    diffs.each do |x|
      diffs.each do |y|
        next if x == 0 && y == 0
        d_x = @pos.first + x
        d_y = @pos.last + y
        arr << @board.grid[d_x][d_y] if in_bound?(d_x, d_y)
      end
    end

    arr
  end

  def neighbors_bomb_count
    self.neighbors.count { |tile| tile.bomb? }
  end

  def in_bound?(x, y)
    grid_size = @board.grid.size
    x >= 0 && y >= 0 && x < grid_size && y < grid_size
  end

  def reveal
    raise "It's a bomb!" if @bombed
    return if @flagged
    @revealed = true
    @interior = true
    self.neighbors.each do |tile|
      if tile.neighbors_bomb_count > 0
        tile.fringe = true
        tile.revealed = true
        tile.adjacent_bombs = tile.neighbors_bomb_count
      elsif !tile.bomb? && !tile.revealed
        tile.reveal
      end
    end
  end
end


class Board
  attr_reader :bombs, :grid, :size

  def initialize(size = 9, bomb_count = 9)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
    @bomb_count = bomb_count
    generate_tiles
    set_bombs
  end

  def generate_tiles
    0.upto(@grid.length - 1) do |row|
      0.upto(@grid.length - 1) do |col|
        @grid[row][col] = Tile.new(self, [row, col])
      end
    end
  end

  def set_bombs
    bomb_count = 0
    until bomb_count == @bomb_count
      x, y = rand(@size), rand(@size)
      unless @grid[x][y].bomb?
        @grid[x][y].bombed = true
        bomb_count += 1
      end
    end
  end

  def display
    puts "   0  1  2  3  4  5  6  7  8"
    0.upto(@grid.size - 1) do |row|
      print row.to_s + " "
      0.upto(@grid.size - 1) do |column|
        tile = @grid[row][column]
        if !tile.revealed && !tile.flagged
          print ' * '
        elsif tile.interior
          print ' _ '
        elsif tile.flagged
          print ' F '
        else
          print " #{tile.adjacent_bombs} "
        end
      end
      print "\n"
    end
  end

  def prompt
    puts "Flag or Reveal? (F/R)"
    action = gets.chomp.upcase
    puts "Select a tile: "
    x, y = gets.split(',').map(&:to_i)
    tile = @grid[x][y]
    tile.reveal if action == 'R'
    tile.flagged = !tile.flagged if action == 'F'

    display
  end

  def over?
    self.grid.all? do |rows|
      rows.all? { |tile| tile.flagged ? tile.bomb? : tile.revealed }
    end
  end
end

class Game
  def play
    puts "New Game or Saved Game? (N/S)"
    answer = gets.chomp
    board = Board.new
=begin
    if answer == 'N'
      puts "How big of a game do you want?"
      size = gets.chomp.to_i
      board = Board.new(size)
    else
      yml = File.read("minesweeper.txt")
      board = YAML::load(yml)
    end
=end
    board.display
    until board.over?
      board.prompt
    end
    puts "You win"
  end
end

# p tile = Tile.new
# board = Board.new
# p board.bombs
# board.display
if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
