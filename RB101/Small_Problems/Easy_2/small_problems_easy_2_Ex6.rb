(1..99).each {|n| puts n if n.odd?}

1.upto(99).each {|n| puts n if n.odd?}

numbers = []
(1..99).each {|n| numbers << n}
puts numbers.select {|n| n.odd?}