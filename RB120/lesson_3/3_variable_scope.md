# Variable Scope

### Instance Variable Scope

Instance variables are scoped at the object level. They do not crossover between objects.

Because the scope of instance varialbes is at the object level, this means that the instance varialbe is accessible in an object's instance methods, even if it's initialized outside of that instance method.

```ruby
class Person
  def initialize(n)
    @name = n
  end

  def get_name 								# Do not need to pass in @name since instance variable is scoped at object level.
    @name                     # is the @name instance variable accessible here?
  end
end

bob = Person.new('bob')
bob.get_name                  # => "bob"
```

Unlike local variables, instance variables are accessible within an instance method even if they are not  initialized or passed in to the method. 

If we try to access an instance variable that is not yet initialized anywhere:

```ruby
class Person
  def get_name
    @name                     # the @name instance variable is not initialized anywhere
  end
end

bob = Person.new
bob.get_name                  # => nil
```

This shows a distinction from local variables. If we try to reference an uninitialized local variable, we get `NameError` but if we try to reference and uninitilaized instance variable, we get `nil`.

If we pout an instance variable at the class level:

```ruby
class Person
  @name = "bob"              # class level initialization

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name                  # => nil
```

Do not do this. Instance variables initialized at the class level are a different thing called class instance variables. We need to only initialize instance variables within instance methods.

### Class Variable Scope

Class variables are scoped at the class level and exhibit two main behaviors:

- all objects share 1 copy of the class variable. (This also implies objects can access class variables by way of instance methods.)

- class methods can access class variables, regardless of where it's initialized.

- ```ruby
  class Person
    @@total_people = 0            # initialized at the class level
  
    def self.total_people
      @@total_people              # accessible from class method
    end
  
    def initialize
      @@total_people += 1         # mutable from instance method
    end
  
    def total_people
      @@total_people              # accessible from instance method
    end
  end
  
  Person.total_people             # => 0
  Person.new
  Person.new
  Person.total_people             # => 2
  
  bob = Person.new
  bob.total_people                # => 3
  
  joe = Person.new
  joe.total_people                # => 4
  
  Person.total_people             # => 4
  ```

  Here, even when we have two different `Person`  objects in `bob` and `joe`, we're accessing and modifying one copy of the @@total_people class variable. We can't do this with instance or local variables, *only class variables can share state between objects (if we ignore globals).*

  ### Constant Variable Scope

  Constant variables have *lexical scope*.

  ```ruby
  class Person
    TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']
  
    attr_reader :name
  
    def self.titles
      TITLES.join(', ')
    end
  
    def initialize(n)
      @name = "#{TITLES.sample} #{n}"
    end
  end
  
  Person.titles                   # => "Mr, Mrs, Ms, Dr"
  
  bob = Person.new('bob')
  bob.name                        # => "Ms bob"  (output may vary)
  ```

  Here we can see that constant variables are available in class methods or instance methods (which implies they're accessible from objects.) What is tricky is when inheritance is involved, because unlike other variables, constants have lexical scope.
