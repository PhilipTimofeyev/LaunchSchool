def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

numerator = nil
denominator = nil

loop do
  puts "Please enter the numerator"
  numerator = gets.chomp
  puts "Invalid input. Only Integers are allowed." if !valid_number?(numerator)
  break if valid_number?(numerator)
end

loop do
  puts "Please enter the denominator"
  denominator = gets.chomp
  puts "Invalid input. Only Integers are allowed." if !valid_number?(denominator) || denominator.to_i == 0
  break if valid_number?(denominator) && denominator.to_i != 0
end

division = numerator.to_i/denominator.to_i


puts "#{numerator} / #{denominator} is #{division}"