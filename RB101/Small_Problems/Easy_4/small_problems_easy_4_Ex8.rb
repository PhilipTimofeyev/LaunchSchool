DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_signed_integer(str)
  number = str.dup
  number.slice!(0) if str[0] == '-' or str[0] == '+'

  digits = number.chars.map {|char| DIGITS[char]}
  
  value = 0
  digits.each {|digit| value = 10 * value + digit}

  str[0] == '-' ? value * -1 : value
end

string_to_signed_integer('100')


#######
def string_to_signed_integer(string)
  unsigned_string = !!(string[0] =~ /[+-]/) ? string[1..-1] : string
  string_to_integer(unsigned_string) * (string[0] == '-' ? -1 : 1)
end

