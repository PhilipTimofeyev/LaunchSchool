DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def integer_to_string(number)
  result = ''
  loop do
    number, remainder = number.divmod(10)
    result.prepend(DIGITS[remainder])
    break if number == 0
  end
  result
end

def signed_integer_to_string(integer)
  negative = false
  integer.abs - integer == 0 ? negative = false : negative = true
  case
    when integer == 0 then integer_to_string(integer)
    when negative == true then integer_to_string(integer * -1).prepend('-')
    else integer_to_string(integer).prepend('+')
    end
end

p signed_integer_to_string(-234)

############# Further

def signed_integer_to_string(number)
  unsigned = integer_to_string(number.abs)
  case number <=> 0
  when -1 then "-#{unsigned}"
  when +1 then "+#{unsigned}"
  else         unsigned
  end
end
