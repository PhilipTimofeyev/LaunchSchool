def tip_calc
  puts "What is the bill?"
  bill = gets.to_f

  puts "What is the tip percentage?"
  tip_percent = gets.to_f

  tip = bill * (tip_percent/100)
  total = tip.to_f + bill

  puts "The tip is $#{'%.2f' % tip}"
  puts "The total is #{'%.2f' % total}"
end

tip_calc