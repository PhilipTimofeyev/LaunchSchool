puts "Type a number between 0 and 100"

number = gets.chomp.to_i

if number >= 0 and number <= 50 then puts "#{number} is between 0 and 50" end
if number >= 51 and number <= 100 then puts "#{number} is between 51 and 100" end
if number > 100 then puts "#{number} is greater than 100" end