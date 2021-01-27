USER_NAME = "Juno"
PASSWORD = "Jove"

loop do
  puts ">> Please enter your user name:"
  user = gets.chomp
  
  puts ">> Please enter your password:"
  password_try = gets.chomp
    
  break if user == USER_NAME && password_try == PASSWORD
  puts "Authorization Failed!"
end

puts "Welcome!"