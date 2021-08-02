# Ruby Object-Oriented Programming II

### Ruby Attribute Accessors

Because all Ruby variables are private, it is only possible to access them via methods. These methods are often called setters and getters.

- `attr_reader`
  - creates getter methods.
  - `attr_reader :name, :price`
    - creates two instance methods named name and price.
- `attr_writer`
  - creates setter methods and instance variables
  - `attr_writer :name, :price`
    - creates two setter methods named name and price and two instance variables, @name and @price.
- `attr_accessor`
  - Creates both getter, setter methods, and their instance variables.

### Ruby Class Constants

Constants do not belong to a concrete object, but to a class.

```ruby
class MMath
    PI = 3.141592
end
puts MMath::PI # => how to access the constant
```

### Ruby Class Methods

Ruby methods can be divided into class methods and instance methods. 

- **Class methods** 

  - called on a class

  - cannot be called on an instance of class.

  - cannot access instance variables

  - There are three ways to define a class method

    - ```ruby
      class Wood
        def self.info
          "This is a Wood class"
        end
      end
      
      class Brick
        class << self
          def info
            "This is a Brick class"
          end
        end
      end
      
      class Rock
      end
      
      def Rock.info
         "This is a Rock class"
      end
      ```

To call an instance method we must first create an object as they are always called on an object.

### Three Ways to Create an Instance Method in Ruby

Instance methods belong to an instance of an object and are called on an object using a dot operator.

- ```ruby
  class Wood
      def info
         "This is a wood object"
      end
  end
  ```

  - The most common way to define and call an instance method. 

- ```ruby
  class Brick
      attr_accessor :info
  end
  ```

  - Another way is to use attribue accessors, which creates two methods, the getter and the setter method. It also creates an instance variable to store data.

- ```ruby
  class Rock
  
  end
  
  rock = Rock.new
  
  def rock.info
      "This is a rock object"
  end
  
  p rock.info
  ```

  - The third way is to create an empty Rock class, instantiate the object, and then a method is dynamically created and placed into the object.



### Ruby Polymorphism

**Polymorphism** is the process of using an operator or function in different ways for different data input. It means that if class B inherits from class A, it doesn't have to inherit everything about class A; it can do some of the things that class A does differently. It is the ability to redefine methods for derived classes. 

### Ruby Modules

A module is a colletion of methods, classes, and constants. Modules cannot have instances or subclasses. Modules are used to group related classes, methods, and constants that can be put into seperate modules. This prevents name clashes since modules encapsulate the object they contain. 

A mixin is a Ruby facility to create multiple inheritance, which means a class inherits functionality from more than one class.

### Ruby Exceptions

Exceptions are objects that signal deviations from the normal flow of program execution.

Exceptions are raised, thrown, or initiated.
Exceptions are objects that are descendants of a built-in Exception class. 

Exception objects carry information about the exception:

- It's type (the exception's class name)
- an optional descriptive string
- optional traceback information

```ruby
x = 35
y = 0

begin
    z = x / y
    puts z
rescue => e
    puts e
    p e
end
```

Statements that can fail are placed after the `begin` keyword.



```ruby
age = 17

begin
    if age < 18
        raise "Person is a minor"
    end

    puts "Entry allowed"
rescue => e
    puts e
    p e
    exit 1
end
```

We can raise an exception ourselves with the `raise` keyword.





