def repeater(str)
  str.chars.each_with_object('') {|char, double| double << char * 2 }
end

repeater('Hello') == "HHeelllloo"
repeater("Good job!") == "GGoooodd  jjoobb!!"
repeater('') == ''