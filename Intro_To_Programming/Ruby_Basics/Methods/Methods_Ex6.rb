def time_of_day(daylight)
  puts "It's daytime!" if daylight == true
  puts "It's nighttime!" if daylight == false
end

daylight = [true, false].sample

time_of_day(daylight)