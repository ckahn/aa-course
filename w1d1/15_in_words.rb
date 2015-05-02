class Fixnum
  NUMS = %w[ zero one two three four five six seven eight nine ten
              eleven twelve thirteen fourteen fifteen sixteen
              seventeen eighteen nineteen ]

  TENS = { '2' => 'twenty',
           '3' => 'thirty',
           '4' => 'forty',
           '5' => 'fifty',
           '6' => 'sixty',
           '7' => 'seventy',
           '8' => 'eighty',
           '9' => 'ninety' }

  def in_words
    return 'zero' if self == 0
    res = []
    num_s = self.to_s

    while true
      if num_s.length >= 3
        res.unshift(convert(num_s[-3..-1]))
        num_s = num_s[0..-4]
      elsif num_s.length > 0
        res.unshift(convert(num_s))
        break
      else
        break
      end
    end

    for i in (-5..-2)
      next if res[i] == ""

      if res[-5] && i == -5
        res[-5] += ' trillion'
      elsif res[-4] && i == -4
        res[-4] += ' billion'
      elsif res[-3] && i == -3
        res[-3] += ' million'
      elsif res[-2] && i == -2
        res[-2] += ' thousand'
      end
    end

    res.reject { |num| num == ''}.join(' ').strip
  end

  def convert(num_s)
    return "" if num_s == "000"

    res = []
    for i in (-3..-1)
      if i == -3 && num_s[-3] && num_s[-3] != '0'
        res << (NUMS[num_s[i].to_i] + ' hundred')
      elsif i == -2 && num_s[-2]
        if num_s[i] == '1'
          res << NUMS[num_s[-2..-1].to_i]
          break
        elsif num_s[i] != '0'
          res << TENS[num_s[i]]
        end
      elsif i == -1 && num_s[i] != '0'
        res << NUMS[num_s[i].to_i]
      end
    end

    res.join(' ')
  end
end
