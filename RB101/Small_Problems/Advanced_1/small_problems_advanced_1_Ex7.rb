def merge(arr1, arr2)
  (arr1.size < arr2.size) ? largest_arr = arr2.size : largest_arr = arr1.size
  largest_num = (arr1 + arr2).max
  
  merged_arr = [ ]
  count = 0
  num = 0

  loop do
    loop do
      merged_arr << num if arr1[count] == num
      merged_arr << num if arr2[count] == num
      count += 1
      break if count == largest_arr
    end
    count = 0
    num += 1
    break if num > largest_num
  end
  merged_arr
end

merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
merge([], [1, 4, 5]) == [1, 4, 5]
merge([1, 4, 5], []) == [1, 4, 5]
