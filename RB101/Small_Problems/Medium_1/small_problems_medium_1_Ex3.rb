def rotate_array(array)
  array[1..-1] + [array[0]]
end

def max_rotation(num)
  result = [ ]
  length = num.to_s.length
  arr = num.to_s.chars

  until length <= 0
    arr = rotate_array(arr)
    result << arr.shift
    length -= 1
  end
  result.join.to_i
end

max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845