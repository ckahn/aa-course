require 'byebug'

def range(first, last)
  return [] if first > last
  return [first] if first == last

  [first] + range(first + 1, last)
end

def exp_1(base, power)
  return 1 if power == 0

  base * exp_1(base, power - 1)
end

def exp_2(base, power)
  return 1 if power == 0

  if power.even?
    n = exp_2(base, power / 2)
    n * n
  else
    n = exp_2(base, (power - 1) / 2)
    base * n * n
  end
end

class Array
  def deep_dup
    dup = []
    self.each do |el|
      dup << (el.is_a?(Array) ? el.deep_dup : el)
    end
    dup
  end

  def merge_sort
    return self if self.length <= 1

    mid_idx = self.length / 2
    left_arr  = self[0...mid_idx].merge_sort
    right_arr = self[mid_idx..-1].merge_sort

    merge(left_arr, right_arr)
  end

  private

  def merge(arr1, arr2)
    merged = []
    until arr1.empty? || arr2.empty?
      if arr1.first <= arr2.first
        merged << arr1.shift
      else
        merged << arr2.shift
      end
    end
    merged += arr1 + arr2
  end
end

def fib_r(n)
  return [0, 1].first(n) if n < 3

  fib_r(n - 1) + [fib_r(n - 1).last(2).reduce(:+)]
end

def fib_i(n)
  return [0] if n == 1

  fibs = [0, 1]
  until fibs.length == n
    fibs << fibs.last(2).reduce(:+)
  end
  fibs
end

# look at official solution
def bsearch(array, target)
  bsearch_subs(array, target, 0, array.length - 1)
end

def bsearch_subs(array, target, first_idx, last_idx)
  return if last_idx < first_idx

  mid_idx = (first_idx + last_idx) / 2
  mid_val = array[mid_idx]

  if mid_val == target
    mid_idx
  elsif mid_val < target
    bsearch_subs(array, target, mid_idx + 1, last_idx)
  else
    bsearch_subs(array, target, first_idx, mid_idx - 1)
  end
end

# look into memoization
def make_change(amount, denoms)
  return [] if amount == 0

  best = []
  denoms.each do |denom|
    next if amount > denom
    candidate = [denom] + make_change(amount - denom, denoms)
    best = candidate if best.empty? || candidate.length < best.length
  end
  best
end

# works, but it feels like a lousy solution and I don't really understand it
def subsets(arr)
  return [[]] if arr.empty?
  s = subsets(arr - [arr.last])
  s + s.map { |el| el + [arr.last] }
end
