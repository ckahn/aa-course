require_relative 'sliding_piece.rb'

class Rook < SlidingPiece
  def symbol
    self.white? ? '♜' : '♖'
  end

  protected

  def move_dirs
    [:straight]
  end
end
