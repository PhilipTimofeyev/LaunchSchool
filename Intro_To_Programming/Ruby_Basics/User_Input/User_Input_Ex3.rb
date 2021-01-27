puts "Do you want me to print something? (y/n)"

answer = gets.chomp.downcase

puts answer == "y" ? "something" : nil