require 'date'

def friday_13th(year)
  (Date.new(year)..Date.new(year + 1)).count {|date| date if date.day == 13 && date.friday?}
end

friday_13th(2015) == 3
friday_13th(1986) == 1
friday_13th(2019) == 2