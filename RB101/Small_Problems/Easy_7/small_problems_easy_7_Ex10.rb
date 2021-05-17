def penultimate(sentence)
  sentence.split[-2]
end

penultimate('last word') == 'last'
penultimate('Launch School is great!') == 'is'

### Further ##

def penultimate(sentence)
  middle = (sentence.split.count/2).ceil
  sentence.split[middle]
end