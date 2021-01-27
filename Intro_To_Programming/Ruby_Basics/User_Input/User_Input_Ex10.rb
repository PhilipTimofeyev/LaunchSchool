def valid_number?(number_string)
  number_string.to_i.to_s == number_string && number_string.to_i != 0
end

integer1 = nil
integer2 = nil

loop do
    loop do
    puts "Please enter a positive or negative integer"
    integer1 = gets.chomp
        if !valid_number?(integer1)
            puts "Invalid input. Only non-zero integers are allowed." 
        else
            integer1 = integer1.to_i
        break
        end
    end
    
    loop do
    puts "Please enter a positive or negative integer"
    integer2 = gets.chomp
        if !valid_number?(integer2)
            puts "Invalid input. Only non-zero integers are allowed." 
        else
            integer2 = integer2.to_i
        break
        end
    end
    
    if (integer1 < 0 and integer2 < 0) || (integer1 > 0 and integer2 > 0)
     puts "One of the integers must be positive and one negative" 
    else
        break
    end
end

result = integer1 + integer2

puts "#{integer1} + #{integer2} = #{result}"

