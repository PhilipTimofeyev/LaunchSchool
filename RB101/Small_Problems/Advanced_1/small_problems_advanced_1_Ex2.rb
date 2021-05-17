def star(num)
  middle = ((num / 2) - 1)
  num_spaces = -(middle)

  0.upto(middle) do |n|
    pattern = ('*' + (' ' * num_spaces.abs)) * 3
    puts (' ' * n) +  pattern
    num_spaces += 1
  end

  puts '*' * num
  num_spaces -= 1

  middle.downto(0) do |n|
    pattern = ('*' + (' ' * num_spaces.abs)) * 3
    puts (' ' * n) +  pattern
    num_spaces += 1
  end
end

star(9)