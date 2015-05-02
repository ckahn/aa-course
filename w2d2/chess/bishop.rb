require_relative 'sliding_piece.rb'

class Bishop < SlidingPiece
  def symbol
    self.white? ? '♝' : '♗'
  end

  protected

  def move_dirs
    [:diagonal]
  end
end
