def substrings(str)
  result = [ ]
  first = 0
  last = 0

  until first == str.length
    until last == str.length
      result << str[first..last] unless str[first..last] == ''
      last += 1
    end
    last = 0
    first += 1
  end
  result
end

substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]