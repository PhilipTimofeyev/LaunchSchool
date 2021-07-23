def neutralize(sentence)
  words = sentence.split(' ')
  words.reject! do |word|
    word if negative?(word)
  end

  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic a board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.

#since we are mutating the array we iterate over, the index of the next word shifts and is not included in the iteration. 

