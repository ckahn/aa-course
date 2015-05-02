require 'set'

def factors(num)
  result = []
  j = 1
  while index <= num
    result << index if num % index == 0
    index += 1
  end
  result
end

def bubble_sort(arr)
  sorted = false
  until sorted
    sorted = true
    (arr.length - 1).times do |idx|
      if arr[idx] > arr[idx + 1]
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
        sorted = false
      end
    end
  end
  arr
end

def substrings(str)
  substrings = []

  str.length.times do |idx|
    idx.upto(str.length - 1) do |idx2|
      substrings << str[idx..idx2]
    end
  end

  subwords(substrings)
end

def subwords(substrings)
  dictionary = get_words("dictionary.txt")
  substrings.select { |str| dictionary.include?(str) }
end

def get_words(filename)
  File.readlines(filename).map(&:chomp).to_set
end
