def crunch(str)
  crunched = str.chars.each_with_object([]) do |char, crunched|
    crunched << char if crunched.last != char
  end
  crunched.join
end

crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''