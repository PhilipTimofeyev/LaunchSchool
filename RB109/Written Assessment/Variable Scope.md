##  Variable Scope

What is *Variable Scope*?

> Determines where in a program a variable is available for use. 
>
> Defined by where the variable is initialized or created.
>
> In Ruby, variable scope is defined by a block, which is a piece of code following a method invocation delimited by `{}` or `do..end`.



**Inner scope can access variables initialized in an outer scope, but not vice versa.**

```ruby
a = 5							# Local variable a is initialized and assigned to the integer 5.

3.times do |n|		# We call the times method on integer 3 and pass in the do..end block as an argument with one parameter, n.
  a = 3						# We reassign the local variable a to integer 3.
end

puts a						# We call the puts method and pass the local variable a as an argument, which prints integer 3 and returns nil.
```

> In this case, because `a`  was initialized in the outer scope, it was available to the inner scope created by the  `3.times do... end` , and thus was able to be reassigned from inside the block.



```ruby
a = 5							# Local variable a is initialized and assigned to the integer 5.

3.times do |n|		# We call the times method on integer 3 and pass in the do..end block as an argument with one parameter, n.
  a = 3						# We reassign the local variable, a, to integer 3.
  b = 5						# We initialize local variable b and assign it to integer 5.
end

puts a						# We call the puts method on local variable, a, which prints 5 and returns nil.
puts b						# We call the puts method on local variable, b, which returns an error.
```

> Because the variable `b` was initialized inside of the block of the method invocation, it is not available outside of the block and therefore cannot be seen in the outer scope.



**The key factor in telling whether code delimited by `{}`** or `do/end` is a block (which creates a new scope for variables), is seeing if the `{}` or `do/end` follows a method invocation.



```ruby
arr = [1, 2, 3]		# Local variable arr is initalized and assigned to an array containing three integer elements: 1, 2, 3

for i in arr do		# We invoke for loop on the variable, arr, and pass in the do..end block as an argument with one parameter, i.
  a = 5						# Variable a is initialized and assigned to integer 5.
end

puts a						# Puts method is called on variable, a, and prints 5 and returns nil.
```

> The variable a is accessible here because the `for`  loop did not create a new inner scope, since for is part of Ruby language and not a method invocation.



**Peer Scopes**

```ruby
2.times do
  a = 'hi'				# Variable a is initalized inside the block and references the string, 'hi'.
  puts a
end

loop do
  puts a					# This gives an error because the inner scope of this method invocation does not have access to the previous one.
  break
end

puts a						# This also gives an error because a is not accessible to the main scope.
```

> Peer scopes do not conflict and therefore peer blocks cannot reference variables initialized inside other blocks. This means we can have the same variable `a` name in both blocks initalize and reference something, but they are not the same variable.



**Nested Blocks**

```ruby
a = 1							# first level variable

loop do						# second level
  b = 2
  
  loop do					#third level
    c = 3
    puts a				# => 1
    puts b				# => 2
    puts c				# => 3
    break
  end
  
  puts a					# => 1
  puts b					# => 2
  puts c					# => NameError
  break
end

puts a						# => a
puts b						# => NameError
puts c						# => NameError
```

> Blocks can be nested and the scoping rules still apply. Variables initialized outside can be accessible from inside a block, but not vice versa.



**Variable Shadowing**

```ruby
n = 10

[1, 2, 3].each do |n|
  puts n								# puts method is invoked on the block parameter, n, and not the variable.
end
```

> Since the variable is initialized and named `n`, and then the block parameter is also named `n`, this causes variable shadowing. Ruby will disregard the variable `n` when invoking the `puts`  method. 



```ruby
n = 10

1.times do |n|
  n = 11				# Since the parameter n is named the same as the variable n, variable shadowing prevent access to the outer scope n.
end

puts n					# => 10
```

> Variable shadowing also prevents changes to be made to the outer scope `n`. 
>
> You should avoid variable shadowing by using long and descriptive variable names.



**Unlike a block which can access variables that were initialized outside of the block, a method cannot as its scope is self-contained.**

```ruby
a = 'hi'				# Local variable a is initialized and references string 'hi'.

def some_method	# The method named some_method is defined
  puts a				# The puts method is called on variable a but does not have access to the variable.
end

some_method			# The some_method method is invoked but returns NameError.
```

> An error is returned because the method definition cannot access local variables in another scope.



```ruby
def some_method(a)	# some_method method is defined with single parameter a.
  puts a						# puts method is called on the parameter a.
end

some_method(5)			# some_method method is invoked with integer 5 as the argument, which prints the string 5 and returns nil.
```

> Because integer 5 is passed into `some_method` as an argument which is assigned ot the method parameter, `a`, it is made available to the method body as a local variable which is why we can call the puts method on it.



**The scoping rules for a method invocation with a block differ from the rules for method definitions. With method definitions, local variable scope is restricted to the method definition itself. In contrast, a method invocation with a block has more open scoping rules; the block can use and modify local variables that are defined outside the block.**



**When a local variable and method share the same name, Ruby will first search for the local variable name, and then a method.**

```ruby
hello = 'hi'				# Local variable hello is initiated and assigned to string 'hi'.

def hello						# The hello method is defined.
  "Saying hello"		# Returns the string 'Saying hello'
end

puts hello					# puts method is called on the local variable and not the method, printing hi and returning nil.
```

> Ruby will call `puts` on the local variable `hello` and not the method `hello`. To remove ambiguity and make sure Ruby calls on the method, we can put a set of empty argument parentheses with the method invocation. `puts hello()` would print Saying hello and return nil.



**The rules of scope remain the same for method invocation with a block.**

```ruby
def some_method # some_method method is defined.
  a = 1					# Local variable a is initalized and references integer 1.
  5.times do		# The times method is invoked on integer 5, defining the block between do..end.
  	puts a			# puts method is invoked on local variable a, printing string '1' five times.
    b = 2				# Local variable b is initialized in the scope of the times method block, and assigned to integer 2 five times.
  end
  
  puts a				# puts method is invoked on local variable a and prints 1 and returns nil.
  puts b				# puts method is invoked on local variable b but returns NameError since b is not accessible outside the times block.
end

some_method			# => NameError
  
```

> Even within a method definition, blocks retain their scoping rules which is why local variable `b` is not accessible outside of the times block.



**Constants behave like globals and can be accessed inside and outside method definitions and blocks.**

```ruby
USERNAME = 'Batman'							# Constant variable USERNAME is initialized and assigned to the string, 'Batman'.

def authenticate								# authenticate method is defined
  puts "Logging in #{USERNAME}"	# puts method is called on a string using string interpolation to reference the constant USERNAME.
end

authenticate										# Prints 'Logging in Batman' and returns nil.
```

> Constants can be created in the `main` scope and be accessed inside methods and blocks.



```ruby
loop do											# loop method creates a block within do..end.
  MY_TEAM = "Phoenix Suns"	# The constant variable MY_TEAM is initialized and assigned to the string "Phoenix Suns".
  break											# loop is stopped.
end

puts MY_TEAM								# puts method is invoked on the constant MY_TEAM, printing "Phoenix Suns" and returning nil.
```

> The constant `MY_TEAM` is accessible outside of the block it was defined in which is why the puts method was able to be called on it.



**Method Definition vs Method Invocation**

```ruby
def greeting
  puts "Hello"
end
```

> This is an example of method definition. By using the `def` keyword we define a method in our code.



```ruby
greeting
```

> This is an example of method invocation. We call or invoke the method whether it is an existing method from Ruby Core API, core library, or a custom method we've defined ourselves.



```ruby
[1, 2, 3].each { |num| puts num }
```

> Any method can be called with a block, but the block is only executed if the method is defined in a particular way. *A block is part of the method invocation. Method invocation followed by `{}`* or `do/end` is how we define a block. Just like a local variable can be passed as an argument to a method at invocation, a block acts as an argument to the method.



**Technically, any method can be called with a block.**

```ruby
def greetings
  puts "Goodbye"
end

word = "Hello"

greetings do			# block is not executed
  puts word
end
```

> Here, the block is not executed because the method is not defined to use the block.



```ruby
def greetings
  yield
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end

# => 'Hello'
# => 'Goodbye'
```

> Here, the interaction with the block is controlled via the `yield` keyword. 



**Method definitions *cannot* directly access local variables initialized outs of the method definition, nor can local variables initialized outside of the method definition be reassigned from within it. A block *can* access local variables initialized outside of the block and can reassign those variables.**



```ruby
a = 'hello'

[1, 2, 3].map { |num| a} # => ['hello', 'hello', 'hello']
```

> The map method does not have direct access to the `a` variable. But the block that we pass to map and map calls does have access to `a`.















`