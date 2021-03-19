
def age
  puts "Hello, what is your name?"

  name = gets.chomp
  name = "Teddy" if name.empty?

  age = rand(20..200)
  puts "#{name} is #{age} years old!"
end

age