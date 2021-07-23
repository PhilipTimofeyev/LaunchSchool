## <u>**Pass by Reference vs. Pass by Value**</u>



**In most programming languages, there are two ways of dealing with objects passed into methods. The arguments are either treated as references to the original object, or as values, which are copies of the original.**



**Pass by Value**

```ruby
def change_name(name)
  name = bob
end

name = 'jim'
change_name(name)
puts name # => jim
```

> Some Rubyists say Ruby is "pass by value" because re-assigning the object within the method doesn't affect the object outside the method.
>
> This is not an example of variable shadowing because the main scope variable is not accessible to the method.



*If ruby was purely "pass by value", that would mean there would be no way for operations within a method to cause changes to the original object.*



**Pass by Reference**

```ruby
def cap(str)
  str.capitalize!
end

name = "jim"
cap(name)
puts name #= Jim
```

> This portrays Ruby as "pass by reference", because operations within the method affected the original object.



*Since Ruby exhibits a combination of both, this is sometimes called <u>pass by value of the reference</u>* *or* *<u>call by sharing</u>*.



**When an operation within the method mutates the caller, it will affect the original object.**



## **Mutating the Caller**



**Method parameters are scoped at the method definition level, and are not avaiable outside of the method definition.**

```ruby
def some_method(number)
  number = 7
end

a = 5
some_method(a)
puts a # => 5
```

> We passed in `a` to the `some_method` method. In `some_method`, the value of `a` is assigned to the local variable `number`, which is scoped at the method definition level. `number` is reassigned the value "7". Because `number` is scoped at the method definition level, `a`'s value is unchanged.



**Method definitions cannot modify arguments passed into them permanently unless they perform some action on the argument that mutates the caller.**

```ruby
a = [1, 2, 3]

# Example of a method definition that modifies its argument permanently
def mutate(array)
  array.pop
end

p "Before mutate method: #{a}" # => [1, 2, 3]
mutate(a)
p "After mutate method: #{a}" # => [1, 2]
```

> Because the `pop` method mutates the caller, the local variable `a` is permanently modified after passing into the `mutate(a)` method.



## <u>**Variable References and Mutability of Ruby Objects**</u>

**An object is a bit of data that has some sort of state-- sometimes called a value-- and associated behavior**

```ruby
greeting = 'Hello'
```

> This tells Ruby to associate the `greeting` with the String object whose value is the literal `'Hello'`.
>
> `greeting` is said to reference (point to) the String object.
>
> We can also say the variable is being bound to the String object.
>
> `greeting` stores the object id of the String.



```ruby
>> whazzup = greeting
=> "Hello"

>> greeting
=> "Hello"

>> whazzup
=> "Hello"

>> greeting.object_id
=> 70101471431160

>> whazzup.object_id
=> 70101471431160
```

> Since the object ids of `greeting` and `whazzup` are the same, this shows that both variables not only reference a String with the same value but also reference the same String. 
>
> `greeting` and `whazzup` are aliases of each other.



```ruby
>> greeting.upcase!
=> "HELLO"

>> greeting
=> "HELLO"

>> whazzup
=> "HELLO"

>> whazzup.concat('!')
=> "HELLO!"

>> greeting
=> "HELLO!"

>> whazzup
=> "HELLO!"

>> greeting.object_id
=> 70101471431160

>> whazzup.object_id
=> 70101471431160
```

> Since both variables are associated with the same object, using either variable to mutate the object is reflected in the other variable.
>
> **The object id does not change.**



## **Reassignment**



```ruby
>> greeting = 'Dude!'
=> "Dude!"

>> puts greeting
=> "Dude!"

>> puts whazzup
=> "HELLO!"

>> greeting.object_id
=> 70101479528400

>> whazzup.object_id
=> 70101471431160
```

> `greeting` and `whazzup` no longer reference the same object. They have different values and different object ids.

**Reassignment to a variable doesn't mutate the object referenced by that variable, but binds the variable to a different object.**



## **Mutability**



**Mutable objects can be mutated, meaning their values can be altered, immutable objects cannot be mutated-- they can only be reassigned.**



#### <u>Immutable Objects</u>

**In ruby, numbers and boolean values are immutable.**

```ruby
>> number = 3
=> 3

>> number
=> 3

>> number = 2 * number
=> 6

>> number
=> 6
```

> This is not mutation, but reassignment. We create a new Integer with a value of `6` and assign it to `number`. 
>
> There are no methods that allow you to mutate the value of any immutable object.

*Immutable object are not limited to numbers and booleans. Objects of some complex classes, such as `nil`* *and Range object (`1..10`)are immutable.* *Any class can establish itself as immutable by simply not providing any methods that alter its state.*



#### <u>Mutable Objects</u>

**Most objects in Ruby are mutable; they are objects of a class that permit changes ot the object's state in some way. Mutation can be permitted by setter methods or by calling methods.**



> A setter method is a method defined by a Ruby object that allows a programmer to explicitly change the value of part of an object. Setters always use a name like `something=`.

```ruby
>> a = [1, 2, 3, 4, 5]
>> a[3] = 0       # calls setter method Array#[]=
>> a # => [1, 2, 3, 0, 5]
```



```ruby
>> a = %w(a b c)
=> ["a", "b", "c"]

>> a.object_id
=> 70227178642840

>> a[1] = '-'    # calls `Array#[]=` setter method
=> "-"

>> a
=> ["a", "-", "c"]

>> a.object_id
=> 70227178642840
```

> This demonstrates that we can mutate the array that `a` refers to, but it does not create a new array since the object id remains the same.

<img src="https://launchschool.com/blog/images/2016-07-23-references-and-mutability-in-ruby/arrays-in-memory.png" alt="img" style="zoom: 50%;" />

> `a` is a reference to an Array, which contains three elements; each element is a reference to a String object.
>
> When we assign `-` to `a[1]`, we are binding `a[1]` to a new String. We are mutating the array given by `a` by assigning a new string to the element at index 1. 



#### <u>**Object Passing**</u>

**The ability to mutate arguments depends in part on the mutability or immutability of the object represented by the argument, but also on how the argument is passed to the method.**

Some languages make copies of method arguments, and pass those copies to the method. Since they are merely copies, the original object can't be mutated. Objects passed to methods this way are said to be *passed by value.*

Other languages pass references to the method instead. A reference can be used by to mutate the original object, if that object is mutable. Objects passed to methods in this manner are said to be *passed by reference*. 

Many languages employ both strategies. One strategy is used by default; the other is used when a special syntax, keyword, or declaration is used. Some languages may employ different defaults depending on the object type. 



## <u>**Mutating and Non-Mutating Methods in Ruby**</u>



**Whether a method is mutating or non-mutating depends on the object the method is called on. For example, the method `String#sub` is mutating with respect to the String used to call it, but non-mutating with respect to it's arguments. **



#### **Assignment is Non-Mutating**

```ruby
def fix(value)
  value.upcase!
  value.concat('!')
  value
end

s = 'hello'
t = fix(s)
```

> The local variable `s` is passed to the method `fix`, this binds the string represented by `hello` to `value`. `s` and `value` are now aliases for the String, `'hello'`. 
>
> Then we call `#upcase!` which converts the String to uppercase. Because it is mutating, it does not create a new String but modifies the String referenced by `s` and `value` to now contain the value `'HELLO'`.
>
> We then call `#concat` on `value`, which also mutates `value` instead of creating a new String, making the String now have a value of `"HELLO!"`, which is referenced by both `s` and `value`.
>
> Finally, we return a reference to the String and store it in `t`.
>
> The only place we create a new String in the code is when we assign `'hello'` to s. 



```ruby
def fix(value)
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)
```

> Here, we assign the return value of `value.upcase` back to `value`. Since `upcase` does not mutate the String referenced by `value`, it cretes a new copy of the String referenced by `value`, mutates the new copy, and then returns a reference to the copy. We then bind `value` to the returned reference. 

<img src="https://launchschool.com/blog/images/2016-07-23-mutating-and-non-mutating-methods/using-assignment.png" alt="img" style="zoom:50%;" />

**Assignment always binds the target variable on the left hand side of the `=`** **to the object referenced by the right hand side. The object originally referenced by the target variable is never mutated.**



```ruby
def fix(value)
  value << 'xyz'
  value = value.upcase
  value.concat('!')
end
s = 'hello'
t = fix(s)
```

> `s` is mutated to have the value `helloxyz` , but because of of the assignment on line 3, it is not mutated. These mutations are made to a different object.



**Setter methods for class instance variables and indexed assignment are not the same as assignment. **



```ruby
>> def fix(value)
--   value = value.upcase!
--   value.concat('!')
-- end
=> :fix

>> s = 'hello'
=> "hello"

>> s.object_id
=> 70363946430440

>> t = fix(s)
=> "HELLO!"

>> s
=> "HELLO!"

>> t
=> "HELLO!"

>> s.object_id
=> 70363946430440

>> t.object_id
=> 70363946430440
```

> This time, though we assigned a reference to `value`, we end up with both `s` and `t` referring to the same object. The reason for this is that `String#upcase!` returns a reference to its caller, `value`. Since the reference returned by `value.upcase!` is the same, albeit mutated, String we started with, the assignment effectively rebinds `value` back to the object it was previously bound to; nothing is mutated by the assignment.



#### <u>Indexed Assignment is Mutating</u>

```ruby
str[3] = 'x'
array[5] = Person.new
hash[:age] = 25
```

> This looks like assignment, but it is in fact mutating. 
>
> `#[]` mutates the original object (the String, Array, or Hash). It doesn’t change the binding of each variable (`str`, `array`, `hash`).



```ruby
def fix(value)
  value[1] = 'x'
  value
end

s = 'abc'
t = fix(s)
p s            # "axc"
p t            # "axc"
p s.object_id  # 70349153406320
p t.object_id  # 70349153406320
```

> Indexed assignment is a method that a class must supply if it needs indexed assignment. 
>
> This method is named `#[]=`, and `#[]=` is expected to mutate the object to which it applies. It does not create a new object.



```ruby
>> a = [3, 5, 8]
=> [3, 5, 8]

>> a.object_id
=> 70240541515340

>> a[1].object_id
=> 11

>> a[1] = 9
=> 9

>> a[1].object_id
=> 19

>> a
=> [3, 9, 8]

>> a.object_id
=> 70240541515340
```

> We have mutated the Array `a` by assigning a new value to `a[1]`, but have not created a new Array. 
>
> `a[1] = 9` isn't assigning anything to the Array,  `a`; it is assigning `9` to `a[1]`. It reassigns `a[1]` to the new object `9`.
>
> `a` still points ot the same, although mutated, array. 



#### <u>**Concatenation is Mutating**</u>

```ruby
>> s = 'Hello'
=> "Hello"

>> s.object_id
=> 70101471465440

>> s << ' World'
=> "Hello World"

>> s
=> "Hello World"

>> s.object_id
=> 70101471465440
```

> += is non-mutating, but `<<` and `#concat` are mutating.



#### <u>**Setters are Mutating**</u>

Setters are similar to indexed assignment; they are methods that are defined to mutate the state of an object. Both employ the `something = value` syntax, so they superficially look like assignments. With indexed assignment, the elements of a collection (or the characters of a String) are replaced; with setters, the state of the object is altered, usually by mutating or reassigning an instance variable.

```ruby
person.name = 'Bill'
person.age = 23
```

> Setter invocation.

**It’s possible to define setter methods that don’t mutate the original object. Such setters should still be treated as mutating since they don’t create new copies of the original object.**



**Assignment can break the binding between an argument name and the object it references.**



## **Object Passing in Ruby**



**When you call a method with some expression as an argument, that expression isevaluated by Ruby and reduced to an object.**



#### <u>Evaluation Strategies</u>

**Ruby uses strict evaluation strategies, meaning every expression is evaluated and converted to an object before it is passed along to a method.**



```ruby
def plus(x, y)
  x = x + y
end

a = 3
b = plus(a, 2)
puts a # 3
puts b # 5
```

> Passing around immutable values in Ruby acts a lot like pass by value.



```ruby
def uppercase(value)
  value.upcase!
end

name = 'William'
uppercase(name)
puts name               # WILLIAM
```

> Ruby appears to be pass by reference when passing mutable objects.



#### <u>It's References All the Way Down</u>

**If we pass a literal to a method, Ruby will first convert that literal to an object, then internally, create a reference to the object.**



```ruby
def print_id number
  puts "In method object id = #{number.object_id}"
end

value = 33
puts "Outside method object id = #{value.object_id}"
print_id value

Outside method object id = 67
In method object id = 67
```

> `number` and `value` reference the same object despite the object being immutable. We can also see that `value` was not copied. Thus, ruby is not using pass by value. It appears to be using pass by reference.



**Pass by reference isn't limited to mutating methods. A non-mutating method can use pass by reference, so pass by reference can be used with immutable objects. A reference may be passed, but the reference isn't a guarantee that the object can be mutated.**



#### **Pass by Reference Value**



**Because in a pure pass by reference language assignment would be a mutating operation, in Ruby, it isn't. This means Ruby is not pure pass by reference.**

**A ruby variable or constant doesn't contain an actual object, but a pointer to an object. Assignment merely changes that pointer which causes the variable to be bound to a different object than the one it originally held.**

**Although we can change which object is bound to a variable inside of a method, we can't change the binding of the original arguments. We can change the objects if they are mutable, but the reference themselves are immutable as far as the method is concerned. **



**Ruby is neither pass by reference or pass by value. It is called pass by reference value or pass by value of the reference: Ruby passes around copies of the references.**

