def sum_or_product
  puts "Please enter an integer greater than 0:"
  number = gets.to_i

  puts "Enter 's' to computer the sum, 'p' to compute the product."
  input = gets.chomp.downcase

  arr = (1..number)
  
  if input == 's'
    puts "The sum of the integers between 1 and #{number} is #{arr.sum}."
  elsif input == 'p'
    puts "The product of the integers between 1 and #{number} is #{arr.inject(:*)}."
  end
end

sum_or_product