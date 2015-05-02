require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'
require_relative 'pawn.rb'
require_relative 'knight.rb'
require_relative 'move_error.rb'

require 'byebug'

class Board
  attr_accessor :grid

  def initialize(init_grid = true)
    @grid = Array.new(8) { Array.new(8) }
    initialize_grid if init_grid
  end

  def [](pos) # call with self[pos]
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def available?(pos)
    in_bounds?(pos) && self[pos] == nil
  end

  def checkmate?(color)
    if in_check?(color)
      pieces = self.grid.flatten.compact
      player_pieces = pieces.select { |piece| piece.color == color }
      return player_pieces.all? { |piece| piece.valid_moves.empty? }
    end
    false
  end

  def dup
    board_dup = Board.new(false)
    pieces = grid.flatten.compact
    pieces.each do |piece|
      board_dup[piece.pos] = piece.dup(board_dup)
    end
    board_dup
  end

  def in_bounds?(pos)
    pos.all? { |i| i >= 0 && i < 8 }
  end

  def in_check?(color)
    pieces = self.grid.flatten.compact
    player_king = pieces.select do |piece|
      piece.is_a?(King) && piece.color == color
    end.first
    opponent_pieces = pieces.select { |piece| piece.color != color }
    opponent_pieces.any? do |piece|
      piece.moves.include?(player_king.pos)
    end
  end

  def move(color, start, end_pos)
    piece = self[start]
    raise MissingPiece if piece.nil?
    raise WrongColor if piece.color != color
    raise InvalidMove unless piece.moves.include?(end_pos)
    if !in_check?(color) && self[start].move_into_check?(end_pos)
      raise MoveIntoCheck
    end
    if in_check?(color) && self[start].move_into_check?(end_pos)
      raise StillInCheck
    end
    move!(start, end_pos)
  end

  def move!(start, end_pos)
    piece = self[start]
    self[start] = nil
    self[end_pos] = piece
    piece.pos = end_pos
    piece.moved = true
  end

  def to_s
    str = "     a    b    c    d    e    f    g    h\n\n"
    for row in (0..7) do
      str << "#{8 - row}  "
      for col in (0..7) do
        pos = row, col
        piece = self[pos]
        str << (piece.nil? ? "  .  " : "  #{piece.symbol}  ")
      end
      str << "  #{8 - row}\n\n"
    end
    str << "     a    b    c    d    e    f    g    h\n"
    str
  end

  private

  def add_non_pawns
    t_row, b_row = 0, 7
    [t_row, b_row].each do |row|
      color = (row == t_row ? :black : :white)
      for col in (0..7)
        pos = row, col
        if col == 0 || col == 7
          self[pos] = Rook.new(pos, color, self)
        elsif col == 1 || col == 6
          self[pos] = Knight.new(pos, color, self)
        elsif col == 2 || col == 5
          self[pos] = Bishop.new(pos, color, self)
        elsif col == 3
          self[pos] = Queen.new(pos, color, self)
        elsif col == 4
          self[pos] = King.new(pos, color, self)
        end
      end
    end
  end

  def add_pawns
    pawn_rows = [1, 6]
    pawn_rows.each do |row|
      color = (row == 1 ? :black : :white)
      for col in (0..7)
        pos = row, col
        self[pos] = Pawn.new(pos, color, self)
      end
    end
  end

  def initialize_grid
    add_non_pawns
    add_pawns
  end
end
