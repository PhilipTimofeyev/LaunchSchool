(1..99).each {|n| puts n if n.even?}

1.upto(99).each {|n| puts n if n.even?}

numbers = []
(1..99).each {|n| numbers << n}
puts numbers.select {|n| n.even?}