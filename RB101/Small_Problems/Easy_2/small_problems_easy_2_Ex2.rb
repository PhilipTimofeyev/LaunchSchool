SQMETERS_TO_SQFEET = 10.7639
SQFEET_TO_SQINCHES = 144
SQINCHES_TO_SQ_CM = 6.4516

def area_of_room
  puts "Enter the length of the room in feet:"
  length = gets.chomp.to_f

  puts "Enter the width of the room in feet:"
  width = gets.chomp.to_f

  area_feet = length * width
  area_inches = (area_feet * SQFEET_TO_SQINCHES).round(2)
  area_cm = (area_inches * SQINCHES_TO_SQ_CM).round(2)

  puts "The area of the room is #{area_feet} square feet, #{area_inches} square inches, and #{area_cm} square centimeters."
end

area_of_room