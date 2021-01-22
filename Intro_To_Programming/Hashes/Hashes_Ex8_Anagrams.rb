words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live','fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide', 'flow', 'neon']

anagrams1 = []
anagrams2 = []

words.each do |word| 
        words.each do |other| 
           if word != other
            x = word.chars.sort == other.chars.sort
            if x == true
              anagrams1.push(word) and anagrams2.push(other)
            end
          end
    end
end


final = anagrams1.zip(anagrams2)
print final.flatten.uniq