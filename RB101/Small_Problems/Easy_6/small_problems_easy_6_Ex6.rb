def merge(arr1, arr2)
  combined_arr = []
  arr1.each {|el| combined_arr << el unless combined_arr.include?(el)}
  arr2.each {|el| combined_arr << el unless combined_arr.include?(el)}

  combined_arr
end

merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]