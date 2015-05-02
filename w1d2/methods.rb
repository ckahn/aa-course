class RPS
  attr_accessor :winning_pairs

  def play(player_choice)
    self.winning_pairs = [
      ["Rock", "Scissors"],
      ["Scissors", "Paper"],
      ["Paper", "Rock"]
    ]

    result = [player_choice, ["Rock", "Paper", "Scissors"].sample]

    display(result)

    draw(result)
    player_win(result)
  end

  def display(result)
    puts "Player: #{result[0]}, Computer: #{result[1]}"
  end

  def player_win(result)
    winning_pairs.include?(result) ? puts("You win") : puts("You lose")
  end

  def draw(result)
    puts "It's a draw" if result[0] == result[1]
  end
end

def remix(drinks)
  remixed = []
  alcohols, mixers = separate_ingredients(drinks)
  remixed = mixed(alcohols, mixers)
end

def separate_ingredients(drinks)
  alcohols, mixers = [], []

  drinks.each do |drink|
    alcohols << drink[0]
    mixers << drink[1]
  end

  [alcohols, mixers]
end

def mixed(alcohols, mixers)
  remixed = []
  drinks.length.times do
    alcohol = alcohols.delete(alcohols.sample)
    mixer = mixers.delete(mixers.sample)
    remixed << [alcohol, mixer]
  end
  remixed
end
