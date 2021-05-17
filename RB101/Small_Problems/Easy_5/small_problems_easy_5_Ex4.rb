def swap(str)
  arr = str.split(' ').map do |word| 
    word[0], word[-1] = word[-1], word[0]
    word
  end
  arr.join(' ')
end

## Further #

#No because it returns the characters and not the words.