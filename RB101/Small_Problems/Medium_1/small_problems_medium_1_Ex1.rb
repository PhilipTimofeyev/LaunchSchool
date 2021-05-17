def rotate_array(arr)
  arr.map.with_index {|el, index| el = arr[index - (arr.size - 1)]}
end

rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']