def lab(word)
  if word =~ /lab/
    puts word
  else
    "lab does not exist in word"
  end
end

lab("laboratory")
lab("experiment")
lab("Pans Labryinth")
lab("elaborate")
lab("polar bear")