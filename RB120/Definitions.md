# Definitions



- **Object**

  - Anything with a value.
  - A combination of data and methods.

- **Class**

  - A template for an object.
  - A blueprint that describes the state and behavior that objects of the class all share.

- **Encapsulation**

  - Hiding pieces of functionality and making it unavailable to the rest of the code base.
  - A form of data protection so that data cannot be manipulated or changed without obvious intention.
  - Use method access control to expose the properties and methods.

- **Polymorphism**

  - The ability of different types of data to respond in different ways to the same message (or method invocation). 
  - If class B inherits from class A, it doesn't have to inherit everything about class A; it can do some things that class A does differently.

- **Inheritance**

  - A class inherits the behaviors of a superclass.
  - Can only subclass from one class.
  - Is better used in a "is-a" relationship.
  - **Overriding**
    - Ruby checks the object's class for a method before checking the superclass.
  - `super`
    - Searches method lookup path for a method with the same name, then invokes it.
    - Can have arguments which are passed into the method it looks up.
    - `super()` passes no arguments to the method.

- **Duck Typing**

  - When objects of different unrelated types both respond to the same method name.
  - A form of polymorphism.

- **Module** (**Interface Inheritance**)

  - A collection of behaviors that is usable in other classes through mixins.
  - Allows us to group similar code into one place.
  - We use it by using the `include` method invocation, followed by method name.
  - Also used as a namespace.
  - An example of polymorphism.
  - When used with a class, the class inherits the interface provided by the mixin module.
  - Better for "has-a" relationships.
  - Cannot instatiate modules (no objects can be created from module).

- **Mixin**

  - A specialized implementation of multiple inheritance in which only the interface portion is inherited.

- **Instantiation**

  - Creating a new object or instance from a class.

- **Instance Variable** (**Member field**)

  - How objects keep track of their states.
  - Scoped at the object (instance) level.
  - Prefixed with "@"
  - Exists as long as the object exists.

- **Instance Method**

  - Expose behavior for objects.
  - Available to objects (instances) of that class.

- **`initialize`**

  - Gets called every time a new object is created.
  - Is automatically private.
  - Is a constructor.

- **Constructor**

  - Gets triggered whenever a new object is created and initiates the state of an object.
  - `initialize` is an example of one.
  - Does not return values.

- **Accessor Method**

  - `attr_accessor`
    - Creates a getter, setter, and instance variable.
  - Take symbol as argument.
  - **Getter Method**
    - `attr_read`
  - **Setter Method**
    - `attr_writer`
    - Always return the value that is passed in as an argument, regardless of what happens inside the method. Everything else is ignored.

- **Class Method**

  - Methods that can be called directly on the class itself, without having to instantiate any objects.
  - Creates functionality that does not pertain to individual objects.
  - Defined with the `self` keyword.
  - Cannot access instance variables.

- **Class Variable**

  - A variable that tracks the state of an entire class.
  - Shared between all instances of a class.
  - Prefixed with `@@`
  - Can be accessed using instance methods.

- **Constants**

  - Variables that are never meant to change.
  - Technically can begin with just a capital letter, but all uppercase is preferred.
  - Do not belong to an object, but to a class.

- **`self`** 

  - Used when calling setter methods from within the class.
  - Used for class method definitions.
  - When an instance method uses `self` within a class, it references the calling object (the instance that called the method).
  - When used inside a class but outside a method definition, it refers to the class itself.

- **Method Lookup**

  - Ruby looks first at the class, then the modules starting from the last, then the superclass, then the superclass modules starting from the last.
  - So Class > Modules (last first) > Superclass > Superclass Modules (last first) > Object > Kernel > BasicObject.

- **Namespacing**

  - In the context of modules, it is organizing similar classes into a module.
  - Makes it easy to recognize related classes in our code.
  - Reduces chance of classes colliding with other similarly named classes in our codebase.
  - Call the classes in the module by `Module::Class`

- **Method Access Control**

  - Implementing access modifiers to restrict access to a particular thing.
  - Can be inherited from parent class.
  - **Public Method**
    - A method that is available to anyone who knows either the class name or the object's name.
    - Readily available for the rest of the program to use and comprise the class' interface (how other classes and objects will interact with this class and its object.
    - Methods are public by default, except initialize which is private.
  - **Private Method**
    - Only accessible from other methods in the class.
    - Cannot be viewed or accessed outside of the class.
    - Cannot use with `self` (but can in Ruby 2.7+)
  - **Protected Method**
    - From inside the class, protected methods are accessible like public methods.
    - From outside the class, protected methods act like private methods.
    - Can be invoked only by objects of the defining class and it's subclasses.

- **Collaborator Objects**

  - Objects stored as a state within another object.
  - Represent connection between various actors in program.

  

