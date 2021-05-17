def double_consonants(str)
  str.chars.each_with_object('') do |char, double| 
   !!char.match(/[bcdfghjklmnpqrstvwxyBCDFGHJKLMNPQRSTVWXYZ]/) ? (double << char * 2) : double << char
   end
end

double_consonants('String') == "SSttrrinngg"
double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
double_consonants("July 4th") == "JJullyy 4tthh"
double_consonants('') == ""