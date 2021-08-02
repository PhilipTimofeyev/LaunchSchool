# **The Object Model**





### **Why object Oriented Programming?**



Object oriented programing was created to deal with the growing complexity of large software systems.

- As applications grew in size, they became difficult to maintain.
- One small change in the program could trigger a ripple effect of errors due to dependencies throughout the entire program.
- Programmers needed a way to create containers for data that could be changed and manipulated without affecting the entire system, as well as a way to section of areas of code that performed certain procedures to that their programs could become the interaction of many small parts instead of one massive blob of dependency. 



**Encapsulation**

- Hiding pieces of functionality and making it unavailable to the rest of the code base. 
- A form of data protection so that data cannot be manipulated or changed without obvious intention. 
- Defines boundaries in the application and allows new levels of complexity.
- Allows the programmer to think on a new level of abstraction.



**Polymorphism**

- The ability for different types of data to respond to a common interface. 
  - If we have a method that expects argument objects that have a `move` method, we can pass it any type of argument provided it has a compatible `move` method. It allows objects of different types to respond to the same method invocation.



**Inheritance**

- When a class inherits the behaviors of another class, it is referred to as a **superclass**. 
- This allows Ruby programmers to define basic classes with large reusability and smaller subclasses for more fine-grained, detailed behaviors. 



Another way to apply polymorphic structure to Ruby programs is to use a `Module`. 

- Modules are similar to classes in that they contain shared behavior.
- You cannot create an object with a module;  a module must be mixed in with a class using the `include` method invocation.
  - This is called a **mixin**. After mixing in a module, the behaviors declared in that module are available to the class and its objects.



### **What Are Objects?**

*It is often said that everything in Ruby is an object, but this is not strictly true because not everything in Ruby is an object. But, anything that can be said to have a value is an object, which includes: numbers, strings, arrays, and even classes and modules. However, there are a few things that are not objects: methods, blocks, and variables, to name the main ones.*



Objects are created from classes. Classes can be thought of as molds, and objects are the things you produce from the molds. Individual objects will contain different information from other objects, yet they are instances of the same class.



### **Classes Define Objects**

Ruby defines the attributes and behaviors of its objects in classes.

- Classes can be thought of as basic outlines of what an object should be made of and what it should be able to do.

- To define a class, we use syntax similar to defining a method.

  - Replace `def` with `class` and use CamelCase naming conventions to create the name. 

  - Then use the reserved word `end` to finish the definition. 

  - Ruby file names shoul dbe in snake_case and reflect the class name. 

    - ```ruby
      filename: good_dog.rb
      
      class GoodDog
      end
      
      sparky = GoodDog.new
      ```

      - Here we created an instance of our `GoodDog` class and stored it in the variable `sparky`. We now have an object.
      - We say that `sparky` is an object or instane of class `GoodDog`. 
      - This workflow of creating a new object or instance from a class is called **instantiation**. So we can also say that we've instantiated an object called `sparky` from the class `GoodDog`. 
      - What is important is that an object is returned by calling the class method `new`. 



### **Modules**

Modules are another way to achieve polymorphism in Ruby.

- A **module** is a collection of behaviors that is usable in other classes via **mixins**. 

- Allows us to group reusable code in one places, extends functionality to maintain DRY code.

- Modules are also used as a namespace, which helps us organize code better. 

  - ```ruby
    module Careers
      class Engineer
      end
      
      class Teacher
      end
    end
    
    first_job = Careers::Teacher.new
    ```

- A module is mixed in to a class using the `include` method invocation. 

- What if we wanted our `GoodDog` class to have a `speak` method but we have other classes that we want to use a speak method with too?

  - ```ruby
    module Speak
      def speak(sound)
        puts sound
      end
    end
    
    class GoodDog
      include Speak
    end
    
    class HumanBeing
      include Speak
    end
    
    sparky = GoodDog.new
    sparky.speak("Arf") # => Arf!
    bob = HumanBeing.new
    bob.speak("Hello!") # => Hello!
    ```

    - Both the `GoodDog` and `HumanBeing` objects have access to the `speak` instance method.
    - This is possible through the mixing in the module `Speak`. It's as if we copy-pasted the `speak` method into the `GoodDog` and `HumanBeing` classes. 



### **Method Lookup**

When a method is called, Ruby knows where to look for the method by having a distinct lookup path that it follows each time a method is called. 

The `ancestors` method can be used on any class to find out the method lookup chain.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

=begin

Outputs:

---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject

=end
```

- The `Speak` module is placed in between the custom classes (`GoodDog` and `HumanBeing`) and the `Object` class that comes with Ruby. 
- This means that since the `speak` method is not defined in the `GoodDog` class, the next place it looks is the `Speak` module. This continues in an ordered, linear fashion, until the method is either found, or there are no more places to look.