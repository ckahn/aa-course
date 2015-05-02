require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark
  attr_accessor :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return true  if @board.winner == @next_mover_mark
      return false if @board.winner.nil? || @board.winner
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    next_mover_mark = (@next_mover_mark == :x ? :o : :x)
    empty_positions.each do |pos|
      child = TicTacToeNode.new(board.dup, next_mover_mark)
      child.board[pos] = @next_mover_mark
      child.prev_move_pos = pos
      children << child
    end
    children
  end

  def empty_positions
    empty_positions = []
    for row in (0..2)
      for col in (0..2)
        pos = [row, col]
        empty_positions << pos if @board.empty?(pos)
      end
    end
    empty_positions
  end
end
