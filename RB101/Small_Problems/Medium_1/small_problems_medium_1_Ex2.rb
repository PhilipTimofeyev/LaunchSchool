def rotate_array(array)
  array[1..-1] + [array[0]]
end

def rotate_rightmost_digits(num, n)
  first_half, to_rotate = num.to_s[0..-n -1].chars, num.to_s[-n..-1].chars
   (first_half + rotate_array(to_rotate)).join.to_i
end

rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917