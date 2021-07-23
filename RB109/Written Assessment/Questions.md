coderpad.io/sandbox



Why are for, until, and while special in terms of scope?

How is the for statement meant to be described?

```ruby
arr = [1, 2, 3]		

for i in arr do		
  a = 5						
end

puts a					
```

x = [false]



"This is what is output" vs string hello is printed and returns nil



Is scope only created inside a block and method definition?



What are things you can call? Methods? Variables?



```ruby
def some_method .
  a = 1					
  5.times do		
  	puts a			
    b = 2				
  end
  
  puts a				
  puts b				
end

some_method
```



Technically a method can be called with a block, can you explain this? Can puts be called with a block?



```ruby
a = 'hello'

[1, 2, 3].map { |num| a} # => ['hello', 'hello', 'hello']
```

Why does the block have access to a but the method map does not?



**Method definitions *cannot* directly access local variables initialized outs of the method definition, nor can local variables initialized outside of the method definition be reassigned from within it. A block *can* access local variables initialized outside of the block and can reassign those variables.**

```ruby
def greetings
  yield
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end
```

Is this another way to pass an argument into a definition? Using a block instead of a parameter?

So a method can access a variable through: an argument, a block, and another method definition?



Pass by reference vs by value: basically, there is no way to change the object_id of a variable outside of a method, from inside a method.

