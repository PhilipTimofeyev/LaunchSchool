def reorder(list)
  a = 0
  b = -1
  dupl = list.dup

  loop do
    break if a == list.size/2

    dupl[a], dupl[b] = dupl[b], dupl[a]
    a += 1
    b -= 1
  end
  dupl
end

reorder([1,2,3,4]) == [4,3,2,1]          # => true
reorder(%w(a b e d c)) == %w(c d e b a)  # => true
reorder(['abc']) == ['abc']              # => true
reorder([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = reorder(list)              # => [2, 3, 1]
list.object_id != new_list.object_id  # => true
list == [1, 3, 2]                     # => true
new_list == [2, 3, 1]   