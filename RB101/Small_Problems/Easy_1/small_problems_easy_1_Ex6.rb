def reverse_words(string)
  reverse_arr = []
  
    string.split.each do |word|
      if word.size >= 5
         reverse_arr.push(word.reverse)
      else
        reverse_arr.push(word)
      end
    end
reverse_arr.join(' ')
end

puts reverse_words('Professional')   
puts reverse_words('Walk around the block') 
puts reverse_words('Launch School') 