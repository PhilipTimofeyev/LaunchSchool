# Inheritance & Variable Scope

### Instance Variables

How sub-classing affects instance variables:

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! Teddy bark! bark!
```

Since the `Dog` class does not have an `initialize` instance method, the method lookup path went to the super class, `Animal`, and executed `Animal#initialize`. Which is when the `@name` instance variable was initialized, and why we can access it from `teddy.dog_name`.

If we make a small tweak:

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! bark! bark!
```

Here, `@name` is `nil` because it was never initialized. The `Animal#initialize` method was never executed.

*Uninitialized instance varaibles return `nil`.*

What if we look at mixing in modules?

```ruby
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  # => nil
```

Because we did not call the `Swim#enable_swimming` method, the `@can_swim` instance variable was never initialized. 

To make it work, we need to do this:

```ruby
teddy = Dog.new
teddy.enable_swimming
teddy.swim                                  # => swimming!
```

*We must first call the method that initializes an instance variable. Only then can the instance access the instance variable.*

### Class Variables

```ruby
class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
spike.total_animals                           # => 1
```

This shows that class variables are accessible to sub-classes. 

The class variable is loaded when the class is evaluated by Ruby.

It can be potentially dangerous when working with class variables within the context of inheritance because there is only one copy of the class variable across all sub-classes.

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels                              # => 4
```

Here we initialize a class variable, then expose a class method to return the value of the class variable.

Now if we add a sub-class to override the class variable:

```ruby
class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels                           # => 2
Vehicle.wheels                              # => 2  Yikes!
```

Here we can see the class variable in the sub-clas affected the valss variable in the super class. This will affect all other sub-classes of `Vehicle`.

```ruby
class Car < Vehicle
end

Car.wheels                                  # => 2  Not what we expected!
```

This is why we should *avoid using class variables when working with inheritance.* Some Rubyists recommend avoiding class variables altogether. The solution is to use class instance variables.

### Constants

```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    LEGS
  end
end

kitty = Cat.new
kitty.legs                                  # => NameError: uninitialized constant Cat::LEGS
```

This error occurs because Ruby looks for `LEGS` within the `Cat` class. This is expected since this is the same behavior as class or instance variables (except referencing an unitialized instance variable will return `nil`.)

Unlike class or instances variables, we can reach into the `Dog` class and reference the `LEGS` constant. We have to tell Ruby where the `LEGS` constant is using `::`, which is a namespace resolution operator.

```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS                               # added the :: namespace resolution operator
  end
end

kitty = Cat.new
kitty.legs                                  # => 4
```

We can use `::` on classes, module, or constants. 

This is how constants behave in a sub-class:

```ruby
class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  def self.wheels
    WHEELS
  end

  def wheels
    WHEELS
  end
end

Car.wheels                                  # => 4

a_car = Car.new
a_car.wheels                                # => 4
```

Here a constant initialized in a super-class is inherited by the sub-class and can be access by both class and instance methods.

But things get tricky when we mix in modules;

```ruby
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires                          # => NameError: uninitialized constant Maintenance::WHEELS
```

Unlike instance methods or instance variables, constants are not evalutated at runtime, so their lexical scope, or where they are used in the code, is very important. Here, Ruby looks for the `WHEELS` constant in the `Maintenance` module. Even though we call the `change_tires` method from `a_car` object, Ruby is not able to find the constant.

We can fix it with either:

```ruby
module Maintenance
  def change_tires
    "Changing #{Vehicle::WHEELS} tires."    # this fix works
  end
end
```

or

```ruby
module Maintenance
  def change_tires
    "Changing #{Car::WHEELS} tires."        # surprisingly, this also works
  end
end
```

The reason `Car::WHEELS` works is because we're telling RUby to look for `WHEELS` in the `Car` class, which can access `Vehicle::WHEELS` through inheritance. 

Constnat resoultion will look at lexical scope first, then look at the inheritance hierarchy. This means it can get tricky when there are nested modules, each setting the same constants to different values.

*Constant resolution rules are different from method lookup path or instance variables.*

**Summary**

- Instance variables behave as expected, but we need to make sure the instance variable is initialized before referencing it.
- Class variables allow sub-classes to override super-class clas variables. This change will affect all other sub-classes of the super-class.
- Constants have lexiccal scope which makes their scope resolution rules unique compared to other variable types. If Ruby doesn't find the constant using lexical scope, it will then look at the inheritance hierarchy. 
