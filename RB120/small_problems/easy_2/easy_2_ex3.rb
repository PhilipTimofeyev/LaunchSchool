class House
  include Comparable
  attr_reader :price

  def <=>(other)
    price <=> other.price
  end

  def initialize(price)
    @price = price
  end

end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

#A better way would be to compare home1.price to home2.price. There are other criteria to use so it's better to have specific instance methods for each criteria.  
#The integer/float class could make use of Comparable since it strictly deals with numbers.