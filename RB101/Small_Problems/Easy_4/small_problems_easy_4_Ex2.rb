def century(year)
  year.to_s.length
  what_century = case
            when year.to_s.length == 5
              if year.to_s[-1].to_i > 0
                (year.to_s[0,3].to_i + 1).to_s
              else
                year.to_s[0,3]
              end
            when year.to_s.length == 4
              if year.to_s[-1].to_i > 0
                (year.to_s[0,2].to_i + 1).to_s
              else
                year.to_s[0,2]
              end
            when year.to_s.length == 3
              if year.to_s[-1].to_i > 0
                (year.to_s[0].to_i + 1).to_s
              else
                year.to_s[0]
              end
            when year.to_s.length <= 2
              1.to_s
            end
  if what_century[-1].to_i == 1 and what_century[-2].to_i != 1
    p what_century + "st"
  elsif what_century[-1].to_i == 2 and what_century[-2].to_i != 1
  p what_century + "nd"
  elsif what_century.to_i == 3
  p what_century + "rd"
  else what_century[-1].to_i == 1 and what_century[-2].to_i == 1
    p what_century + "th"
  end
end

century(2000)
century(2001)
century(1965)
century(256)
century(5)
century(10103)
century(1052)
century(1127)
century(11201)