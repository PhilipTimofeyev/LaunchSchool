def calculate_bonus(num, boo)
  if boo == true
    num / 2
  else
    0
  end
end

puts calculate_bonus(2800, true)
puts calculate_bonus(1000, false)
puts calculate_bonus(50000, true)