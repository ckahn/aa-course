require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid

  def initialize(add_pieces = true)
    @grid = Array.new(8) { Array.new(8) }
    add_starting_pieces if add_pieces
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def dup
    dup_board = Board.new(false)
    pieces.each do |piece|
      Piece.new(piece.color, piece.pos, dup_board, piece.king)
    end
    dup_board
  end

  def over?(color)
    player_pieces = pieces.select { |piece| piece.color == color }
    return true if player_pieces.empty?
    player_pieces.all? do |piece|
      piece.slides.empty? && piece.jumps.empty?
    end
  end

  def occupied?(pos)
    self[pos].nil? ? false : true
  end

  def occupied_by_opponent?(pos, player_color)
    return false unless occupied?(pos)
    self[pos].color != player_color
  end

  def piece(pos, color)
    piece = self[pos]
    raise "No piece there" if piece.nil?
    raise "Not your piece" if piece.color != color
    piece
  end

  def render
    str = ""
    8.times do |row|
      str << "#{row} "
      8.times do |column|
        piece = self[[row, column]]
        str << "|#{piece.nil? ? '_' : piece.symbol}"
      end
      str << "|\n"
    end
    str << "   0 1 2 3 4 5 6 7\n"
    str
  end

  private

  # Needs refactoring TODO
  def add_starting_pieces
    rows = [0, 1, 2, 5, 6, 7]
    columns = [0, 2, 4, 6]
    rows.each do |row|
      if row.even? && row <= 2
        columns.map(&:succ).each do |column|
          Piece.new(:red, [row, column], self)
        end
      elsif row <= 2
        columns.each do |column|
          Piece.new(:red, [row, column], self)
        end
      elsif row.even? && row > 2
        columns.map(&:succ).each do |column|
          Piece.new(:black, [row, column], self)
        end
      else row > 2
        columns.each do |column|
          Piece.new(:black, [row, column], self)
        end
      end
    end
  end

  def pieces
    @grid.flatten.compact
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new(false)
  r1 = Piece.new(:red, [6, 3], b)
  b1 = Piece.new(:black, [6, 1], b)
  b2 = Piece.new(:black, [4, 1], b)
  puts b.render

  r1.perform_moves([[7, 2]])
  puts b.render
  puts "red is king? #{r1.king?}"

  r1.perform_moves([[5, 0], [3, 2]])
  print b.render
end
