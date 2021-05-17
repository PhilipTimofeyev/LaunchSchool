def diamond(odd_num)
  odd_arr = (1..odd_num).to_a.select(&:odd?)
  mirrored_arr = odd_arr[0..-1] + odd_arr[0..-2].reverse
  spaces = odd_arr.size - 1

  mirrored_arr.each do |n|
    puts (" " * spaces.abs) + ("*" * n)
    spaces -= 1 
  end
end

diamond(9)