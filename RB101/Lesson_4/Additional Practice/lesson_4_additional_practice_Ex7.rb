statement = "The Flintstones Rock"

freq_hash = statement.split.join.chars.each_with_object(Hash.new(0)) do |letter, hsh|
  hsh[letter] += 1
end

freq_hash