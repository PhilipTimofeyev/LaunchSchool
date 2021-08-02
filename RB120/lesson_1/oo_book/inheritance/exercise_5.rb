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
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, mileage)
    puts "#{mileage / gallons} miles per gallon of gas."
  end

  def self.how_many_vehicles
    puts @@number_of_vehicles
  end

   def spray_paint(color)
    self.color = color
    puts "Your new #{self.color} paintjob on the #{@model} looks great!"
  end

  def current_speed
    puts "The current speed is #{self.speed} MPH."
  end

  def speed_up(n)
    self.speed += n
    puts "You accelerate to #{self.speed} MPH."
  end

  def break(n)
    self.speed -= n
    puts "You slow down to #{self.speed} MPH."
  end

  def shut_off
    self.speed = 0
    puts "You park the #@model}."
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

truck = MyTruck.new('2013', 'Black', 'Toyota')

car.current_speed
car.speed_up(20)
car.current_speed
MyCar.gas_mileage(13, 351)

truck.current_speed
truck.speed_up(40)
truck.current_speed
MyTruck.gas_mileage(18, 400)

p MyCar.ancestors


