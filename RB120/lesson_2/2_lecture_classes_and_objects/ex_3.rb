class Person
  attr_accessor :first_name, :last_name
  def initialize(name)
    @first_name, @last_name = name.split
    @last_name = '' if @last_name.nil?
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(value)
    self.first_name, self.last_name = value.split
    self.last_name = '' if @last_name.nil?
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

