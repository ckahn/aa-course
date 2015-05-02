class GuessGame

  def initialize
    @computer_number = (1..100).to_a.sample
    @guess_count = 0
  end

  def play
    until win?
      @current_guess = get_user_number
      @guess_count += 1
      outcome(@current_guess)
    end
  end

  def win?
    @current_guess == @computer_number
  end

  def get_user_number
    puts "Guess a number:"
    Integer(gets)
  end

  def outcome(user_number)
    if user_number < @computer_number
      puts "Too low"
    elsif user_number > @computer_number
      puts "Too high"
    else
      puts "Correct!"
    end
    puts
    puts "#{@guess_count} guesses taken"
  end
end

class LineShuffle

  def initialize(filename)
    @filename = filename
    @file_lines = File.readlines(filename)
  end

  def shuffle
    @file_lines.shuffle
  end

  def save
    without_extension = @filename[0..-5]
    File.open("#{without_extension}-shuffle.txt", "w") do |f|
      f.puts shuffle
    end
  end
end

class RPN
  def calculate(arr)
    @arr = arr
    until @arr.length == 1
      first_operator_idx = find_operator(@arr)
      num1, num2 = find_operands(@arr, first_operator_idx)
      result = output(@arr[first_operator_idx], num1, num2)
      @arr = update_arr(result, first_operator_idx)
    end
    arr
  end

  def update_arr(result, operator_idx)
    @arr[operator_idx] = result
    2.times { @arr.delete_at(operator_idx-2) }
    @arr
  end


  def find_operator(arr)
    arr.index { |el| %w[ + - * / ].include?(el) }
  end

  def find_operands(arr, operator_idx)
    [arr[operator_idx-2], arr[operator_idx-1]]
  end

  def output(operator, *operands)
    if operator == '+'
      operands.reduce(:+)
    elsif operator == '-'
      operands.reduce(:-)
    elsif operator == '*'
      operands.reduce(:*)
    elsif operator == '/'
      operands.reduce(:/)
    end
  end
end
