def word_sizes(str)
  str.split.each_with_object({}) do |word, hash|
    if hash.keys.include?(word.size)
      hash[word.size] += 1
    else
    hash[word.size] = 1
    end
  end
end