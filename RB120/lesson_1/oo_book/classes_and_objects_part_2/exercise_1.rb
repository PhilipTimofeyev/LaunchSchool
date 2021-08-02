class MyCar
  attr_accessor :color, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, mileage)
    puts "#{mileage / gallons} miles per gallon of gas."
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

MyCar.gas_mileage(4, 80)

