def interleave(arr1, arr2)
  arr3 = []
  until arr2.size == 0
    arr3 << arr1.shift
    arr3 << arr2.shift
  end
  arr3
end

interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']