def oddities(arr)
  odd = arr.select.with_index {|n, index| n if index.even?}
  odd
end

def oddities(arr)
  odd = arr.select.with_index {|n, index| n if index.odd?}
  odd
end

def oddities(arr)
  arr_odd = []
  index = 0

  while index < arr.size
    arr_odd << arr[index]
    index += 2
  end
  arr_odd
end

def oddities(arr)
  arr_odd = []

  arr.each.with_index {|n, index| arr_odd << n if index.even?}
  arr_odd
end

oddities([2, 3, 4, 5, 6])
oddities([1, 2, 3, 4, 5, 6])
oddities(['abc', 'def'])
oddities([123])
oddities([])