# Equivalence

Not everything in Ruby is an object. There are not objects:

- methods
- blocks
- `if` statements
- argument lists
- and others

When we compare two objects, we are asking *Are the values within the two objects the same?* and not "Are the two objects the same?". 

- When we want to see if the values within two objects are the same, we can use  `==` .

- When we want to see if two objects are the same, we can use the `equal?` method.

  - ```ruby
    str1 = "something"
    str2 = "something"
    str1_copy = str1
    
    # comparing the string objects' values
    str1 == str2            # => true
    str1 == str1_copy       # => true
    str2 == str1_copy       # => true
    
    # comparing the actual objects
    str1.equal? str2        # => false
    str1.equal? str1_copy   # => true
    str2.equal? str1_copy   # => false
    ```

The `==` method compares the values of two variables wheeras the `equal?` method determines if the two variables point to the same object.

### The `==` method

The `==` is not an operator like the `=` assignment operator. It is actually an instance method available to all objects. 

- `str1.==(str2)` is the same as `str1 == str2`

The original `==` method is defined in the `BasicObject` class, which is the parest class for all classes in Ruby. This means every object in Ruby has a `==` method. However, each class needs to define the `==` method to specify the value to compare.

```ruby
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => false

bob_copy = bob
bob == bob_copy            # => true
```

This showes that the default implementation of `==` is the same as `equal?`(which is also in the `BasicObject` class). But `bob == bob_copy # => true` is not very useful because when we use `==` we don't want to ask "are the two variables pointing to the same object", but "are the values in the two variables the same?".

To tell Ruby what "the same" means for the `Person` object, we need to defined the `==` method:

```ruby
class Person
  attr_accessor :name

  def ==(other)
    name == other.name     # relying on String#== here
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => true
```

Here we override the default `BassicObject@==` behavior, and create a more meaninful way to compare two `Person` objects. We can do this with `<` and `>` as well as they are instance methods.

The `Person@==` method we wrote uses the `String#==` method for comparison. Almost every core library class will come with its own `==` method. So we can use `==` to compare `Array`, `Hash`, `Integer`, `String`, and many other objects.



```ruby
45 == 45.00                 # => true
```

This is actually `45.==(45.00)` which means that it's calling the `Integer#==` method. Whoever implemented the method took care considering the possibitiy of comparing an integer with a float, and handled the conversion from float to integer appropriately. 

This is an example of comparing two objects from different classes.

`45 == 45.00` is not that same as `45.00 == 45` because the former is calling `Integer#==` and the latter is calling `Float#==`. 

When we defined the `==` method, we also get `!=`. 

### `object_id`

Every obkect has a method called `object_id` which returns a numerical value that uniquely identifies the object. 

```ruby
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => true

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => true
```

The reason symbols and integers have the same value and are the same object is for performance optimization in Ruby, since you can't modify a symbol or integer. This is why symbols are preferred to strings as hash keys, since there's a slight performance optimization which saves memory.

### `===`

The `===` method is an instance method. But it is used implicitly by the `case` statement.

```ruby
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end
```

Behind the scenes, the `case` statement is using the `===` method to compare each `when` clause with `num`. In this case, the `when` clauses contain only ranges so `Range#===` is used for each clause. 

Here is another example of how the `case` statement uses  `===`:

```ruby
num = 25

if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end
```

Here, the `===` is invoked on a range and passes in the argument `num`. `===` does not compare two objects the same way `==` compares two objects. When `===` compares two objects such as `(1..50)` and `25`, it's essentially asking "if `(1..50)` is a group, would `25` belong in that group?". 

This demonstrates the concept:

```ruby
String === "hello" # => true
String === 15      # => false
```

On line 1, `true` is returned because `"hello"` is an instance of `String` ,even though `"hello"` doesn't equal `String`. `false` is returned on line 2 because `15` is an integer, which doesn't equal `String` and isn't an instance of the `String` class.

### `eql?`

The `eql?` method determines if two objects contain the same value and if they're the same class. This method is used most ofteb by `Hash` to determine equality among its members. It is not used very often.

### Summary

`==`

- for most objects, the `==` operator compares the values of the objects, and is frequently used.
- the `==` operator is actually a method. Most built-in Ruby classes, like `Array`, `String`, `Integer`, etc. provide their own `==` method to specify how to compare objects of those classes.
- by default, `BasicObject#==` does not perform an equality check; instead, it returns true if two objects are the same object. This is why other classes often provide their own behavior for `#==`.
- if you need to compare custom objects, you should define the `==` method.
- understanding how this method works is the most important part of this assignment.

`equal?`

- the `equal?` method goes one level deeper than `==` and determines whether two variables not only have the same value, but also whether they point to the same object.
- do not define `equal?`.
- the `equal?` method is not used very often.
- calling `object_id` on an object will return the object's unique numerical value. Comparing two objects' `object_id` has the same effect as comparing them with `equal?`.

`===`

- used implicitly in `case` statements.
- like `==`, the `===` operator is actually a method.
- you rarely need to call this method explicitly, and only need to implement it in your custom classes if you anticipate your objects will be used in `case` statements, which is probably pretty rare.

`eql?`

- used implicitly by `Hash`.
- very rarely used explicitly.
