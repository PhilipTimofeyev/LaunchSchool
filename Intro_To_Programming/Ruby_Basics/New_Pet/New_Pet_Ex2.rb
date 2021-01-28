pets = ['cat', 'dog', 'fish', 'lizard']

my_pets =[]

pets.each_with_index{|pet, idx| my_pets.push(pet) if idx > 1}

puts "I have a pet #{my_pets[0]} and a pet #{my_pets[1]}!"