class Hand
  POKERHANDS = []
  HIGH_ACE_STRAIGHT = [13, 12, 11, 10, 1]

  attr_accessor :cards

  def self.winning_hand(players)
  end

  def initialize(cards,deck)
    @deck = deck
    @cards = cards
  end

  def poker_hands
    if royal_flush?
      22
    elsif straight_flush?
      21
    elsif four_kind?
      20
    # elsif full_house?
    #   19
    # els
    elsif flush?
      18
    elsif straight?
      17
    # elsif three_kind?
    #   16
    # elsif two_pair?
    #   15
    # elsif pair?
    #   14
    else
      #highest_card
    end
  end

  def replace(idx)
    @cards[idx] = @deck.distribute_card
    nil
  end

  private

  def royal_flush?
    values = @cards.map { |card| card.value }
    straight_flush? && values.include?(10) && values.include?(1)
  end

  def straight?
    sorted = @cards.sort { |card1, card2| card2.value <=> card1.value }
    return true if (0...(sorted.length-1)).all? do |idx|
      (sorted[idx].value - sorted[idx+1].value) == 1
    end

    HIGH_ACE_STRAIGHT == sorted.map { |card| card.value }
  end

  def straight_flush?
    straight? && flush?
  end

  def flush?
    @cards.all? { |card| card.suit == @cards.first.suit }
  end

  def four_kind?
    count = 0
    @cards.each {|card| count += 1 if card.value == @cards.first.value}
    return true if count == 4
    count = 0
    @cards.each {|card| count += 1 if card.value == @cards[1].value}
    return true if count == 4

    false
  end
end
