def halvsies(arr)
  x = arr.partition do |el| 
    if arr.size.odd?
    (arr.index(el) + 1) <= (arr.size/2 + 1)
    else
    (arr.index(el) + 1) <= (arr.size/2 )
    end
  end
end

halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
halvsies([5]) == [[5], []]
halvsies([]) == [[], []]

### Further ###
# 2.0 is used to convert to float so it rounds up.