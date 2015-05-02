require_relative 'card'

class Deck
  attr_accessor :size, :cards

  def initialize
    @cards = Array.new(52) { Card.new }
    init_cards
  end

  def distribute_card
    card = @cards.sample
    cards.delete_at(@cards.index(card))
    card
  end

  def init_cards
    @cards.each_with_index do |card,idx|
      if idx < 13
        card.suit = :diamond
        card.value = idx + 1
      elsif idx < 26
        card.suit = :club
        card.value = idx - 12
      elsif idx < 39
        card.suit = :heart
        card.value = idx - 25
      else
        card.suit = :spaid
        card.value = idx - 38
      end
    end
  end
end
