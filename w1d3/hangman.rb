require 'set'

# array is used by the computer to select a random word
DICTIONARY_A = File.readlines("dictionary.txt").map(&:chomp)

#set is used HumanPlayer to make sure the picked word is valid
DICTIONARY_S = DICTIONARY_A.to_s

class HumanPlayer

  attr_reader :secret_length

  def pick_secret_word
    puts "You are the checker. How long is your word?"
    @secret_length = Integer(gets.chomp)
  end

  def receive_secret_length(length)
    p @current_board = Array.new(length)
  end

  def guess
    puts "Guess a letter: "
    @last_guess = ""
    loop do
      @last_guess = gets.chomp.downcase
      break if valid_guess?(@last_guess)
    end
    @last_guess
  end

  def wins?
    if @current_board.none? { |ch| ch == nil }
      puts "You win!"
      true
    end
  end

  def check_guess(guess)
    puts "Player guessed #{guess}. What positions does that occur at?"
    positions = gets.chomp.split.map(&:to_i)
  end

  def handle_guess_response(positions_in_secret_word)
    positions_in_secret_word.each do |idx|
      @current_board[idx] = @last_guess
    end
    p @current_board
  end

  private

  def valid_secret_word?(word)
    DICTIONARY_S.include?(word) ? true : puts("Not a valid word.")
  end

  def valid_guess?(guess)
    if guess.length == 1 && ('a'..'z').include?(guess)
      true
    else
      puts "Not a valid guess."
    end
  end
end

class ComputerPlayer
  def pick_secret_word
    # p for debugging
    p @secret_word = DICTIONARY_A.sample
  end

  def receive_secret_length(length)
    p @current_board = Array.new(length)
  end

  def secret_length
    @secret_word.length
  end

  def guess
    @last_guess = ('a'..'z').to_a.sample
  end

  def wins?
    if @current_board.none? { |ch| ch == nil }
      puts "The computer wins."
      true
    end
  end

  def check_guess(guess)
    positions_in_secret_word = []
    @secret_word.length.times do |idx|
      positions_in_secret_word << idx if @secret_word[idx] == guess
    end
    positions_in_secret_word
  end

  def handle_guess_response(positions_in_secret_word)
    positions_in_secret_word.each do |idx|
      @current_board[idx] = @last_guess
    end
    p @current_board
  end
end

class Hangman
  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    @checking_player.pick_secret_word
    @guessing_player.receive_secret_length(@checking_player.secret_length)
    loop do
      guess = @guessing_player.guess
      response = @checking_player.check_guess(guess)
      @guessing_player.handle_guess_response(response)
      break if @guessing_player.wins?
    end
  end
end

puts "Is the guesser the computer? (y/n)"
guesser = (gets.chomp == 'y' ? ComputerPlayer.new : HumanPlayer.new)

puts "Is the checker the computer? (y/n)"
checker = (gets.chomp == 'y' ? ComputerPlayer.new : HumanPlayer.new)

Hangman.new(guesser, checker).play
