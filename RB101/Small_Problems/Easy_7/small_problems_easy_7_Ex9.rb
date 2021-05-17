def multiply_all_pairs(arr1, arr2)
  result = [ ]
  count = arr1.size - 1
  count2 = arr2.size - 1

  until count < 0
    until count2 < 0
      result << arr1[count] * arr2[count2]
      count2 -= 1
    end

    count2 = arr2.size - 1
    count -= 1
  end
  result.sort
end

multiply_all_pairs([2, 4], [4, 3, 1, 2])