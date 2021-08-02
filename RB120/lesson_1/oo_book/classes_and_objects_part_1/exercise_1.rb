class MyCar
  attr_accessor :year, :color, :model, :speed

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def car_info
    "The car is a #{self.color} #{self.year} #{self.model}."
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
    puts "You park the #{self.model}."
  end

end


lexus = MyCar.new('2021', 'red', 'lexus')
lexus.speed_up(100)
lexus.break (20)
lexus.current_speed
lexus.shut_off