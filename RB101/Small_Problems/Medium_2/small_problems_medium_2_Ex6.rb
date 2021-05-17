def triangle(s1, s2, s3)
  angle_arr = [s1, s2, s3]

  case
  when angle_arr.reduce(&:+) != 180 || angle_arr.any? {|angle| angle == 0} then :invalid
  when angle_arr.any? {|angle| angle == 90} then :right
  when angle_arr.all? {|angle| angle < 90} then :acute
  when angle_arr.any? {|angle| angle > 90} then :obtuse
  end
end

triangle(60, 70, 50) == :acute
triangle(30, 90, 60) == :right
triangle(120, 50, 10) == :obtuse
triangle(0, 90, 90) == :invalid
triangle(50, 50, 50) == :invalid