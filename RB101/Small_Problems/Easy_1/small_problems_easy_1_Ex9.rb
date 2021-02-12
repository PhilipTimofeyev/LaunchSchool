def sum(num)
  num.to_i.digits.reduce(:+)
end