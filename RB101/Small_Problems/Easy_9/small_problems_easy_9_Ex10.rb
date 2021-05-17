def buy_fruit(arr)
  arr.each_with_object([]) do |arr, result|
    arr[1].times{result << arr[0]}
  end
end

buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]