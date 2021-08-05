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

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"


