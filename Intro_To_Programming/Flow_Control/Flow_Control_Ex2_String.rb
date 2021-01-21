def all_caps(string)
  if string.length > 10
    puts string.upcase
  else
    puts "String is less than 10 characters."
  end

end

all_caps("Hello World")