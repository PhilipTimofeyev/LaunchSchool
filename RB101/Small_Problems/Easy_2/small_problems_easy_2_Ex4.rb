def when_retire
  puts "What is your age?"
  age = gets.to_i

  puts "At what age would you like to retire?"
  get_retire = gets.to_i

  current_year = Time.new.year
  years_left = get_retire - age
  retire_year = current_year + years_left

  puts "It's #{current_year}. You will retire in #{retire_year}."
  puts "You have only #{years_left} of work to go!"
end

when_retire