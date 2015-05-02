 def super_print(str, options = {})
  defaults = {
    times:   1,
    upcase:  false,
    reverse: false
  }
  options = defaults.merge(options)
  str = change_str(str, options)
  times(str, options[:times])
end

def times(str, count)
  count.times { puts str }
end

def upcase(str)
  str.upcase
end

def reverse(str)
  str.reverse
end

def change_str(str, options)
  str = upcase(str)  if options[:upcase]
  str = reverse(str) if options[:reverse]
end
