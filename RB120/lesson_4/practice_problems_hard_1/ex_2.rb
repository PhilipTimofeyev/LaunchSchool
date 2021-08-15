module Tires
  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Vehicle
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < Vehicle
  include Tires

  def initialize
    # 4 tires are various tire pressures
    @tires = [30,30,32,32]
    super(50, 25.0)
  end
end

class Motorcycle < Vehicle
  include Tires

  def initialize
    # 2 tires are various tire pressures
    @tires = [20,20]
    super(80, 8.0)
  end
end

class Catamaran < Vehicle
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

p Auto.new.tire_pressure(2)
p Motorcycle.new.tire_pressure(1)
p Catamaran.new(4, 3, 35, 86).range