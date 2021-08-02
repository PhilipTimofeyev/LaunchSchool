class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

#We get an error because we are using a a getter instead of a setter attr_reader instead of attr_writer.

