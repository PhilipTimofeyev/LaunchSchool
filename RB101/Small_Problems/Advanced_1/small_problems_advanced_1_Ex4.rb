def transpose(matrix)
  columns = matrix[0].size
  matrix.each_with_object (Array.new(columns) { [] }) do |row, tran_arr|
    row.each_with_index {|num, idx| tran_arr[idx] << num}
  end
end

transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
transpose([[1]]) == [[1]]