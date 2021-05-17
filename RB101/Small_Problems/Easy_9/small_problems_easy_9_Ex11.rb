words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

def sort_letters(word)
  word.chars.sort.join
end

def anagrams(words)
  result = []
  sorted_arr = words.sort_by {|word| sort_letters(word)}
  sorted_arr.chunk {|word| sort_letters(word)}.each {|sorted, original| p original; result << original}
  result
end

anagrams(words)