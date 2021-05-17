def print_in_box(str)
  width = 2 + str.size
  top_bottom = '+' + '-' * width + '+'
  height = "|" + ' ' * width + '|'
  
  puts top_bottom
  puts height
  print "| " + str + " |"
  puts "\n" + height
  puts top_bottom

end