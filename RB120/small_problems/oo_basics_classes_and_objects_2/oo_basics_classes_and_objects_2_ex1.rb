class Cat
  def self.generic_greeting
    puts  "Hello! I'm a cat!"
  end
end

Cat.generic_greeting


kitty = Cat.new

kitty.class.generic_greeting # => This returns the class Cat which is why we are then allowed to invoke the generic_greeting.