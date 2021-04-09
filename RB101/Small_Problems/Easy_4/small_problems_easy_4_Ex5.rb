def multisum(num)
  multiple_arr = []
  1.upto(num) do |n|
    multiple_arr << n if (n % 3 == 0 || n % 5 == 0)
  end
  multiple_arr.sum
end