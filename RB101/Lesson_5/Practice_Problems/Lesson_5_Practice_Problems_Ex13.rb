arr = [[1, 6, 7], [1, 5, 9], [1, 8, 3]]

arr.sort_by do |sub_arr|
  sub_arr.select {|el| el.odd?}
end