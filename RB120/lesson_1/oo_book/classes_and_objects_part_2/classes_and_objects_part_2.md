# Classes and Objects - Part II

### Class Methods

Class methods are methods we can call directly on the class itself, without having to instantiate any objects. 

When defining a class method, we prepend the method name with `self`:

```ruby
class GoodDog
  def self.what_am_i
    "I'm a GoodDog class!"
  end
end

GoodDog.what_am_i # => I'm a GoodDog class!
```

*Class methods are where we put functionality that does not pertain to individual objects.*

- Objects contain a state, and if we have a method that does not need to deal with states, then we can just use a class method. 

### Class Variables

As instance variables capture information related to specific instances of classess (ie. objects), we an create variables for an entire class that are named **class variables.** Class variables are created using two `@` symbols. 

```ruby
class GoodDog
  @@number_of_dogs = 0
  
  def initialize
    @@number_of_dogs += 1
  end
  
  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs
```

Here, we have a class variable `@@number_of_dogs` which we initialize to 0. Then we increment our constructor (the `initialize` method) by 1, which also shows that class variables can be accessed within an instance method. Finally, we return the value of the class variable in the class method `self.total_number_of_dogs`. 

- This is an example of using a class variable and class method to keep track of a class level detail that only pertains to the class, not the individual objects.

### Constants

When creating classes there may be certain variables you never want to change. You can do this using **constants**. 

- You define a constant by using an upper case letter at the beginning of the variable name.
- Although technically constants just need to begin with a capital letter, most Rubyists will make the entire variable uppercase.

```ruby
class GoodDog
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age
```

Here we used the constant `DOG_YEARS` to calculate the age in dog years when we created the object, `sparky`. This constant is meant to never change, and although it is possible to reassign a new value, Ruby will throw a warning.

### The to_s Method

The `to_s` method comes built in to every class in Ruby. If we have the `GoodDog` class from above, and the `sparky` object:

```ruby
puts sparky      # => #<GoodDog:0x007fe542323320>
```

The `puts` method automatically calls `to_s` on it's argument, which in this case is the `sparky` object. `puts sparky` is equivelent to `puts sparky.to_s`. The reason we get this output is because by default, the `to_s` method returns the name of the object's class and an encoding of the object id. 

`puts` method calls `to_s` *for any argument that is not an array. For an array, it writes on seperate lines the result of calling* `to_s` *on each element of the array.*

We can test this by adding a custom `to_s` method to our `GoodDog` class, overriding the default `to_s` that comes with Ruby.

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts sparky      # => This dog's name is Sparky and is 28 in dog years.
```

Another method similar to `puts`, but it does not call `to_s` on it's argument, is `p`. It calls another built-in Ruby instance method, called `inspect`. 

```ruby
p sparky         # => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>
```

`p sparky` is equivilent to `sparky.inspect`

`to_s` is automatically called in string interpolation. 

```ruby
irb :001 > arr = [1, 2, 3]
=> [1, 2, 3]
irb :002 > x = 5
=> 5
irb :003 > "The #{arr} array doesn't include #{x}."
=> The [1, 2, 3] array doesn't include 5.
```

Here, the `to_s` method is automatically called on the `arr` object, as well as the `x` integer object.

We can also use our `sparky` object in string interpolation.

```ruby
irb :001 > "#{sparky}"
=> "This dog's name is Sparky and it is 28 in dog years."
```

**`to_s` is called automatically on the object when we use it with puts or string interpolation.**

*The `to_s` method is defined in the `Object` class of Ruby and therefore all Ruby objects have the `to_s` method.*

### More About Self

Current two uses of `self`.

- Use `self` when calling setter methods from within the class. We have to use `self` to allow Ruby to disambiguate between initializing a local variable and calling a setter method.
- Use `self` for class method definitions.

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
  
   def what_is_self
    self
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```

*When an instance method uses `self` from within the class, it references the calling object.* Therefore, from within the `change_info` method, calling `self.name=` acts the same as calling `sparky.name=` from outside the class (you cannot call `sparky.name=`) inside the class since it isn't in scope.

Another place we use `self` is when defining class methods:

```ruby
class MyAwesomeClass
  def self.this_is_a_class_method
  end
end
```

When self is prepended to a method definition, it is defining a **class method**. 

```ruby
class GoodDog
  # ... rest of code omitted for brevity
  puts self
end
```

*When using `self`* *inside a class* *but outside an instance method, it refers to the class itself.* A method definition prefixed with `self` is the same as defining the method on the class. `def self.a_method` is equivelent to `def GoodDog.a_method`, which is why it's a class method, because it's being defined on the class.

- `self`, inside an instance method, references the instance (object) that called the method - the calling object.
  - `self.weight=` is the same as `sparky.weight=`.
- `self` outside of an instance method, references the class and can be used to define class methods.
  - `def self.name=(n)` is the same as `def GoodDog.name=(n)`.

`self` is a way of being explicit about what our program is referencing and what our intentions are as far as behavior. It changes depending on the scope it is used in, so it's important to be aware if you're inside an instance method or not. 

