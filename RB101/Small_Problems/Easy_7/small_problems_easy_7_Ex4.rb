LOWERCASE = ('a'..'z').to_a
UPPERCASE = ('A'..'Z').to_a

def swapcase(words)
  words.chars.map do |char|
    if UPPERCASE.include?(char)
      LOWERCASE[UPPERCASE.index(char)]
    elsif LOWERCASE.include?(char)
      UPPERCASE[LOWERCASE.index(char)]
    else char
    end
  end
.join
end

swapcase('CamelCase') == 'cAMELcASE'
swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'