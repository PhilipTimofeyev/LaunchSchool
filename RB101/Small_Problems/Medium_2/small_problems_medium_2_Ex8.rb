def featured(num)
  multiple = 1
  result = 0

  until result.odd? && result.to_s.chars.uniq.join == result.to_s
    result = 7 * ((num / 7) + multiple)
    multiple += 1
  end
  result
end

featured(12) == 21
featured(20) == 21
featured(21) == 35
featured(997) == 1029
featured(1029) == 1043