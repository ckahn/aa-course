class Piece
  attr_reader :color
  attr_accessor :moved, :pos

  def initialize(pos, color, board, moved = false)
    @pos   = pos
    @color = color
    @board = board
    @moved = false
  end

  def dup(dup_board)
    self.class.new(pos, color, dup_board, moved)
  end

  def move_into_check?(end_pos)
    dup_board = @board.dup
    dup_board.move!(pos, end_pos)
    dup_board.in_check?(color)
  end

  def moved?
    @moved
  end

  def moves
    raise NotImplementedError.new
  end

  def symbol
    raise NotImplementedError.new
  end

  def valid_moves
    self.moves.reject { |move| move_into_check?(move) }
  end

  def white?
    @color == :white
  end
end
