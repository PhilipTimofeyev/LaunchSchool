def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 100 == 0)
end

=begin 


def leap_year?(year)
  if year % 100 == 0
    false
  elsif year % 400 == 0
    true
  else
    year % 4 == 0
  end
end

Will not work for numbers divisible by 400.