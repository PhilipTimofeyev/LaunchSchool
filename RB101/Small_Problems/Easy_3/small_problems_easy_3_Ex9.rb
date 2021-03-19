def palindrome?(str)
  new_str = ""
  
  str.chars.each do |n|
     new_str << n if !(/\W/.match(n))
  end
  new_str.downcase == new_str.downcase.reverse
end

p palindrome?('madam')
p palindrome?('Madam')
p palindrome?("Madam, I'm Adam")
p palindrome?('356653')
p palindrome?('356a653')
p palindrome?('123ab321')
