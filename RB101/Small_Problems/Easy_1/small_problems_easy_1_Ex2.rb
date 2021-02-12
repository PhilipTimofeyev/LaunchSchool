def is_odd?(num)
  num.abs % 2 != 0
end

def is_odd?(num)
  num.remainder(2) == 0 ? false : true
end