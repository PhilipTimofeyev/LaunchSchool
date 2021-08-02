module Towable
  def tow
    puts "I can tow!"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @@number_of_vehicles += 1
  end

  def gas_mileage(gallons, mileage)
    puts "#{mileage / gallons} miles per gallon of gas."
  end

  def self.how_many_vehicles
    puts @@number_of_vehicles
  end
end

class MyCar < Vehicle
  CAR = 'ELECTRIC'

   def to_s
    "My car is a #{self.year} #{self.color} #{@model}."
  end
end

class MyTruck < Vehicle
  include Towable

  TRUCK = 'DIESEL'

   def to_s
    "My truck is a #{self.year} #{self.color} #{@model}."
  end
end

car = MyCar.new('2021', 'Red', 'Lexus')
car.gas_mileage(13, 350)

truck = MyTruck.new('2013', 'Black', 'Toyota')
truck.gas_mileage(18, 420)

Vehicle.how_many_vehicles

truck.tow

p MyCar.ancestors
p MyTruck.ancestors
p Vehicle.ancestors