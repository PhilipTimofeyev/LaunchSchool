def sum_square_difference(num)
  num_arr = (1..num).to_a
  sum_square = num_arr.reduce(&:+) ** 2
  square_sum = (num_arr.map {|digit| digit ** 2}).reduce(&:+)

  sum_square - square_sum
end

sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
sum_square_difference(10) == 2640
sum_square_difference(1) == 0
sum_square_difference(100) == 25164150