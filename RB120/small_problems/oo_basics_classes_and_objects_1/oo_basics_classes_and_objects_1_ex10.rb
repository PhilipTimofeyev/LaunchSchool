
class Cat
  attr_accessor :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{self.name}!"
  end
end

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end


kitty = Cat.new("Sophie")
kitty.greet
kitty.walk