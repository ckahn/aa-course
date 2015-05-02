require_relative 'piece.rb'

class SlidingPiece < Piece
  def moves
    result = []
    result += diagonal_moves
    result += straight_moves
    result
  end

  # Many of these need refactoring
  private

  def diagonal_moves
    return [] unless move_dirs.include?(:diagonal)

    diag_moves = []
    x, y = @pos
    [1, -1].each do |x_diff|
      [1, -1].each do |y_diff|
        move = (x + x_diff), (y + y_diff)
        while @board.available?(move)
          diag_moves << move
          move = (move[0] + x_diff), (move[1] + y_diff)
        end
        if (@board.in_bounds?(move) && piece = @board[move])
          diag_moves << move if piece.color != self.color
        end
      end
    end
    diag_moves
  end

  def horizontal_moves
    horiz_moves = []
    x, y = @pos
    [1, -1].each do |x_diff|
      move = (x + x_diff), y
      while @board.available?(move)
        horiz_moves << move
        move = (move[0] + x_diff), y
      end
      if (@board.in_bounds?(move) && piece = @board[move])
        horiz_moves << move if piece.color != self.color
      end
    end
    horiz_moves
  end

  def straight_moves
    return [] unless move_dirs.include?(:straight)

    straight_moves = []
    straight_moves += horizontal_moves
    straight_moves += vertical_moves
    straight_moves
  end

  def vertical_moves
    vert_moves = []
    x, y = @pos
    [1, -1].each do |y_diff|
      move = x, (y + y_diff)
      while @board.available?(move)
        vert_moves << move
        move = x, (move[1] + y_diff)
      end
    end
    vert_moves
  end
end
