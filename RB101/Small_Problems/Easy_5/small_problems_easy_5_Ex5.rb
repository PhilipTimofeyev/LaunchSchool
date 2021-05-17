def cleanup(str)
  str.gsub!(/\W/, ' ')
  str.gsub(/ +/, " ")
end

## Further ##

LETTERS = ['a'..'z'].to_a

def cleanup(str)
  arr = []
  str.chars.each do |letter|
    if LETTERS.include?(letter)
      arr << letter
    else
      arr << ' ' unless arr.last == ' '
    end
  end

  arr.join
end