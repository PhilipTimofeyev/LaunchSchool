def sequence(num)
  1.upto(num).with_object([]) {|num, arr| arr << num}
end

sequence(5) == [1, 2, 3, 4, 5]
sequence(3) == [1, 2, 3]
sequence(1) == [1]