def running_total(arr)
  final_arr = []
  sum_arr = []

  arr.each do |n|
    sum_arr << n
    final_arr << sum_arr.sum
  end
  final_arr
end

##########

def running_total(array)
  sum = 0
  array.each_with_object([]) { |value, array| array << sum += value }
end

#######
