input = nil

until input == "Dog"
  puts ">> Please enter your password:"
  input = gets.chomp
    break if input == "Dog"
  puts "Invalid password!"
end

puts "Welcome!"
