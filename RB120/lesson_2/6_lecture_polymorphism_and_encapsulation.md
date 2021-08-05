# Lecture: Polymorphism and Encapsulation

### Polymorphism

Refers to the ability of objects with different types to respond in different way to the same message (or method invocation), that is, data of different types can respond to a common interface. 

When two or more object types have a method with the same name, we can invoke that method with any of those objects. When we don't care what type of object is calling the method, we're using polymorphism. Often, polymorphism involves inheritance from a common superclass, although inheritance isn't necassary. 

There are two ways to implement polymorphism:

- Polymorphism through inheritance

  - ```ruby
    class Animal
      def move
      end
    end
    
    class Fish < Animal
      def move
        puts "swim"
      end
    end
    
    class Cat < Animal
      def move
        puts "walk"
      end
    end
    
    # Sponges and Corals don't have a separate move method - they don't move
    class Sponge < Animal; end
    class Coral < Animal; end
    
    animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
    animals.each { |animal| animal.move }
    ```

    - Every object in the array is a different animal, but the code that uses those objects doesn't care what each object is. It only cares that each object in the array has a `move` method that requires no arguments. So every generic animal object implements some form of locomtion, though some animals don't move. The interface for this class hierarchy let us work with all those types in the same way even though the implementations may be dramatically different. This is polymorphism.
    - The `Sponge` and `Coral` classes do not have a `move` method on their own. Instead they inherit it from the `Animal` class. That method doesn't do anything here, so the `Sponge` and `Coral` do not move. This is polymorphism through inheritance. Instead of providing our own behavior for the `move` method, we're using inheritance to acquire the behavior of a superclass. 
    - When we call the `move` method on `Fish` objects which enable them to swim, or the `Cat` object when we enable it to walk, is an example of polymorphism in which two different object types can respond to the same method call by **overriding** a method inherited from a superclass.  
      - Overriding is generally treated as an aspect of inheritance, so this is polymorphism through inheritance.
    - We can see that every object in the array is a different animal, but the client code can treat them all as a generic animal (i.e. an object that can move.) So a public interface lets us work with all of these types in the same way even though the implementations can be dramaticall different. This is polymorphism in action.

### Polymorphism through duck typing

**Duck typing** occurs when objects of different unrelated types both respond to the same method name. With duck typing we aren't concerned with the class or type of an object, but whether an object has a particular behavior. *If an object quacks like a duck, then we can treat it as a duck*. Duck typing is a form of polymorphism. As long as the objects involved use the same method name and take the same number of arguments, we can treat the object as beloging to a specific category of objects.

For example, an application may have a variety of elements that can respond to a mouse click by calling a method named something like `handleClick`. Those elements may be completely different - -for instance,  a checkbox vs. a text input field -- but they're all clickable objects. Duck typing is an informal way to classify or ascribe a type to objects, while classes provide a more formal way to do that.

```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end
```

This example attempts to implement polymorphic behavior without duck typing and shows how **not to do it**. 

The issue here is that the `prepare` method has too many dependencies. It relies on specific classes and their names. It also needs to know which method it should call on each of the objects, as well as the argument that those methods require. If we change anything within those classes that impacts `Wedding#prepare` you need to refactor the method. If we need to add another wedding preparer, we have to add another `case` statement and before long, the method will become long and messy.

If we refactor the code to use polymorphism and duck typing:

```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end
```

Though there is no inheritance in this example, each of the preparer-type classes provides a `prepare_wedding` method. We still have polymorphism since all of the objects respond to the `prepare_wedding` method call. If we later need to add another preparer type, we can create another class and implement the `prepare_wedding` method to perform the appropriate actions.

*Just having two different object that have a method with the same name and compatible arguments doesn't mean that you have polymorphism*. 

```ruby
class Circle
  def draw; end
end

class Blinds
  def draw; end
end
```

These classes each have a method named `draw`, and the methods take no arguments. In the `Circle` class, `draw` presumably draws a circle on the screen. In the `Blinds` class, `draw` may cause the window blinds in an office building to be drawn.

In theory, we could write some code that uses these methods polymorphically:

```ruby
[Circle.new, Blinds.new].each { |obj| obj.draw }
```

However, it's unlikely that this would ever make sense in real code. Unless you're actually calling the method in a polymorphic manner, you don't have polymorphism. In practice, *polymorphic methods are intentionally designed to be polymorphic; if there's not intention, you probably shouldn't use them polymorphically.* 

### **Encapsulation**

Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. We can use method access control to expose these properties and methods through the public (or external) interface of a class: its public methods.

```ruby
class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
    attr_writer :nickname
end

dog = Dog.new("rex")
dog.change_nickname("barny") # changed nickname to "barny"
puts dog.greeting # Displays: Barny says Woof Woof!
```

Here, we can change the nickname of a dog by calling the `change_nickname` method without needing to know how the `Dog` class and this method are implemented.

The same thing happens when we call the method `greeting` on a `Dog` object. The output is `Barny says Woof Woof!` with the dog's nickname capitalized.  Again we don't need to know how the method is implemented. The main point is that we expect a greeting message from the dog and that's what we get.

We need to use `self` when calling private setter methods because if we didn't, Ruby would think  we were creating a local variable.

*As of Ruby 2.7, it is now legal to call private methods with a literal `self` as the caller. Note that this does **not** mean that we can call a private method with any other object, not even one of the same type. We can only call a private method with the current object.*

A class should have as few public methods as possible. It lets us simplify using the class and protect data from undesired changes from the outer world.
