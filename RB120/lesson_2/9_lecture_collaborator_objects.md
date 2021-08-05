# Lecture: Collaborator Objects



Instance variables can hold any objects such as data structures:

```ruby
class Person
  def initialize
    @heroes = ['Superman', 'Spiderman', 'Batman']
    @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0}
  end

  def cash_on_hand
    # this method will use @cash to calculate total cash value
    # we'll skip the implementation
  end

  def heroes
    @heroes.join(', ')
  end
end

joe = Person.new
joe.cash_on_hand            # => "$62.00"
joe.heroes                  # => "Superman, Spiderman, Batman"
```

They can even be set to an object of a custom class we've created:

```ruby
class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new             # assume Bulldog class from previous assignment

bob.pet = bud
```

Here, we've set `bob`'s `@pet` instnace variable to `bud`, which is a `Bulldog` object. This means that when we call `bob.pet`, it is returning a `Bulldog` object.

```ruby
bob.pet                       # => #<Bulldog:0x007fd8399eb920>
bob.pet.class                 # => Bulldog
```

Since `bob.pet` returns a `Bulldog` object, we can chain any `Bulldog` methods at the end as well:

```ruby
bob.pet.speak                 # => "bark!"
bob.pet.fetch                 # => "fetching!"
```

Objects that are stored as a state within another object are also called **collaborator objects**. We call them collaborators because they work in conjunection with the class they are associated with. For example, `bob` has a collaborator object stored in the `@pet` variable. When we need that `BullDog` object to perform some action (such as accessing some behavior of `@pet`), we can go through `bob` and call the method on the object stored in `@pet`, such as `speak` or `fetch`. 

When we work with collaborator objects, they are usually custom objects (e.g. defined by the programmer and not inherited from the Ruby core library); `@pet` is an example of a custom object. But collaborator objects aren't strictly custom objects. Even the string object stored in `@name` within `bob` in the code above is technically a collaborator object.

Collaborator objects play an important role in object orienter design, since they also represent the connections between various actors in our program.

*When working on an object oriented program we must be sure to consider what collaborators our classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem our program aims to solve.*

To make our program allow a person to have many pets:

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
```

Because `pets` is an array, we cannot just call `Pet` methods on `pets`.

```ruby
bob.pets.jump                  # NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array
```

There is no `jump` method in the `Array` class, so we get an error.

To make each individual pet jump, we need to parse out the elements in the array and operate on the individual `Pet` object:

```ruby
bob.pets.each do |pet|
  pet.jump
end
```

*Collaborator objects allow us to chop up and modularize the problem domain into cohesive pieces; they are at the core of OOP and play an important role in modeling complicated problem domains.*



Inheritance can be thought of as an "is-a" relationship, and association can be thought of as a "has-a" relationship, then a collaborative relationship is a relationship of association, not inheritance. A "has-a" instead of "is-a" relationship.

- Collaborator objects can be of any type: custom class object, array, hash, string, integer ect. 

- A collaborator object is part of another object's state. 

  - Assigning a collaborator object to an instance variable in another class' constructor method definition, we are associating the two objects with one another.

- A way to spot it in code is when an object is assigned to an instance variable of another object inside a class definition. 

- ```ruby
  class Person
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end
  joe = Person.new("Bob")
  p joe               # => #<Person:0x00000001f86c80 @name="Bob">
  joe.name            # => "Bob"
  ```

  - The object `"Bob"` assigned to the instance variable `@name` is a collaborator object of `joe`.

- ```ruby
  class Library
    def initialize
      @books = []
    end
    def add_book(book)
      @books << book
    end
  end
  class Book
    def initialize(title)
      @title = title
    end
  end
  my_library = Library.new
  p my_library    # => #<Library:0x00000000c76050 @books=[]>
  book_1 = Book.new('The Grapes of Wrath')
  my_library.add_book(book_1)
  p my_library    # => #<Library:0x00000001cedff0 @books=[#<Book:0x00000001cede10 @title="The Grapes of Wrath">]>
  ```

  - `@title` is a `String` object collaborator of objects of the `Book` class, which is made explicit in the `Book#initialize` method.

- A collaborator object is part of another object's state adn can be an object of any class.

*Collaboration doesn't just occur when code is executred and objects are occupying space in memory, but it exists from the design phase of our program.*

