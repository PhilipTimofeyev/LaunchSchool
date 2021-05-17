def multiply_list(arr1, arr2)
  result = [ ]
  count = 0
  
  until count >= arr1.size
    result << arr1[count] * arr2[count]
    count += 1
  end
  result
end

multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]


##### Further #####

def multiply_list(arr1, arr2)
  arr1.zip(arr2).map{|arr| arr.inject(:*)}
end