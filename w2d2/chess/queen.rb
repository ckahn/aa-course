require_relative 'sliding_piece.rb'

class Queen < SlidingPiece
  def symbol
    self.white? ? '♛' : '♕'
  end

  protected

  def move_dirs
    [:diagonal, :straight]
  end
end
