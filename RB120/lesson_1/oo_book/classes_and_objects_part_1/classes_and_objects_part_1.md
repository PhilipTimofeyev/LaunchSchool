## Classes and Objects - Part I



### States and Behaviors

When defining a class, we usually focus on two things: *states* and *behaviors*.

- States track attributes for individual objects.
- Behaviors are what objects are capable of doing.



When using the `GoodDog` class from earlier, if we create two `GoodDog` objects: Fido and Sparky, they are both objects of the `GoodDog` class but may contain different information such as name, weight, and height. We would use instance variables to track this information. *Instance variables are scoped at the object (instance) level*, and are how objects keep track of their state.

Even though the Fido and Sparky are two different objects, they are still instances of the class `GoodDog` and contain identical behaviors. Both `GoodDog` objects should be able to bark, run, fetch and perform common behaviors of good dogs. We define these behaviors as instance methods in a class, which are available to objects (or instances) of that class.

*Instance variables keep track of state, and instance methods expose behavior for objects.*

### Initializing a New Object

```ruby
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new # => "This object was initialized"
```

The initialize method gets called every time a new object is created. Instantiating a new `GoodDog` object triggered the initialize method and resulted in the string being outputted. We refer to the `initialize` method as a **constructor**, because it gets triggered whenever we create a new object.

### Instance Variables

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end
```

The `@name` is an instance variable. It is a variable that exists as long as the object instance exists and it is one of the ways we tie data to objects. It does not "die" after the initialize method is run, but exists to be referenced until the object instance is destroyed. You can pass arguments into the initialize method through the `new` method. 

```ruby
sparky = GoodDog.new("Sparky")
```

The string "Sparky" is passed from the `new` method through to the `initialize` method and is assigned to the local variable `name`. Within the construction (the `initialize` method) we then set the instance variable `name` to `name`, which results in assigning the string "Sparky" to the `@name` instance variable.

Instance variables are responsable for keeping track of information about the state of an object. the name of the `sparky` object is the string "Sparky". This state for the object is tracked in teh instance variable `@name`. If we create another `GoodDog` object, then the `@name` instance variable for the `fido` object would contain the string "Fido". 

*Every object's state is unique, and instance variables are how we keep track.*

### Instance Methods

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
  
  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
sparky.speak
```

When running this program, nothing happens because the `speak` method returned the string "Arf!" but does not print it out. We need to add `puts` in front of it. 

```ruby
puts sparky.speak # => Arf!
```

```ruby
fido = GoodDog.new("Fido")
puts fido.speak # => Arf!
```

The second `fido` object can also perform `GoodDog` behaviors. *All objects of the same class have the same behaviors though they contain different states*. Here, the differing state is name.

To make our dog say its name "Sparky says arf!", we can use string interpolation and change our `speak` method.

```ruby
def speak
  "#{@name} says arf!"
end

puts sparky.speak           # => "Sparky says arf!"
puts fido.speak             # => "Fido says arf!"
```

### Accessor Methods

If we wanted to access the object's name, which is stored in the `@name` instance variable, we have to create a method that will return the name. 

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
  
  def get_name
    @name
  end
  
  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
```

This is a *getter* method. If we wanted to change sparky's name, we would use a *setter* method. 

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
sparky.set_name = "Spartacus"
puts sparky.get_name

# Sparky says arf!
# Sparky
# Spartacus
```

- Ruby uses a special syntax for setter methods: `set_name=`
- Instead of `sparky.set_name=("Spartacus")` we can do `sparky.set_name = "Spartacus"`.

It is good to name the getter and setter methods using the same name as the instance variable they are exposing and setting.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```



*Setter methods always return the value that is passed in as an argument, regardless of what happens inside the method. If the setter tries to return something other than the argument's value, it just ignores that attempt.*

```ruby
class Dog
  def name=(n)
    @name = n
    "Laddieboy"              # value will be ignored
  end
end

sparky = Dog.new()
puts(sparky.name = "Sparky")  # returns "Sparky"
```



Because getter and setter methods take up a lot of room, Ruby has a built in way to automatically create the getter and setter methods for us, using the **attr_accessor** method. 

```ruby
class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

The`attr_accessor` method takes a symbol as an argument, which it uses to create the method name for the `getter` and the `setter` methods. That one line replaced two method definitions. 

If we want the `getter` method without the `setter` method, we would use the `attr_reader` method. it words the same way but only allows the retrieval of the instance variable. 

If we want only a setter method, we use the `attr_writer` method. 

All of the `attr_*` methods take a `Symbol` as parameters; if there are more states to track, we can use this syntax:

```ruby
attr_accessor :name, :height, :weight
```

### Accessor Methods in Action

Before, the `speak` method referenced the `@name` instance variable like this:

```ruby
def speak
  "#{@name} says arf!"
end
```

But instead of referencing the instance variable directly, we can use the `name` getter method we created earlier, which is given to us by `attr_accessor`. 

```ruby
def speak
  "#{name} says arf!"
end
```

By removing the `@` symbol, we are calling the instance method, instead of the instance variable.

The reason to use the getter method instead of the instance variable can be shown in this example:

If we are keeping track of SS numbers in an instance variable `@ssn`, and we don't want to expose the raw data such as the entire number, if we want to retrieve it to only display the last four digits we need to use code like this on the entire class:

```ruby
# converts '123-45-6789' to 'xxx-xx-6789'
'xxx-xx-' + @ssn.split('-').last
```

If we find a bug in the code, or we need to change the format, it's much easier to just reference a getter method, and make the change in one place.

```ruby
def ssn
  # converts '123-45-6789' to 'xxx-xx-6789'
  'xxx-xx-' + @ssn.split('-').last
end
```

Now we can use the `ssn` instance method throughout our class to retrive the social security number. 

We want to do the same thing with setter methods. *Wherever we're changing the instance variable directly in our class, we should instead use the setter/getter method*. 



If we added two more states to track to the `GoodDog` class:

```ruby
attr_accessor :name, :height, :weight
```

This code gives us six getter/setter instance methods: `name`, `name=`, `height`, `height=`, `weight`, `weight=`. And it also gives us three instance variables: `@name`, `@height`, `@weight`. 

What if we wanted to change several states at once, called `change_info(n, h, w)`. 

```ruby
def change_info(n, h, w)
  @name = n
  @height = h
  @weight = w
end
```

The full code looks like this:

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end
```

We can use the `change_info` method like this:

```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```

We should replace accessing the instance variables with the setter methods.

```ruby
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
```

But doing this did not change sparky's information:

```ruby
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.
```

### Calling Methods With self

The reason the setter method didn't work is beause Ruby thought we were initializing local variables. Instead of calling the `name=`, `height=`, and `weight=` setter methods, we create three new local variables: `name`, `height`, `weight`.  

*The distinction between creating a local variable, is we need to use `self.name=` to let Ruby know that we're calling a method.* 

```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```

This tells Ruby that we're calling a setter method, not creating a local variable.

To be consistent, we could also adopt the syntax for the getter methods:

```ruby
def info
  "#{self.name} weighs #{self.weight} and is #{self.height} tall."
end
```

The finished code looks like this:

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end


sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```



Prefixing `self.` is not restricted to just the accessor methods, you can use it with any instance method. For example the `info` method is not a method given to us by `attr_accessor`, but we can still call it using `self.info`:

```ruby
class GoodDog
  # ... rest of code omitted for brevity
  def some_method
    self.info
  end
end
```

