hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = 'aeiouAEIOU'
vowel_arr = []

hsh.each_pair do |k, v|
  v.each do |word|
    word.chars.each do |letter|
      vowel_arr << letter if letter.count(VOWELS) > 0
    end
  end
end