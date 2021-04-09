def string_to_integer(str)
  num_arr = []
  str.chars.each do |n|
    case n
      when n = '0'
        num_arr << 0
      when n = '1'
        num_arr << 1
      when n = '2'
        num_arr << 2
      when n = '3'
        num_arr << 3
      when n = '4'
        num_arr << 4
      when n = '5'
        num_arr << 5
      when n = '6'
        num_arr << 6
      when n = '7'
        num_arr << 7
      when n = '8'
        num_arr << 8
      when n = '9'
        num_arr << 9
      end
    end
  num_arr.inject{|n, d| n * 10 + d}
end