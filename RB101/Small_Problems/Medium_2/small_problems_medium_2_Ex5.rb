def triangle(s1, s2, s3)
  sorted_arr = [s1, s2, s3].sort
  if sorted_arr.any? {|side| side == 0} || (sorted_arr[0] + sorted_arr[1]) <= sorted_arr[2] 
    :invalid
  elsif s1 == s2 && s2 == s3
    :equilateral 
  elsif s1 == s2 || s1 == s3 || s2 == s3
    :isosceles
  elsif s1 != s2 && s2 != s3
    :scalene
  end
end

triangle(3, 3, 3) == :equilateral
triangle(3, 3, 1.5) == :isosceles
triangle(3, 4, 5) == :scalene
triangle(0, 3, 3) == :invalid
triangle(3, 1, 1) == :invalid