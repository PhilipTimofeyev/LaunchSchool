stoplight = ['green', 'yellow', 'red'].sample

action = case stoplight
  when 'green'
    'Go!'
  when 'yellow'
    'Slow down!'
  when 'red'
    'Stop!'
  end

puts action