*What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.*

A module is a collection of behaviors that is usable in other classes via mixins. It allows us to have different classes use the same collection of behaviors or methods. We use them with our classes through mixins. The module is mixed into the class using the `include` method invocation.



```ruby
module Attack
  def attack(action)
   puts action 
  end
end

class BigTiger
  include Attack
end

raja = BigTiger.new
raja.attack("Bite!")
```



