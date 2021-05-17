def fibonacci(n)
  first = 1
  second = 1
  count = 2

  return first if n <= 2

  loop do 
    first = first + second
    count += 1
    return first if count == n
    second = first + second
    count += 1
    return second if count == n
  end
end

p fibonacci(9)