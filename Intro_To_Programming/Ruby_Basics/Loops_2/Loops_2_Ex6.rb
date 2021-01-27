names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do puts names.shift
  break if names.count == 0
end