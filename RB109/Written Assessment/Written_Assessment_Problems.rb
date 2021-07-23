# Local Variable Scope

-----

a = "Hello"
b = a
a = "Goodbye"

puts a
puts b

------

a = 4

loop do 
  a = 5
  b = 3

  break
end

puts a
puts b

------

a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a 
puts b

------

def example(str)
  i = 3
  loop do 
    puts str
    1 -= 1
    break if i == 0
  end
end

example('hello')

------

def greetings(str)
  puts str
  puts "Goodbye"
end

word = "Hello"

greetings(word)

------

arr = [1, 2, 3, 4]

counter = 0
sum = 0

loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end

puts "Your total is #{sum}"

-----

a = 'Bob'

5.times do |x|
  a = 'Bill'
end

p a

-----

animal = "dog"

loop do |_|
  animal = "cat"
  var = "ball"
  break
end

puts animal 
puts var

-----

# Variable Shadowing

-----

a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b

-----

n = 10

1.times do |n|
  n = 11
end

puts n

-----

animal = "dog"
  
loop do |animal|
  animal = "cat"
  break
end

puts animal

-----

a = "hi there"
b = a
a = "not here"

puts a
puts b 

-----

a = "hi there"
b = a
a << ", Bob"

puts a 
puts b 

-----

a = [1, 2, 3, 3]
b = a  
c = a.uniq

p a   
p b   
p c  

# What if it was a.uniq! ?

-----

def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)

p a  

# What if it was b.map! ?

-----

a = 5.2
b = 7.3

a = b

b += 1.1

puts a
puts b

-----

def test(str)
  str += '!'
  str.downcase!
end

test_str = 'Written Assessment'
test(test_str)

puts test_str

-----

def plus(x, y)
  x = x + y
end

a = 3
b = plus(a, 2)

puts a
puts b

-----

def increment(x)
  x << 'b'
end

y = 'a'
increment(y)

puts y

-----

def change_name(name)
  name = 'bob'
end

name = 'jim'
change_name(name)

puts name

-----

def cap(str)
  str.capitalize!
end

name = "jim"
cap(name)

puts name

-----

a = [1, 3]
b = [2]
arr = [a, b]

p arr

a[1] = 5

p arr

-----

arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

p arr1
p arr2

#what if char.upcase! ?

-----

# Object Mutability / Mutating Methods

-----

def fix(value)
  value.upcase!
  value.concat('!')
  value
end

s = 'hello'
t = fix(s)

puts s
puts t

-----

def fix(value)
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)

puts s
puts t

-----

def fix(value)
  value << 'xyz'
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)

puts s
puts t

-----

def fix(value)
  value = value.upcase!
  value.concat('!')
end

s = 'hello'
t = fix(s)

puts s
puts t

-----

def fix(value)
  value[1] = 'x'
  value
end

s = 'abc'
t = fix(s)

puts s
puts t

-----

def a_method(string)
  string << ' world'
end

a = 'hello'
a_method(a)

p a

-----

num = 3

num = 2 * num

p num

-----

a = %w(a b c)
a[1] = '-'

p a

-----

def add_name(arr, name)
  arr = arr + [name]
end

names = ['bob', 'kim']
add_name(names, 'jim')

p names

-----

def add_name(arr, name)
  arr = arr << name
end

names = ['bob', 'kim']
add_name(names, 'jim')

p names

-----

# Each, Map, Select

-----

array = [1, 2, 3, 4, 5]

array.select do |num|
  puts num if num.odd?
end

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.select { |n| n.odd? }

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n|
  n + 1
end

p new_array

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n|
  n + 1
  puts n
end

p new_array

-----

words = %w(jump trip laugh run talk)

new_array = words.map do |word|
  word.start_with?("t")
end

p new_array

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.each { |n| puts n }

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

incremented = arr.map do |n|
              n + 1
            end

p incremented

-----

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.map do |n|
  n > 1
end

p new_array

-----

a = "hello"

[1, 2, 3].map { |num| a }

-----

[1, 2, 3].each do |num|
  puts num
end

-----

# Other Collection Methods

-----

[1, 2, 3].any? do |num|
  num > 2
end

-----

{ a: "ant", b: "bear", c: "cat"}.any? do |key, value|
  value.size > 4
end

-----

[1, 2, 3].all? do |num|
  num > 2
end

-----

{ a: "ant", b: "bear", c: "cat"}.all? do |key, value|
  value.length >= 3
end

-----

[1, 2, 3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}."
end

-----

{ a: "ant", b: "bear", c: "cat"}.each_with_object([]) do |pair, array|
  array << pair.last
end

-----

{ a: "ant", b: "bear", c: "cat"}.each_with_object({}) do |(key, value), hash|
  hash[value] = key
end

-----

odd, even = [1, 2, 3].partition do |num|
  num.odd?
end

p odd
p even

-----

# Truthiness

-----

a = "Hello"

if a
  puts "Hello is truthy"
else
  puts "Hello is falsey"
end

-----

def test
  puts "written assessment"
end

var = test

if var
  puts "written assessment"
else
  puts "interview"
end
