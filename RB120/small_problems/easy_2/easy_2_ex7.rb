class Owner
  attr_accessor :pets
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    @pets.size
  end

end

class Pet
  attr_reader :name, :animal
  def initialize(animal, name)
    @animal = animal
    @name = name
  end
end

class Shelter
  attr_reader :owner_hsh
  attr_accessor :shelter_pets

  def initialize
    @owner_hsh = {}
    @shelter_pets = []
  end

  def adopt(owner, pet)
    owner.pets << pet
    if @owner_hsh.keys.include?(owner)
      @owner_hsh[owner] << pet
    else
      @owner_hsh[owner] = [pet]
    end
  end

  def not_adopt(pet)
    shelter_pets << pet
  end

  def print_adoptions
    @owner_hsh.each do |owner, pet|
      puts "\n#{owner.name} has adopted the following pets: "
      pet.each do |pet_name|
        puts "a #{pet_name.animal} named #{pet_name.name}"
      end
    end
    puts ""
  end

  def print_not_adopted
    shelter_pets.each do |pet|
      puts "a #{pet.animal} named #{pet.name}"
    end
  end
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta        = Pet.new('dog', 'Asta')
laddie      = Pet.new('dog', 'Laddie')
fluffy      = Pet.new('cat', 'Fluffy')
kat         = Pet.new('cat', 'Kat')
ben         = Pet.new('cat', 'Ben')
chatterbox  = Pet.new('parakeet', 'Chatterbox')
bluebell    = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.not_adopt(asta)
shelter.not_adopt(laddie)
shelter.not_adopt(fluffy)
shelter.not_adopt(kat)
shelter.not_adopt(ben)
shelter.not_adopt(chatterbox)
shelter.not_adopt(bluebell)

shelter.print_not_adopted
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."