require_relative 'board'
require 'byebug'

class Game
  def initialize
    @board = Board.new
  end

  def play
    current_player = :black
    until @board.over?(current_player)
      system 'clear'
      puts @board.render
      take_turn(current_player)
      current_player = (current_player == :black ? :red : :black)
    end
  end
end

def take_turn(current_player)
  piece = piece(current_player)
  puts "Enter move sequence (eg, '3, 2; 4, 3'):"
  begin
    sequence = gets.chomp.split(';')
    sequence.map! { |el| el.split(',') }
    sequence.map! { |el| el.map(&:to_i) }
    piece.perform_moves(sequence)
  rescue InvalidMoveError => e
    puts e.message
    retry
  end
end

def piece(current_player)
  puts "#{current_player.upcase}, pick a piece to move (eg, 2, 1)."
  begin
    start_pos = gets.chomp.split(',').map(&:to_i)
    piece = @board.piece(start_pos, current_player)
  rescue # TODO -- BAD!
    puts "ERROR"
    retry
  end
  piece
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
