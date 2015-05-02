require_relative 'piece.rb'

class Pawn < Piece
  def moves
    result = []
    result += straight_moves
    result += diagonal_moves
    result
  end

  def symbol
    self.white? ? '♟' : '♙'
  end

  private

  def straight_moves
    straight_moves = []

    diff_x = (self.white? ? -1 : 1)
    single_step = (@pos[0] + diff_x), @pos[1]
    straight_moves << single_step if @board.available?(single_step)

    unless moved?
      double_step = (single_step[0] + diff_x), @pos[1]
      straight_moves << double_step if @board.available?(double_step)
    end

    straight_moves
  end

  def diagonal_moves
    diag_moves = []

    diffs = {
      white: [[-1, -1], [-1,  1]],
      black: [[ 1,  1], [ 1, -1]]
    }

    x, y = @pos
    diffs[@color].each do |diff|
      diag_step = (x + diff[0]), (y + diff[1])
      if @board.in_bounds?(diag_step)
        piece = @board[diag_step]
        if piece && piece.color != self.color
          diag_moves << diag_step
        end
      end
    end

    diag_moves
  end
end
