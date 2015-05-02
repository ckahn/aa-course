def num_to_s(num, base)
  result = ""

  pow = 1
  until num / (base ** pow) == 0
    result = ((num / pow) % base).to_s + result
    pow *= base
  end

  result
end
