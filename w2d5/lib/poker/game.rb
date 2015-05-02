require_relative 'card'
require_relative 'player'
require_relative 'hand'
require_relative 'deck'

class Game
  attr_accessor :deck, :current_player, :players, :pot, :current_bet

  def initialize
  end

  def deal
  end

  def play
  end

  def make_current_bet
  end

  def play_turn
  end
end


if __FILE__ == $PROGRAM_NAME
  deck = Deck.new
  cards = [].tap {|array| 5.times { array << deck.distribute_card } }
  hand = Hand.new(cards, deck)

  p hand.cards.second.value

end
