def transpose(matrix)
  matrix.each_with_object ([[], [], []]) do |row, tran_arr|
    row.each_with_index {|num, idx| tran_arr[idx] << num}
  end
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]