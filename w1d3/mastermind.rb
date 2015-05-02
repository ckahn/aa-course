
# need to handle edge cases
# for example:
# if code is [R G B Y] and guess is [R G B R],
# result should be one exact match and zero near matches

class Mastermind

  PEG_COLORS = %w[ R G B Y O P ]

  def initialize
    p @code_to_guess = generate_code
    @turns_remaining = 10
  end

  def play
    loop do
      guess = user_guesses
      show_guess_result(guess)
      @turns_remaining -= 1
      break if win?(guess) || no_more_turns
    end
  end

  private

  def generate_code
    code = []
    4.times { code << PEG_COLORS.sample }
    code
  end

  def user_guesses
    puts "Guess the code (e.g., RGBY):"
    guess = gets.chomp
    until is_valid?(guess) do
      puts "Invalid input. Try again."
      guess = gets.chomp
    end
    guess.chars.to_a
  end

  def is_valid?(guess)
    guess.length == 4 &&
    guess.chars.all? { |ch| is_valid_letter(ch) }
  end

  def is_valid_letter(ch)
    PEG_COLORS.include?(ch)
  end

  def show_guess_result(guess)
    if win?(guess)
      puts "You win!"
      return
    end
    exact_match_count, near_match_count = count_matches(guess)
    puts "You have #{exact_match_count} exact matches and " +
         "#{near_match_count} near matches."
  end

  def count_matches(guess)
    exact_match_count, near_match_count = 0, 0
    guess.size.times do |idx|
      if exact_match(guess, idx)
        exact_match_count += 1
      elsif @code_to_guess.include?(guess[idx])
        near_match_count += 1
      end
    end
    [exact_match_count, near_match_count]
  end

  def exact_match(guess, idx)
    guess[idx] == @code_to_guess[idx]
  end

  def count_exact_matches(guess)
    count = 0
    guess.size.times do |idx|
      count += 1 if guess[idx] == @code_to_guess[idx]
    end
    count
  end

  def win?(guess)
    guess == @code_to_guess
  end

  def no_more_turns
    if @turns_remaining == 0
      puts "No more turns. You lose."
      return true
    end
  end
end

Mastermind.new.play
