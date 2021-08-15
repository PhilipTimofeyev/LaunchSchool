class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

Cat.new('black')
Cat.new('white')
p Cat.cats_count

#@@cats_count counts the number of instances of the Cat class created.