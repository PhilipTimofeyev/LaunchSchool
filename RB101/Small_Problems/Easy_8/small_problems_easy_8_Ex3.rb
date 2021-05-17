def leading_substrings(string)
  arr = [ ]
  count = 0

  until count == string.length
    arr << string.slice(0..count)
    count += 1
  end
  arr
end

leading_substrings('abc') == ['a', 'ab', 'abc']
leading_substrings('a') == ['a']
leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']