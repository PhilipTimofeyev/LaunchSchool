number_of_lines = nil

loop do
  puts '>> How many output lines do you want? Enter a number >= 3: (Q to quit)'
  input = gets.chomp.downcase
    
  if input == "q"
  break
  else number_of_lines = input.to_i
  end
  
  if number_of_lines < 3 
      puts ">> That's not enough lines." 
      next
  end
  
  while number_of_lines > 0
    puts 'Launch School is the best!'
    number_of_lines -= 1
  end
  
end
