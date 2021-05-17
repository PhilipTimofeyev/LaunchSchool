def bubble_sort!(arr)
  loops = 0
  n = arr.size
  loop do
    sorted = false
    current = 0
    consequent = 1
    newn = 0

    loop do
      if arr[current] > arr[consequent]
        arr[current], arr[consequent] = arr[consequent], arr[current]
        sorted = true
      end
      newn = current
      current += 1
      consequent += 1

      break if consequent == arr.size
    end
    current = 0
    consequent = 1

    n = newn

    break if n <= 1
  end
  nil
end


###### Further #####

def bubble_sort!(array)
  n = array.size
  loop do
    newn = 0
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
      newn = index
    end
    n = newn
    break if n <= 1
  end
  nil
end



array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)