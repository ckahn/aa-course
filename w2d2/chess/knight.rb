require_relative 'stepping_piece.rb'

class Knight < SteppingPiece
  def symbol
    self.white? ? '♞' : '♘'
  end

  protected

  def move_diffs
    [
      [ 2,  1],
      [ 2, -1],
      [-2,  1],
      [-2, -1],
      [ 1,  2],
      [ 1, -2],
      [-1,  2],
      [-1, -2]
    ]
  end
end
