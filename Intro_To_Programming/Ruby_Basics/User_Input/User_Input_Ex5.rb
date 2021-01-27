input = nil

loop do
    puts ">> How many output lines do you want? Enter a number >= 3:"
    input = gets.chomp.to_i
  break if input >= 3
    puts "That's not enough lines."
end

input.times{puts 'Launch School is the best!'}