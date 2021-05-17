def reorder(list)
  a = 0
  b = -1

  loop do
    break if a == list.size/2

    list[a], list[b] = list[b], list[a]
    a += 1
    b -= 1
  end
  list
end

list = %w(a b e d c)
reorder(list) == ["c", "d", "e", "b", "a"] # true
list == ["c", "d", "e", "b", "a"] # true

list = ['abc']
reorder(list) == ["abc"] # true
list == ["abc"] # true

list = []
reorder(list) == [] # true
list == [] # true