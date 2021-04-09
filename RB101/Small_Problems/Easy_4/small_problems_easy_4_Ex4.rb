def leap_year?(year)
  if year >= 1752
    (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 100 == 0)
  else
    year % 4 == 0
  end
end