[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# returns a boolean value since .odd? is boolean.
# any? returns true and outputs true.