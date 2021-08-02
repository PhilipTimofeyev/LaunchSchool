# Ruby Object-Oriented Programming

- Abstraction
  - Simplifying complex reality by modeling classes appropriate to the problem,
- Polymorphism
  - Using an operator or function in different ways for different data input.
- Encapsulation
  - Hides the impementation details of a class from other objects.
- Inheritance
  - A way to form new classes using classes that have already been defined.



### Ruby Objects

An object is a combination of data and methods. In an OOP program, we create objects which communicate through methods by receiving and sending messages, and process data.

Objects created at runtime from a class are called instances of that particular class.

- `Sparky = GoodDog.new` is a new instance of the `Dog` class.

Every object inherits from the base Object, which has some elementary functionality, which is shared among all objects created.

### Ruby Constructor

Constructors are automatically called when an object is created and they do not return values.

An objects attributes are the data items that are bundled inside that object. These items are called **instance variables** or **member fields**. An instance variable is a variable defined in a class for which each object in the class has a seperate copy. 

Using `GoodDog.allocate` instead of `GoodDog.new` creates a new object without calling the initialize method.

### Ruby Methods

Data is onyl accessible via methods:

```ruby
class Person

    def initialize name
        @name = name
    end

    def get_name
        @name
    end

end

per = Person.new "Jane"

puts per.get_name
puts per.send :get_name
```

Here, there are two ways to retrieve `@name`. One is to use the dot operator followed by the method name. The other is to use the built-in send method. Which takes the symbol of the method to be called as a parameter.

Class variables belong to a class, not an object. Each object has access to it's class variables.

### Ruby Access Modifiers

All data members are private. Access modifiers can only be used on methods. Ruby methods are public unless we say otherwise.

- Public methods can be accessed from inside the definition of the class as well as from the outside of the class. 

- Private and Protected methods can not be accessed outside of the definition of the class, they can only be access within the class itself and by an inherited or parent classes.

- *Inheritance does not play a role in Ruby access modifiers*. Only two things are important:

  - If we call the method inside or outside the class definition.
  - If we use or do not use the `self` keyword which points to the current receiver.

- Private methods can only be called inside a class definition and without a `self` keyword.

  - Cannot be specified with a reciever (eg. `self`)

  - ```ruby
    class Some
        def initialize
            method1
            # self.method1 < will not work
        end
        private
         def method1
             puts "private method1 called"
         end
    end
    ```

- The difference between protected and private methods is subtle, protected methods can be called with the `self` keyword.

  - ```ruby
    class Some
        def initialize
            method1
            # self.method1 < now works
        end
        protected
         def method1
             puts "private method1 called"
         end
    end
    ```

### Ruby Inheritance

Inheritance is a way to form new classes using classes that have already been defined. The newly formed classes are called **derived classes**. The classes we derive from are called **base classes**. The important benefits of inheritance are code reuse and reduction of complexity of a program. The derived classes (**descendants**) override or extend the functionality of base classes (**ancestors**).

*Each Ruby object is automatically a descendent of Object and BasicObject classes of the Kernal module.*

In Ruby, private data members and methods are inherited. The visibility of data members and methods is not affected by inheritance in Ruby.

```ruby
class Base
  def initialize
    @name = "Base"
  end

  private
  def private_method
    puts "private method called"
  end

  protected
  def protected_method
    puts "protected_method called"
  end

  public
  def get_name
    return @name
  end
end

class Derived < Base
  def public_method
    private_method
    protected_method
  end
end

d = Derived.new
d.public_method
puts d.get_name
```

The output of this example confirms that in Ruby language, public, protected, private methods and private member fields are inherited by child objects from their parents.

### Ruby Super Method

The super method calls a method of the same name in the parent's class. If the method has no arguments, it automatically passes all of its arguments. If we write `super()`, no arguments are passed to the parent method.

```ruby
class Base
  def show x=0, y=0
    p "Base class, x: #{x}, y: #{y}"
  end
end

class Derived < Base
  def show x, y
    super
    super x
    super x, y
    super()
  end
end


d = Derived.new
d.show 3, 3

"Base class, x: 3, y: 3"
"Base class, x: 3, y: 0"
"Base class, x: 3, y: 3"
"Base class, x: 0, y: 0"
```

