require_relative 'stepping_piece.rb'

class SteppingPiece < Piece
  def moves
    x, y = @pos
    moves = []
    move_diffs.each do |diff|
      x_diff, y_diff = diff
      move = (x + x_diff), (y + y_diff)
      if @board.available?(move)
        moves << move
      elsif @board.in_bounds?(move) && (piece = @board[move])
        moves << move if piece.color != self.color
      end
    end
    moves
  end
end
