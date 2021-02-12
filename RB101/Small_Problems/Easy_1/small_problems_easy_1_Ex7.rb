def stringy(num, start = 1)
  arr = []
  count = num
  
  if start == 1
    loop do
      arr.push('1')
      count -= 1
      break if count == 0
  
      arr.push('0')
      count -= 1
      break if count == 0
    end
    
  elsif start == 0
    loop do
      arr.push('0')
      count -= 1
      break if count == 0
  
      arr.push('1')
      count -= 1
      break if count == 0
    end
  end
  arr.join
end

puts stringy(6)
puts stringy(9)
puts stringy(4)
puts stringy(7)