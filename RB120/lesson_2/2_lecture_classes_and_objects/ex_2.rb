class Person
  attr_reader :first_name, :last_name
  attr_writer :last_name 
  def initialize(name)
    @first_name, @last_name = name.split
    @last_name = '' if @last_name.nil?
  end

  def name
    "#{first_name} #{last_name}"
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

