require_relative 'board.rb'

class ChessGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    current_player = :white
    until board.checkmate?(current_player)
      display_board
      begin
        start, end_pos = player_move(current_player)
        board.move(current_player, start, end_pos)
      rescue MoveError => e
        display_board
        puts e.message
        retry
      end
      current_player = next_player(current_player)
    end
    puts "Checkmate. #{current_player.upcase} loses."
  end

  def next_player(current_player)
    current_player == :white ? :black : :white
  end

  private

  # Turns "f2, f3" into [[6, 5], [5, 5]], etc.
  def convert_input(input)
    moves = input.split(',').map(&:strip)
    moves.map do |move|
      pos = []
      pos[0] = 8 - move[1].to_i
      pos[1] = move[0].ord - 'a'.ord
      pos
    end
  end

  def display_board
    system 'clear'
    puts board.to_s
  end

  def player_move(current_player)
    puts "You're in check!" if board.in_check?(current_player)
    puts "#{current_player.upcase}, enter your move (e.g. 'f2, f3'):"
    convert_input(gets)
  end
end

if __FILE__ == $PROGRAM_NAME
  ChessGame.new.play
  # move = c.convert_input("f2, f3")
  # c.board.move(:white, *move)
  #
  # move = c.convert_input("e7, e5")
  # c.board.move(:black, *move)
  #
  # move = c.convert_input("g2, g4")
  # c.board.move(:white, *move)
  #
  # move = c.convert_input("d8, h4")
  # debugger
  # c.board.move(:black, *move)
  #
  # puts c.board.to_s
end
