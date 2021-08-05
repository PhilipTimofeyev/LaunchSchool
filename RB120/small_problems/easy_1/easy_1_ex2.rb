# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # => Fluffy
# puts fluffy # => "My name is FLUFFY"
# puts fluffy.name # => FLUFFY
# puts name # =? FLUFFY

# #This mutates the 'Fluffy' string object.

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s.upcase
#   end

#   def to_s
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # => Fluffy
# puts fluffy # => "My name is FLUFFY"
# puts fluffy.name # => FLUFFY
# puts name # =? FLUFFY


class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end


name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# What's happening is the `to_s` method on line 47 in the initialize is calling the Ruby default to_s and converting the integer to a string. Which is why we can call upcase on the object.