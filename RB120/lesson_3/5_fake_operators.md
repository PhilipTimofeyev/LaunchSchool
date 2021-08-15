# Fake Operators

Here is a table of which operators are real operators, and which are emthods discuised as operators. 

(Listed in order of precedence, highest first)

![Screen Shot 2021-08-09 at 10.33.29 AM](/Users/philiptimofeyev/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.33.29 AM.png)

Operators marked with a 'yes' mean they are methods. Which means we define them in our classes ato change their default behaviors. Although this may seem like a useful feature, the issue is since any class can provide their own fake operator, reading code like `obj1 + obj2` means we have no idea what will happen. 

The `.` and `::` are often omitted from Ruby documentation about operators, however they are operators and have the highest precendence of operators.

### Equality Methods

One of the most common fake operators to be overrideden is the `==` equality operator. It's very useful to provide our own `==` method.

### Comparison Methods

Implementing the comparison methods gives us a nice syntax for comparing objects:

```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)

puts "bob is older than kim" if bob > kim
```

Here we can a `NoMethodError` because Ruby can't find the `>` method for `bob`. 

We can fix this by adding a `>` method to the `Person` class:

```ruby
class Person
  # ... rest of code omitted for brevity

  def >(other_person)
    age > other_person.age
  end
end
```

### The `<<` and `>>` shift methods

The `<<` calls the `Array#<<` method. It does not work for hashes because `Hash` does not contain a `<<` method.

It is not common to implement `>>`.

It's important to choose a functionality that makes sense. Using the `<<` method fits well when working with a class that represents a collection:

```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)     # suppose we're using the Person class from earlier

cowboys << emmitt                           # will this work?

cowboys.members                             # => [#<Person:0x007fe08c209530>]
```

Here we provide a clean interface for adding new members to a team object. If we wanted to be stricts we could add a guard class to reject adding the member unless some criteria is met.

```ruby
def <<(person)
  return if person.not_yet_18?              # suppose we had Person#not_yet_18?
  members.push person
end
```

Adding shift operators can result in very clean code, but they make the most sense when working with classes that represent a collection.

### The Plus Method

This is what `+` is doing in the background:

```ruby
1 + 1                                       # => 2
1.+(1)                                      # => 2
```

When decided on how to write the `+` method for our own objects, we need to consider that the functionality of the `+` should either be incrementing or cncatenation with the argument. 

```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = cowboys + niners               # what is dream_team?
```

This implementation of `+` returns an array of `Person` objects. But this does not match the general pattern from the standard library. `Integer#+` returns a new `Integer` object, `String#+` returns a new `String` obect, and `Date#+` returns a new `Date` object.

Our `Team#+` method should return a new `Team` object.

We refactor:

```ruby
class Team
  # ... rest of class omitted for brevity

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

dream_team = niners + cowboys
puts dream_team.inspect                     # => #<Team:0x007fac3b9eb878 @name="Temporary Team" ...
```

### Element Setter and Getter Methods

```ruby
my_array = %w(first second third fourth)    # ["first", "second", "third", "fourth"]

# element reference
my_array[2]                                 # => "third"
my_array.[](2)                              # => "third"
```

This is syncatical sugare of `Array#[]`

Assignment:

```ruby
# element assignment
my_array[4] = "fifth"
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth"]

my_array.[]=(5, "sixth")
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth", "sixth"]
```

Another example of syncatical sugar.



If we want to use the element setter and getter methods in our class, we have to make sure we're working with a class that represents a collection.

```ruby
class Team
  # ... rest of code omitted for brevity

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

# assume set up from earlier
cowboys.members                           # => ... array of 3 Person objects

cowboys[1]                                # => #<Person:0x007fae9295d830 @name="Emmitt Smith", @age=46>
cowboys[3] = Person.new("JJ", 72)
cowboys[3]                                # => #<Person:0x007fae9220fa88 @name="JJ", @age=72>
```

