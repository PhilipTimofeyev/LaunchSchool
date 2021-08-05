class Pet
  attr_reader :name, :age, :color
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch


# We would be able to omit the `initialize method because the Pet class would be able to accept all of the arguments we need, and then the Cat class inherits these.
# IT would be a good idea to modify it because all pets have these three qualities. The issues that may arise are when the pet object only has two arguments, 
#we can fix this by making a default value for the arguments or requestiing them to be fullfilled. 