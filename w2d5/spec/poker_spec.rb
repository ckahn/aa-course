require 'rspec'
require 'poker/game'

=begin
need to test
card
deck
game
hand
player
=end

describe Card do
end

describe Deck do
  subject(:deck) { Deck.new }
  it "should contain 52 cards at first" do
    expect(deck.cards.size).to eq(52)
    expect(deck.cards.all? { |card| card.is_a?(Card) }).to eq(true)
  end

  it "should distribute a random card" do
    card = deck.distribute_card
    expect(deck.cards.include?(card)).to be(false)
  end
end

describe Hand do
  let(:deck) { Deck.new }
  let(:cards) { [].tap {|array| 5.times { array << deck.distribute_card } } }
  subject(:hand) { Hand.new(cards, deck) }


  it "should contain 5 cards" do
    expect(hand.cards.size).to eq(5)
    expect(hand.cards.all? { |card| card.is_a?(Card) })
  end

  context "when replacing second card" do
    it "should change second card" do
      second_card = hand.cards[1]
      hand.replace(1)
      expect(hand.cards[1]).to_not eq(second_card)
    end
  end

  describe "#poker_hands" do
    let(:suits) { [:diamond, :club, :heart, :spaid ] }
    let(:values) { (1..13).to_a }
    let(:cards_flush) do
      [].tap do |array|
        5.times do
          card = Card.new
          card.suit = suits[0]
          card.value = values.sample
          array << card
        end
      end
    end
    let(:hand_flush) { Hand.new(cards_flush, deck)}
    let(:cards_straight) do
      [].tap do |array|
        5.times do |idx|
          card = Card.new
          card.suit = suits.sample
          card.value = values[idx]
          array << card
        end
      end
    end
    let(:hand_straight) { Hand.new(cards_straight, deck) }
    let(:cards_royal_flush) do
      [].tap do |array|
        5.times do |idx|
          card = Card.new
          card.suit = suits[1]
          if idx < 4
            card.value = 10 + idx
          else
            card.value = 1
          end
          array << card
        end
      end
    end
    let(:hand_royal_flush) { Hand.new(cards_royal_flush, deck) }
    let(:cards_four_kind) do
      [].tap do |array|
        5.times do |idx|
          card = Card.new
          card.suit = suits.sample
          if idx < 4
            card.value = values.first
          else
            card.value = values[1]
          end
          array << card
        end
      end
    end
    let(:hand_four_kind) { Hand.new(cards_four_kind, deck) }

    it "returns 18 when it's a flush" do
      expect(hand_flush.poker_hands).to eq(18)
    end

    it "returns 17 when it's a straight" do
      expect(hand_straight.poker_hands).to eq(17)
    end

    it "returns 22 when it's a royal flush" do
      expect(hand_royal_flush.poker_hands).to eq(22)
    end

    it "returns 20 when it's a four of a kind" do
      expect(hand_four_kind.poker_hands).to eq(20)
    end
  end
end

describe Player do
end

describe Game do
  subject(:game) { Game.new }

  before(:each) do
    let(:player1) { Player.new }
    let(:player2) { Player.new }
    let(:player3) { Player.new }
    let(:players) { [player1, player2, player3] }
    game.players = players
    game.deal
  end

  describe "#play" do
    describe "#deal" do
      it "should give each player 5 cards" do
        players.each do |player|
          expect(player.hand.size).to be(5)
        end
      end
    end

    describe "#get_bet" do
      let(:current_player) {player1}
      it "should process first player's bet" do
        expect(game.make_current_bet).to eq()
      end
    end
  end

end
