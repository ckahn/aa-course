require 'byebug'
require_relative 'board'

class Piece
  attr_reader :color, :pos, :king

  def initialize(color, pos, board, king = false)
    @color = color
    @pos = pos
    @board = board
    board[pos] = self
    @king = king
  end

  def perform_jump(end_pos)
    return false unless jumps.include?(end_pos)
    remove_jumped(end_pos)
    move_to(end_pos)
    true
  end

  def perform_moves(move_sequence)
    raise InvalidMoveError unless valid_move_sequence?(move_sequence)
    perform_moves!(move_sequence)
  end

  def perform_moves!(move_sequence)
    if move_sequence.size == 1
      move = move_sequence.first
      return perform_slide(move) if slides.include?(move)
      return perform_jump(move)  if jumps.include?(move)
    end
    move_sequence.each do |move|
      return false unless perform_jump(move)
    end
    true
  end

  def perform_slide(end_pos)
    return false unless slides.include?(end_pos)
    move_to(end_pos)
    true
  end

  def symbol
    @color == :red ? 'R' : 'b'
  end

  def valid_move_sequence?(move_sequence)
    piece_dup = @board.dup[@pos]
    piece_dup.perform_moves!(move_sequence)
  end

  # private

  def jumps
    jumps = []
    x, y = @pos
    move_diffs.each do |diff|
      mid_pos = [x + diff[0], y + diff[1]]
      next unless valid_pos?(mid_pos)
      if @board.occupied_by_opponent?(mid_pos, @color)
        end_pos = [x + diff[0] * 2, y + diff[1] * 2]
        if valid_pos?(end_pos) && !@board.occupied?(end_pos)
          jumps << end_pos
        end
      end
    end
    jumps
  end

  def king?
    @king
  end

  def move_to(end_pos)
    @board[end_pos] = self
    @board[@pos] = nil
    @pos = end_pos
    @king = true if promote?
  end

  def move_diffs
    diffs = {
      red:   [[ 1, 1], [ 1, -1]],
      black: [[-1, 1], [-1, -1]]
    }
    king? ? (diffs[:red] + diffs[:black]) : diffs[@color]
  end

  def promote?
    row = @pos.first
    return true if @color == :red   && row == 7
    return true if @color == :black && row == 0
    false
  end

  def remove_jumped(end_pos)
    x1, y1 = @pos
    x2, y2 = end_pos
    mid_pos = [(x1 + x2)/2, (y1 + y2)/2]
    @board[mid_pos] = nil
  end

  def slides
    return [] if jumps.size > 0
    slides = []
    x, y = @pos
    move_diffs.each do |diff|
      end_pos = [x + diff[0], y + diff[1]]
      next unless valid_pos?(end_pos)
      slides << end_pos unless @board.occupied?(end_pos)
    end
    slides
  end

  def valid_pos?(pos)
    pos.size == 2 && pos.all? { |i| i >= 0 && i < 8 }
  end

  def legal_moves
    jumps.size > 0 ? jumps : slides
  end
end

class InvalidMoveError < StandardError
end
