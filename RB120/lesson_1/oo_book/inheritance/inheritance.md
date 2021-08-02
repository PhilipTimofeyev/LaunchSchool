# Inheritance

**Inheritance** is when a class inherits behavior from another class. The class is inheriting behavior is called the subclass, and the class it inherits from is called the superclass.

We use inheritance as a way to extract common behaviors from classes that share that behavior, and move it to a superclass. This lets us keep loginc in one place.

### Class Inheritance

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak
```

Here, we're extracting the `speak` method to a superclass `Animal` and use inheritance to make that behavior available to `GoodDog` and `Cat` classes.

We use the `<` symbol to signify that the `GoodDog` class is inheriting from the `Animal` class. This means that all of the methods in the `Animal` class are available to the `GoodDog` class for use.

We also created a new class called `Cat` that inherits from `Animal` as well. 

Both classes are now using the superclass `Animal`'s `speak` method. 

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => Sparky says arf!
puts paws.speak             # => Hello!
```

Here, we're overriding the `speak` method in the `Animal` class with the `speak` method in the `GoodDog` class because *Ruby checks the object's class first for the method before it looks in the superclass.* So when we wrote the code `sparky.speak`, Ruby first looked at `sparky`'s class, which is `GoodDog`, and since it found the `speak` method there, it used it. Since the `paws`' class `Cat` does not have a `speak` method, it continued to look in the `Cat`'s superclass, `Animal`. 

Inheritance is a good way to remove duplication the code base.

### super

Ruby has a `super` keyowrd to call methods earlier in the method lookup path. When you call `super` from within a method, it searches the method lookup path for a method with the same name, then invokes it.

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak        # => "Hello! from GoodDog class"
```

He we've created an `Animal` class with a `speak` instance method. We then created `GoodDog` which subclasses `Animal` also with a `speak` instance method to override the inherited version. However,  in the subclass' `speak` method we use `super` to invoke the `speak` method from the superclass, `Animal`, and then extend the functionality by appending some text to the return value.

Another common way of using `super` is with the `initialize`:

```ruby
class Animal
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")
```

Here, we're using `super` with no arguments. However, the `initialize` method where `super` is being used, takes an argument and adds a new twist to how `super` is invoked. `super` automatically forwards the arguments that were passed to the method from which `super` is called (`initialize` method in `GoodDog` class). `super` will pass the `color` argument in the `initialize` defined in the subclass to that of the `Animal` superclass and invoke it. Finally, the subclass' `initialize` continues to set the `@color` instance variable.

When called with specific arguments, eg. `super(a, ,b)` , the specified arguments will be sent up the method lookup chain:

```ruby
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear") # => #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">
```

Since `super` takes an argument here, the argument is sent to the superclass. When the `BadDog` class is created, the passed in `name` argument is passed to the superclass and set to the `@name` instance variable.

If you called `super()` with parentheses, it calls the method in the superclass with no arguments at all. If you have a method in your superclass that takes no arguments, this is the safest -- and sometimes the only -- way to call it:

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")` # => #<Bear:0x007fb40b1e6718 @color="black">
```

If you forget to use parantheses here, Ruby will raise an exception because the number of arguments is incorrect.

### Mixing in Modules

Extracting common methods to a superclass is a good way to model concepts that are naturally hierarchical. We have a generic superclass called `Animal` that can keep all basic behavior of all animals. We can expand on the model a little and have a `Mammal` subclass of `Animal`. 

Our goal is to put the right behavior (methods) in the right class so we don't need to repeat code in multiple classes. We can imagine that all `Fish` objects are related to animals that live in the water, so we can create a `swim` method that should be in the `Fish` class. We can also say that all `Mammal` objects will have warm blood, so we can create a method called `warm_blooded?` in the `Mammal` class and have it return `true`. This would make the `Cat` and `Dog` objects have access to the `warm_blooded?` method which is inherited from `Mammal`, but they won't have access to the methods in the `Fish` class.

Sometimes though, there are exceptions such as some mammals have the ability to swim. Since we don't want to move the `swim` method into `Animal`, and we don't want to create another `swim` method in `Dog` because it violates the DRY principle, we can group them into a module and then mix in that module to the classes that require those behaviors:

```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end
```

Now, `Fish` and `Dog` can swim, but objects of other classes cannot.

```ruby
sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new

sparky.swim                 # => I'm swimming!
neemo.swim                  # => I'm swimming!
paws.swim                   # => NoMethodError: undefined method `swim' for #<Cat:0x007fc453152308>
```



It does not make sense to include variables in modules since variables change. Since constants stay the same, they are helpful to use within modules.

`include` mixes a module's methods in at the instance level (allowing instances of a particular class to use the methods), the `extend` keyword mixes a module's methods at the class level. This means that class itself can use the methods, as opposed to isntances of the class.

*It is a common naming convention for Ruby to use the 'able' suffix on whatever verb describes the behavior that the module is modeling. Swimming > Swimmable, Walking > Walkable.*

### Inheritance vs Modules

**Interface inheritance** is where mixin modules come into play. The class doesn't inherit from another type, but instead inherits the interface provided by the mixin module. 

When to use class inheritance vs mixins:

- You can only subclass (class inheritance) from one class. You can mix in as many modules (interface inheritance) as you'd like. 
- If there is an "is-a" relationship, class inheritance is usually the correct choice. If there is a "has-a" relationship, interface inheritance is generally a better choice. e.g. a dog is an animal, and it has an ability to swim.
- You cannot instantiate modules (no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

### Method Lookup Path

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end
```

Here we have three modules and one class, which has mixed in one module into the `Animal` class. We can check the method lookup path using the `ancestors` class method:

```ruby
puts "---Animal method lookup---"
puts Animal.ancestors

---Animal method lookup---
Animal
Walkable
Object
Kernel
BasicObject
```

This shows that when we call a method of any `Animal` object, first Ruby looks in the `Animal` class, then the `Walkable` module, then the `Object` class, then the `Kernel` module, and finally the `BasicObject` class.

If we add another class to the code:

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
```

We get this output:

```ruby
---GoodDog method lookup---
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
```

This shows us that *Ruby looks at the last module we included first*. This means if we ever have modules we mix in with the same name, the last module included will be checked first. This also shows us that the module included in the superclass was in the method lookup path. This means that all `GoodDog` objects will have access to not only `Animal` methods, but also methods defined in the `Walkable` module, as well as all other modules mixed in to any of its superclasses.

### More Modules

**Namespacing** means organizing similar classes under a module. This is how Ruby doesn't confuse `Math::PI` and `Circle::PI`. The double colon is called the **scope resolution operator**, which is a fancy way of telling ruby where to look for a speciic bit of code. In `Math::PI` , Ruby knows to look inside the `Math` module to get `PI`, not any other `PI`. 

 We will use modules to group related classes, which shows an advantage of using modules for namespacing since it becomes easier for us to recognize related classes in our code. The second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase.

```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```

We call classes in a module by appending the class name to the module name with two colons (`::`

```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')           # => "Arf!"
kitty.say_name('kitty')       # => "kitty"
```

The second use for modules is using modules as a **container** for methods, called module methods. This is using modules to house other methods which is very useful for methods that seem out of place within our code.

```ruby
module Mammal
  ...

  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```

If we define a method this way within a module, we can call them directly from the module:

```ruby
value = Mammal.some_out_of_place_method(4)
```

We can also call methods like this althought the former is preferred:

```ruby
value = Mammal::some_out_of_place_method(4)
```

### Private, Protected, and Public

Access Control is a concept that exists in a number of programming languages, including Ruby. It is genereally implemented through the use of access modifiers. Their purpose is to allow or restrict access to a particular thing. In Ruby, the thing we are concerned with restricting access to are the methods defined in a class. In Ruby, this concept is commonly referred to as **Method Access Control**.

Method Access Control is implemented in Ruby through `public`, `private`, and `protected` access modifiers. A **public method** is a method that is available to anyone who knows either the class name or the object's name. These methods are available for the rest of the program to use and comprise the class's interface, which is how other classes and objects will interact with this class and its objects.

Sometimes there are methods that have a function in the class but do not need to be available to the rest of the program. These methods can be defined as **private**. We use the `private` method call in our program and anything below it is private unless another method, like `protected`, is called after to negate it.

*Private methods are private to the object where they are defined.* This means you can only call these methods from other code inside the object. Another way to say it is that a method cannot be called with an **explicit receiver**. Receivers are objects on which methods are called. In `object.method`, the `object` is the receiver of the `method`.

In our `GoodDog` class, we have one operation that we can move into a private method.

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years

# => NoMethodError: private method `human_years' called for
  #<GoodDog:0x007f8f431441f8 @name="Sparky", @age=4>
```

Now that we've made the `human_years` method private because it's under the `private` method, it is only accessible to other methods in the class.

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end
  
  def public_disclosure
  	"#{self.name} in human years is #{human_years}"
	end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.public_disclosure
```

Here, we cannot use `self.human_years` because the `human_years` method is private. Because `self.human_years` is equivilent to `sparky.human_years`, which is not allowed for private methods, we have to use `human_years`. 

*Private methods are not accessible outside of the class definition at all, and are only accessible from inside the class when called without `self`* 

Although public and private methods are most common, there is a less common in-between approach. We can use the `protected` method to create **protected** methods. 

- From inside the class, `protected` methods are accessible just like `public` methods.
- From outside the class, `protected` methods act like `private` methods.

```ruby
class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method        # => Will this work? Yes, I'm protected!
```

This code shows us that we can call a `protected` method from within the class, even with `self` prepended. 

```ruby
fido.a_protected_method
  # => NoMethodError: protected method `a_protected_method' called for
    #<Animal:0x007fb174157110>
```

If we try to call it outside of the class, it will not work. 

*The two rules for `protected`* *methods apply within the context of inheritance as well*.

There are exceptions to the rule but we won't worry about that now.



```ruby
class Box
   # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end

   # instance method by default it is public
   def getArea
      getWidth() * getHeight
   end

   # define private accessor methods
   def getWidth
      @width
   end
   def getHeight
      @height
   end
   # make them private
   private :getWidth, :getHeight

   # instance method to print area
   def printArea
      @area = getWidth() * getHeight
      puts "Big box area is : #@area"
   end
   # make it protected
   protected :printArea
end
```

We can us protected and private methods by using a colon in front of the method `:method`

The main difference of protected methods and private methods is that protected methods allow access between class instances, while private methods do not. If a method is protected, it can't be invoked from outside the class. This allows for controlled access, but wider access between class instances. 

### Accidental Method Overriding

*Every class you create inherently subclasses from the class Object*. The `Object` class is built into Ruby and comes with many critical methods.

```ruby
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

Parent.superclass       # => Object
```

*This means that methods defined in the `Object` class are available in all classes.* 

Through inheritance, a subclass can override a superclass' method:

```ruby
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end
end

child = Child.new
child.say_hi         # => "Hi from Child."
```

This means that if we accidentally override a method that was original defined in the `Object` class, it can have far-reaching effects on our code.

For example, `send` is an instance method that all classes inherit from `Object`. If we defined a new `send` instance method in our class, all objects of our class will call our custom send method, instead of the one in class `Object`.  

Object `send` serves as a way to call a method by passing it a symbol or a string which represents the method we want to call. 

```ruby
son = Child.new
son.send :say_hi       # => "Hi from Child."
```

If we define `send` in our `Child` class and then try to invoke `Object`'s `send` method:

```ruby
class Child
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end
end

lad = Child.new
lad.send :say_hi

# => ArgumentError: wrong number of arguments (1 for 0)
from (pry):12:in `send'
```

Here, we're passing `send` one argument even though our overridden `send` method does not take any arguments. 

We can look at another example using Object's `instance_of?` method, which returns `true` if an object is an instance of a given class and `false` otherwise.

```ruby
c = Child.new
c.instance_of? Child      # => true
c.instance_of? Parent     # => false
```

If we override it:

```ruby
class Child
  # other methods omitted

  def instance_of?
    p "I am a fake instance"
  end
end

heir = Child.new
heir.instance_of? Child

# => ArgumentError: wrong number of arguments (1 for 0)
from (pry):22:in `instance_of?'
```

One `Object` instance method that is easily overridden without any major side-effect is the `to_s` method. We do this when we want a different string representation of an object.
