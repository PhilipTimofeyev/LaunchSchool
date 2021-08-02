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
    @age = Time.new
    @@number_of_vehicles += 1
  end

  def age
    puts "Your #{@model} is #{age_of_vehicle} years old."
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

  private

  def age_of_vehicle
    Time.now.year - self.year
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

car = MyCar.new(2019, 'Red', 'Lexus')
truck = MyTruck.new(2013, 'Black', 'Toyota')

car.age


