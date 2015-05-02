require_relative 'stepping_piece.rb'

class King < SteppingPiece
  def symbol
    self.white? ? '♚' : '♔'
  end

  protected

  def move_diffs
    [
      [ 1,  0],
      [-1,  0],
      [ 0,  1],
      [ 0, -1],
      [ 1,  1],
      [-1,  1],
      [ 1, -1],
      [-1, -1],
    ]
  end
end
