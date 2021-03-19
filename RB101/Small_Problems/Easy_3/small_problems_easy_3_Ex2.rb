def arithmetic
  puts "Enter the first number:"
  number1 = gets.to_i

  puts "Enter the second number:"
  number2 = gets.to_i

  addition = number1 + number2
  subtraction = number1 - number2
  multiplication = number1 * number2
  division = number1 / number2
  remainder = number1 % number2
  power = number1 ** number2

  puts "#{number1} + #{number2} = #{addition}"
  puts "#{number1} - #{number2} = #{subtraction}"
  puts "#{number1} * #{number2} = #{multiplication}"
  puts "#{number1} / #{number2} = #{division}"
  puts "#{number1} % #{number2} = #{remainder}"
  puts "#{number1} ** #{number2} = #{power}"
end

arithmetic