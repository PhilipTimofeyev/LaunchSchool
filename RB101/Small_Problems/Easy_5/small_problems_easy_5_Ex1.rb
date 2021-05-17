def ascii_value(string)
  string.chars.reduce(0) {|sum, ascii| sum + ascii.ord}
end

### Further ###

char.org.chr == char