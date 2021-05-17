DIGITS = {
  0 => '0', 1 => '1', 2 => '2', 3 => '3', 4 => '4',
  5 => '5', 6 => '6', 7 => '7', 8 => '8', 9 => '9'
}

def integer_to_string(integer)
  integer_arr = []
  integer_length = integer.digits.size
  divisible = 10 ** (integer_length - 1)

  
  until integer_length < 1
    integer_arr << integer / divisible
    integer = integer % divisible
    divisible = divisible / 10
    integer_length -= 1
  end

  string_arr = []
  integer_arr.each {|integer| string_arr << DIGITS[integer]}

  string_arr.join

end

integer_to_string(5000)