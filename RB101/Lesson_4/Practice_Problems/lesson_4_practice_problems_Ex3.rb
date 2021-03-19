[1, 2, 3].reject do |num|
  puts num
end

# returns [1, 2, 3] Reject returns a new array where items were falsey. Since puts is falsy all elements are returned in a new array.