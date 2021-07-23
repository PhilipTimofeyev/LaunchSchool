**Important Language**

On `line #` we are initializing the local variable `###` and assigning it to an #integer with value `###`.

On `line #` we are reassigning variable `###` to a different #string object that has a value of `###`.

On `lines #–#` we are defining the method `###` which takes parameter, `###`.

On `line #` we are calling the method `###` and passing in the #string `###` as an argument to it.

On `line #` we are calling the method `#loop` and passing in the `do..end` block as an argument with parameter, `###`.

On `line #` we are calling the method `#puts` and passing in local variable `###` to it as an argument.

This code outputs #string `###`  and returns #array  `###`.





**Local Variable Scope**

1. ```ruby
   a = "Hello"
   b = a
   a = "Goodbye"
   puts a
   puts b
   ```

   > On `line 1` we are initializing the local variable `a` and assigning it to a string with value `Hello`. On `line 2` we are initializing the local variable `b` to a string object that variable `a` is referencing, so both of the variables are pointing to the same object. 
   >
   > On `line 3` we are reassigning variable `a` to a different string object that has a value of `Goodbye`.  So now variable `a` is pointing to a string object with a value of `Goodbye` and variable `b` is pointing to a string object with a value of `Hello`.
   >
   > On `line 4` we are calling the method `puts` and passing in local variable `a` to it as an argument, which outputs `'Goodbye'` and returns `nil`. 
   >
   > On `line 5` we are calling the method `puts` and passing in local variable `b` to it as an argument, which outputs `'Hello'` and returns `nil`.
   >
   > This demonstrates the concept of reassignment, specifically that a variables point to objects, so once a variable is reassigned it points to a different object without affecting the original object.
   
2. ```ruby
   a = 4
   
   loop do
     a = 5
     b = 3
     
     break
   end
   
   puts a
   puts b
   ```

   > The local variable `a` is initialized on line 1 and assigned to the integer `4`. The `do..end` alongside the loop method invocation on lines 3 to 6 defines a block, within which `a` is assigned to integer `5` and local variable  `b` is initalized and assigned to integer `3`. The puts method is called on variable `a` and outputs  `4`  and returns `nil`. The puts method is called on variable `b` and returns a NameError. This demonstrates the concept of variable scope in Ruby, specifically that variables initialized inside of a block are not accessible outside that block.

3. ```ruby
   a = 4
   b = 2
   
   loop do
     c = 3
     a = c
     break
   end
   
   puts a
   puts b
   ```

   > On `line 1` we initialize the local variable `a` to integer `4`. 
   >
   > On `line 2` we initialize the local variable `b` to integer `2`. 
   >
   > On `lines 4-8` we invoke the `loop` method and pass in a `do..end` block as an argument. Within the block we initialize the local variable `c` to the integer `3`. Variable `c` is scoped at the level of the block. Then on `line 6` we reassign variable `a` to the value of `c`, so now both `c` and `a` point to the same object. On `line 7` we use `break` to end the loop which returns `nil`. 
   >
   > The output of `line 10` is `3` and it returns `nil`.
   >
   > The output of `line 11` is `2` and returns `nil`. 
   >
   > This is an example of variable as pointers in Ruby, specifically that variables point to a memory in space, so assigning another variable to that variable points it to the same memory in space but it does not adopt the scope of the original variable.	
   
4. ```ruby
   def example(str)
     i = 3
     loop do
       puts str
       i -= 1
       break if i == 0
     end
   end
   
   example('hello')
   ```

   > On `lines 1-8` we define the method `example` which has one parameter, `str`. 
   >
   > On `line 10` we invoke the `example` method and pass in the string `hello` as an argument and assign it ot the local variable `str`, where `str` points to the `'hello'`. Inside the methid on `line 2` we initialize the variable `i` to integer `3`. Then on `lines 3-7` we invoke the `loop` method alongside the `do..end` block. On `line 4` we invoke the `puts` method and pass in the string `'hello` as an argument. On `line 5` we reassign the variable `i` to `i-.(1)` which sutracts integer `1` from `3` on each iteration until the variable `i` is reassigned to integer `0`. Since the iteration happens three times, it outputs `'hello` three times. Because the `break if` statement is the last evaluated expression, the method returns `nil`. 
   >
   > This is an example of local variable scope, specifically how the variables initialize outside of a block can be accessed inside of the block.
   
5. ```ruby
   def greetings(str)
     puts str
     puts "Goodbye"
   end
   
   word = "Hello"
   
   greetings(word)
   ```

   > On `lines 1-4` the method `greetings` is defined with one parameter, `str`. On `lin 6` the local variable `word` is initiated and assigned to a string with a value of `Hello`. On `line 8` we are invoking the method `greetings` and passing in the variable `word`. 
   >
   > Once passed in, the local variable `str` is assigned to the argument passed in, the variable `word`. So now both `str` and `word` point to the same object, `"Hello`". On `line 2` the `puts` method is called and passes the `str` variable in as an argument, which outputs `"Hello"` and returns `nil`. Then on `line 3` the `puts` method is called and passes in the string `Goodbye` which outputs `"Goodbye"` and returns `nil`. 
   >
   > This demonstrates the concept of local variable scope, specifically that for a variable to be accessible within a method, it must be passed into the method as an argument. 
   
6. ```ruby
   arr = [1, 2, 3, 4]
   
   counter = 0
   sum = 0
   
   loop do
     sum += arr[counter]
     counter += 1
     break if counter == arr.size
   end
   
   puts "Your total is #{sum}"
   ```

   > On `line 1` we initialized the variable `arr` and assign it to an array with four integers as elements, `[1, 2, 3, 4]`. On `line 3` we initialize the variable `counter` and assign it to an integer with a value of `0`. On `line 4` we initialize the variable `sum` and assign it to an integer with a value of `0`. 
   >
   > On `lines 6-10`, we invoke the `loop` method and pass in a `do..end` block as an argument. Within the block on `line 7`, we reassign the `sum` variable to `sum + arr[counter]` using the `Integer+` method and passing in `arr[counter]` as an argument. On `line 8` we reassign the `counter` variable to `counter.+ (1)` using the `Integer+` method and passing in the `counter` variable as an argument. On `line 9` we stop the loop if the conditional `counter == arr.size` returns `true`.  With each iteration of the loop, each element of the `arr` variable is being access and added to the total `sum`. until the value of the `counter` is equal to the value of `arr.size`.
   >
   > On `line 12` the `puts` method is called and passes in the string `Your total is #{sum}` which uses string interpolation to convert the integer value of `sum` to a string. This outputs `"Your total is 10"` and returns `nil`. 
   >
   > This demonstrates the concept of local variable scope, specifically that variables initialized outside of a block are accessible within the block. 
   
7. ```ruby
   a = 'Bob'
   
   5.times do |x|
     a = 'Bill'
   end
   
   p a
   ```

   > On `line 1` we initialize the local variable `a` to the string `'bob'`. 
   >
   > On `lines 3-5` we call the `times` method on integer `5` and pass in a `do..end` block as an argument with one parameter, `x`. Within the block on `line 4` we reassing the variable `a` to the string `'Bill'`. The `times` method reassigns it five times and then returns  `5`.
   >
   > On `line 7` the output and return is `'Bill'`.
   >
   > This is an example of variable scope in Ruby, specficially that if a variable is initialized in the outer scope can be accessed in the inner scope. 
   
8. ```ruby
   animal = "dog"
   
   loop do |_|
     animal = "cat"
     var = "ball"
     break
   end
   
   puts animal
   puts var
   ```

   > On `line 1` we initialize the variable `animal` to the string, `dog`. 
   >
   > On `line 3` we invoke the loop method and pass in the `do..end` block with an empty parameter which defines the block on `lines 3-7`.  Then on `line 4` we reassign the variable `animal` to the string `'cat'` , becuase the variable is accessible inside of the block. 
   >
   > On `line 5` we initilaize the variable `var` to the string `'ball'`, but this variable is not accessible outside of the block.
   >
   > On `line 9` we invoke the `puts` method and pass in the object that `animal` points to, which outputs `cat` and returns `nil`.
   >
   > On `line 9` we try to invoke the `puts` method on the object that `var` points to but because the variable is not accessable outside of the block, we cannot pass the object as an argument to the `puts` method.
   >
   > This is an example of variable scoping in Ruby, specifically that local variables initiliazed inside of a block are not accessible outside of the block. 
   
9. ```ruby
   a = 4
   b = 2
   
   2.times do |a|
     a = 5
     puts a
   end
   
   puts a
   puts b
   ```

   > On `line 1` with initialize variable `a` and assign to an integer with a value of `4`. On `line 2` we initialized local variable `b` and assign it to an integer with a value of `2`. 
   >
   > One `lines 4-7`, we call the `times` method on the integer `2` and pass in a `do..end` block with a parameter of `a`. Because the parameter for the block has the same name as the variable `a` in the main scope, variable shadowing occurs and prevents the block from being able to access the main scope variable `a`. This is why instead of reassigning variable `a` to the integer with a value of `5`, it initializes a new variable `a` and assigns it to an integer with a value of `5`. At this point, there are two variable `a`s and they point to seperate objects.
   >
   > On `line 6`, the `puts` method is called and passes the variable `a` of the block into it, because we are within the scope of the block, and outputs `5` two times. The block returns the `2` because the times method returns the initial integer.
   >
   > On `line 9`, the output is `4` and it returns `nil`.
   >
   > On `line 10`, the output is `2` and it returns `nil`.
   >
   > This is an example of variable shadowing, specifically that blocks with the same parameter name as a variable outside of the block, will not have access to the outside variable. 
   
10. ```ruby
    n = 10
    
    1.times do |n|
      n = 11
    end
    
    puts n
    ```

    > On `line 1` we initialize the local variable `n` and assign it to an integer with the value of `10`. 
    >
    > On `lines 3-5` we call the `times` method on the integer `1`, and pass the `do..end` block with a parameter of `n` in as an argument. 
    >
    > Because the parameter of the block has the same name as the variable `n` outside of the block, this causes variable shadowing which means the block does not have access to that variable. So instead of reassigning the variable `n` on `line 4`, we are initializing a different variable `n` and assigning it to an integer with a value of `11`. 
    >
    > On `line 7`, we call the `puts` method and pass the variable `n` in as an argument. This outputs `10` and returns `nil` because the main scope variable `n` could not be reassigned from within the block.
    >
    > This is an example of variable shadowing, specifically that a block with the same parameter name as a variable outside of the block, will not have access to the outside variable.
    
11. ```ruby
    animal = "dog"
      
    loop do |animal|
      animal = "cat"
      break
    end
    
    puts animal
    ```

    > On `line 1` we initialize the variable `animal` to the string `'dog'`.
    >
    > On `lines 3-6` we invoke the `loop` method and pass in a `do..end` block as an argument with one parameter, `animal`. 
    >
    > Becuase the variable `animal` has the same name as the block parameter, this prevents the block from being able to access the variable due to variable shadowing. The variable `animal` inside the block is a different variable than the one on `line 1`. The inside block `animal` is assigned to the string `'cat'`, and then we use a `break` statement to end the loop, and the `loop` method returns `nil`.
    >
    > The output of `line 8` is `dog` and the return is `nil`.
    >
    > This is an example of variable shadowing in Ruby, specifically that a block parameter with the same name as a variable outside of the block, prevents the block from having access to the variable.
    
12. ```ruby
    a = "hi there"
    b = a
    a = "not here"
    
    puts a
    puts b 
    ```

    > On `line 1` we initilaize the local variable `a` to the string `'hi there'`. 
    >
    > On `line 2` we initialize the local variable `b` to the same object that variable `a` is referencing. Now both variable `a` and `b` are referencing the string `'hi there'`. 
    >
    > On `line 3` we reassign the variable `a` to the string `'not here'`. Now variable `a` and `b` are referencing different objects.
    >
    > On `line 5` we invoke the `puts` method and pass in the object variable `a` is referencing as an argument, which outputs `not here` and returns `nil`. 
    >
    > On `line 6` we invoke the `puts` method and pass in the object variable `b` is referencing as an argument which outptus `hi there` and returns `nil`. 
    >
    > This is an example of variables being pointers in Ruby, specifically that variables point to a space in memory and reassigning a variable causes it to point to a different space in memory without affecting other variables.
    
13. ```ruby
    a = "hi there"
    b = a
    a << ", Bob"
    
    puts a 
    puts b 
    ```

    > On `line 1` we initialize the local variable `a` and assign it to a string with the value of `hi there`. Then on `line 2` we initialize the local variable `b` and assign it to the same objec that variable `a` is referencing, `hi there`. 
    >
    > On `line 3`, we use the `<<` method which is a destructive method to append a string with a value of `, Bob` to the string object `hi there` that both variables `a` and `b` are referencing. Because `<<` mutates the caller, both variables `a` and `b` are now referencing the same string object, `hi there, Bob`.
    >
    > On `line 5` the `puts` method is called and passes variable `a` in as an argument which outputs `hi there, Bob` and returns `nil`.
    >
    > On `line 6` the `puts` method is called and passes variable `b` in as an argument which outputs `hi there, Bob` and returns `nil`.
    >
    > This is an example of mutation, specifically that methods that mutate the caller will modify the object the variable is referencing for all variables referencing it. 
    
14. ```ruby
    a = [1, 2, 3, 3]
    b = a  
    c = a.uniq
    
    p a   
    p b   
    p c  
    ```

    > On `line 1` we initialize the local variable `a` and assign it to an array with four integers as the elements,  `[1, 2, 3, 4]`. Then on `line 2` we initialize a local variable `b` and assign it to the same object that variable `a` references, the array `[1, 2, 3, 4]`. At this point, both variables reference the same object.
    >
    > On `line 3`, the local variable `c` is initialized and assigned to the return of the method `uniq` called on variable `a`. Because `uniq` is non-mutating, the object that variables `a` and `b` reference are not mutated. And because the invocation of the  `uniq` method removes all duplicate elements, variable `c` is now assigned to an array with three elements, `[1, 2, 3]`.
    >
    > `Lines 5-6` call the `p` method and pass variables `a` and `b` as arguments. Since the object they reference was not mutated, the output and return will be `[1, 2, 3, 3]`.
    >
    > On `line 7`, since variable `c` was assigned to the return of the method `uniq` called on variable `a`, it outputs and returns `[1, 2, 3]`.
    >
    > This is an example of reassignment, specifically that reassigning variables does not affect the original object or variables assigned to the original object.
    
15. ```ruby
    def test(b)
      b.map { |letter| "I like the letter: #{letter}" }
    end
    
    a = ['a', 'b', 'c']
    test(a)
    
    p a
    ```

    > On `line 5` we initialize the local variable `a` and assign it to an array with three string elements , `['a', 'b' , 'c']`. 
    >
    > On `lines 1-3` we define the method `test` which has one parameter, `b`. 
    >
    > on `line 6` we invoke the method `test` and pass the variable `a` in as an argument. Inside the method, the variable `b` is assigned to the same object that variable `a` is referencing, they are both pointing to `['a', 'b', 'c']`. The method `map` is called on variable `b ` and passes the `{}` block in as an argument, with one parameter, `letter`. With each iteration, we pass an element from the array, in order, into the block's argument and reassign it to the variable `letter`. Because the `map` method invocation returns a new array with the output of each iteration of the block, the original array that variable `a` is referencing is not mutated.
    >
    > On `line 8` the `p` method is called and passes in the variable `a` as an argument. This outputs and returns `['a', 'b', 'c']`.
    >
    > This is an example of mutability, specifically that calling a nondestructive method like `map` and passing in a non-destructive block as an argument, will not mutate the caller or the argument. 

16. ```ruby
    a = 5.2
    b = 7.3
    
    a = b
    
    b += 1.1
    
    puts a
    puts b
    ```

    > On `line 1` we initialize the local variable `a` to the float `5.2`.
    >
    > On `line 2` we initialize the local variable `b` to the float `7.3`. 
    >
    > On `line 4` we reassign variable `a` to the object that variable `b` is referencing. Now both variable `a` and `b` are referencing the float `7.3`.
    >
    > On `line 6` we reassign variable `b` to the output of calling the `+.` method on the object variable `b` is referencing, and passing in the float `1.1` as an argument, `b = 7.3+.(1.1)`.This reassigns variable `b` to the float `8.4`. 
    >
    > `Line 8` outputs `7.3` and returns `nil`.
    >
    > `Line 9` oututs `8.4` and returns `nil`. 
    >
    > This is an example of immutable objects in Ruby, specifically that numbers are immutable in `ruby` and cannot be mutated, but only reassigned. 

17. ```ruby
    def test(str)
      str += '!'
      str.downcase!
    end
    
    test_str = 'Written Assessment'
    test(test_str)
    
    puts test_str
    ```

    > On `lines 1-4` we define the method `test` which takes one parameter, `str`.  On `line 6` we initialize the variable `test_str` and assign to a string with the value of `Written Assessment`. 
    >
    > On `line` 7 we invoke the `test` method and pass the `test_str` variable into it as an argument and assign the variable `str` to it. On `line 2` the `str` variable is reassigned to `str + '!'`. Because this is reassignment, the original `test_str` variable passed into the method is not mutated.
    >
    > on `line 3` we call the `downcase!` method on the `str` variable and because the method is destructive, it mutates the object that was assigned in `line 2`, and not the original argument passed into the method.
    >
    >  `line 9` outputs `Written Assessment` and returns `nil`. This demonstrates the concept of reassignment and mutalibilty. Specficially that reassignment does not mutate the caller, but mutating methods do. 

18. ```ruby
    def plus(x, y)
      x = x + y
    end
    
    a = 3
    b = plus(a, 2)
    
    puts a
    puts b
    ```

    > On `lines 1-3` we define the method `plus` which has two parameters, `x` and `y`. 
    >
    > On `line 5` we initialize the local variable `a` and assign it to an integer with a value of `3`.
    >
    > On `line 6` we initialize variable `b` and assign it to the return of the `plus(x, y)` method invocation which passes variable `a` as the first argument, and the integer `2` as the second argument. 
    >
    > Once the arguments are passed into the method, variable `x` is assigned to the same object that variable `a` is referencing, which is integer `3`. And variable `y` is assigned to an integer with a value of `2`. Now, variable `x` is reassigned to `5 + 2` which is `7`, but because this is reassignment and integers are immutable in Ruby, the variable `a` outside of the method invocation retains it's original value of `3`. Now variable `b` is assigned to the return of the method call, which is an integer with a value of `7`. 
    >
    > On `line 8` the `puts` method is invoked which passes the variable `a` in as an argument and outputs `3` and returns `nil`.
    >
    > On  `line 9` the `puts` method is invoked and passes the variable `b` in as an argument and outputs `7` and returns `nil`.
    >
    > This is an example of numbers being immutable in Ruby, specifically that there is no way to mutate a number assigned to a variable regardless of scope. The variable can only be reassigned to a different value. 

19. ```ruby
    def increment(x)
      x << 'b'
    end
    
    y = 'a'
    increment(y)
    
    puts y
    ```

    > On `lines 1-3` we define the method `increment` which has one parameter, `x`.
    >
    > On `line 5` we initialize local variable `y` and assign it to a string with a value of `a`. 
    >
    > On `line 6` we invoke the `increment` method and pass in `y` as an argument. The object that variable `y` is pointing to is assigned to variable `x` inside the method. We then call the `<<`  method on variable `x`  which mutates the caller by appending a string with a value of `b` to it when it passes the string `b` in as an argument. Because `<<` mutates the caller, the value variable `y` outside of the scope of the method is referencing, gets mutated and becomes the string `ab`. 
    >
    > On `line 8` we invoke the `puts` method and pass in `y` as an argument, which outputs `ab` and returns `nil`.
    >
    > This is an example of mutation in Ruby. Specifically that invoking a method that mutates the caller will mutate the value a variable references outside of the method.

20. ```ruby
    def change_name(name)
      name = 'bob'
    end
    
    name = 'jim'
    change_name(name)
    
    puts name
    ```

    > On `line 1-3` we define the method `change_name` which has one parameter, `name`. 
    >
    > On `line 5` we initialie the local variable `name` to the string `'jim'`.
    >
    > On `line 6` we invoke the `change_name` method and pass in the string object variable `name` is reference, `'jim'`, as an argument where it gets aassigned to the local variable `name`. This local variable is different from the variable `name` outside of the definition. 
    >
    > Inside of the method on `line 2` we reassign the variable `name` to the string `'bob'`. Because reassignment does not mutate the caller, and the local variable `name` is different than `name` outside of the method, and it is scoped at the method definition level, the string object that variable `name` is assigned to on `line 5` remains `'jim'`.
    >
    > On `line 8` the output is `jim` and it returns `nil`. 
    >
    > This is an example of how reassignment works in `ruby`, specifically that unless an action inside the method definition mutates the argument passed into the method, the object passed in as an argument will remain the same.

21. ```ruby
    def cap(str)`
      str.capitalize!
    end
    
    name = "jim"
    cap(name)
    
    puts name
    ```

    > On `lines 1-3`, we define the method `cap` which has one parameter, `str`. 
    >
    > On `line 5` we initialize the local variable `name` and assign it to a string with the value of `jim`. 
    >
    > On `line 6` we invoke the method `cap` and pass in the variable `name` as an argument. The method assigns the variable `str` to the same object that the variable `name` is referencing. So both `str` and `name` reference the string `jim`. Then the `capitalize!` method is called on the variable `str` which mutates the caller. Because it is a mutating method, the object both `str` and `name` are referencing now become capitalized, `Jim`. 
    >
    > On `line 8` we invoke the `puts` method and pass  variable `name` in as an argument which outputs `Jim` and returns `nil`.
    >
    > This demonstrates mutability in Ruby, specifically that method definitions that perform and action which mutates the caller, will permanently modify the argument passed into it.

22. ```ruby
    a = [1, 3]
    b = [2]
    arr = [a, b]
    
    p arr
    
    a[1] = 5
    
    p arr
    ```

    > On `line 1` we initialize local variable `a` and assign it to an array object which has two integer elements, `[1, 3]`.
    >
    > On `line 2` we initialize local variable `b` and assign it to an array object which has one integer element, `[2]`. 
    >
    > On `line 3` we initialize the local variable `arr` and assign it to an array that has two elements, `[a, b]`.  Now this array contains the array `[1, 3]` at `arr[0]` and the array `[2]` at `arr[1]`.
    >
    > On `line 5` the output is `[[1, 3], [2]]` 
    >
    > On `line 7` we reassign `a[1]` to a new integer using the setter method `Array#[]=`
    >
    > The output of `line 9` is `[[1, 5], [2]`
    >
    > This demonstrates that in Ruby indexed assignment is mutating.

23. ```ruby
    arr1 = ["a", "b", "c"]
    arr2 = arr1.dup
    arr2.map! do |char|
      char.upcase
    end
    
    p arr1
    p arr2
    ```

    > On `line 1` we initialize local varriable `arr1` and assign it to an array object with three string elements, `["a", "b", "c"]`. On `line 2` we initialize the local variable `arr2` and assign it to the the return of the `dup#` method called on variable `arr1`. This duplicates the array object `arr1` is referencing, but the element objects remain the same object with the same object_ids. 
    >
    > On `lines 3-5` we call the `map!` method on `arr2` and pass into it a `do..end` block with one parameter, `char`. Because `map!` mutates the caller, the return of each iteration replaces the value of the current `char` argument. Because `upcase` does not mutate the caller, `line 4` does not modify `arr1`. 
    >
    > On `line 7` we output `["a", "b", "c"]` and return `nil`.
    >
    > On `line 8` we output `["A", "B", "C"]` and return `nil`.
    >
    > This is an example of mutability, specifically that duplicated arrays that are mutated do not affect the original array it was duplicated from.

24. ```ruby
    def fix(value)
      value.upcase!
      value.concat('!')
      value
    end
    
    s = 'hello'
    t = fix(s)
    
    puts s
    puts t
    ```

    > On `lines 1-5` we define the method `fix` which has one parameter, `value`.
    >
    > On `line 7` we initialize the local variable `s` to the string `'hello'`.
    >
    > On `line 8` we initialize the local variable `t` and assign it to the return of the `fix` method invocation passing in the object variable `s` is pointing to, the string `hello`, which gets assigned to the local variable `value` inside the method. Now the variables `value` and `s` point to the same string object. 
    >
    > Within the method on `line 2` we call the `upcase!` method on the object the variable `value` is referencing. Because `upcase!` mutates the caller, this mutates the argument that was passed into the method, so now variable `value` and `s` both reference the string 'HELLO'.
    >
    > On `line 3` the `concat` method is called on the object `value`  and `s`is referencing and passes in the string `'!'` as an argument. This mutates the caller and appends the string `!` to the string object, `hello`. So now both variable `s` and `value` reference the string `HELLO!`.
    >
    > On `line 4` we return the object that `value` is referencing, which is what gets assigned to the variable `t`.
    >
    > The output of `line 10` and `line 11` is 'HELLO!' and it returns `nil`.
    >
    > This is an example of mutation in Ruby, specifically that actions wihtin a method that mutate the argument passed in will modify the object outisde of the method definition. 

25. ```ruby
    def fix(value)
      value = value.upcase
      value.concat('!')
    end
    
    s = 'hello'
    t = fix(s)
    
    puts s
    puts t
    ```

    > On `lines 1-4` we define the method `fix` which has one parameter, `value`. 
    >
    > On `line 6` we initialize the local variable `s` and assign it to the string object with a value of `hello`. 
    >
    > On `line 7` we initilialize the local variable `t` and assign it to the return of the method invocation of the `fix` method which passes in variable `s` as an argument.
    >
    > Within the method, the variable `value` is assigned to the same object that `s` references, so they both reference `'hello'`. On `line 2`, we reassign the variable `value` to the return of `value.upcase`. Because the `upcase` method is non-mutating, it does not affect the object variable `s` is pointing to. Once `value` is reassigned, `value` no longer references the same object as `s`. Currently, `s` references `'hello'` and `value` references `'HELLO'`. 
    >
    > On `line 3`, the `concat()#` method is called on the variable `value` passing in `'!'` as an argument. Because `concat()` mutates the caller, value now references `HELLO!`.
    >
    > The output of `line 9` is `hello` and returns `nil`.
    >
    > The output of `line 10` is `HELLO!` and returns `nil`. 
    >
    > This is an example of mutability within Ruby, specifically that once a variable is reassigned, it points to a new object that if mutated will not offect the original object it was assigned to.

26. ```ruby
    def fix(value)
      value << 'xyz'
      value = value.upcase
      value.concat('!')
    end
    
    s = 'hello'
    t = fix(s)
    
    puts s
    puts t
    ```

    > On `lines 1-5` we define the method `fix` which has one parameter, `value`. 
    >
    > On `line 7` we initialized the local variable `s` and assign it to a string object with a value of `hello`.
    >
    > On `line 8` we initialize the local varaible `t` and assign it to the return of the `fix` method invocation, which passes in variable `s` as the argument.
    >
    > Within the method, the variable `value` is assigned to the same object that variable `s` references, but at the scope of the method definition. On `line 2`we call the `<<` method on the variable `value` and append it with the string object `xyz`. Because the `<<` mutates the caller, the object both `value` and `s` reference is now `'helloxyz'`. 
    >
    > On `line 3` we reassign the variable `value` to the return of calling `upcase` on the variable `value`. Because `upcase` does not mutate the caller, this does not mutate the object `s` references, but now `value` and `s` reference different objects.
    >
    > On `line 4` we call the `concat()` method on value and pass `'!'` in as an argument. Because `concat()` mutates the caller, the object `value` is referencing is modifed and appended with a `"!"` to now be `'HELLOXYZ!'`.
    >
    > The output of `line 10` is `helloxyz` and it returns `nil`.
    >
    > The output of `line 11` is `HELLOXYZ!` and returns nil.
    >
    > This demonstrates the concept of reassignment and mutability in ruby. Specifically that once a variable is reassigned, it references a new object that if mutated will not affect the object it referenced prior.

27. ```ruby
    def fix(value)
      value = value.upcase!
      value.concat('!')
    end
    
    s = 'hello'
    t = fix(s)
    
    puts s
    puts t
    ```

    > On `lines 1-4` we define the method `fix` which has one parameter, `value`. 
    >
    > On `line 6` we initialize the local variable `s` and assign it to the string `'hello'`. 
    >
    > On `line 7` we initialize the local variable `t` and assign it to the return of the method `fix` passing in variable `s` as an argument. 
    >
    > Within the method, the method definition scoped variable `value` is initialized and assigned to the same object that variable `s` references, so they both point to the string `'Hello'`. On `line 2` the variable `value` is reassigned to the return of the `upcase!` method called on the `value` variable. Because `upcase!` mutates the caller, this method mutates the argument passed into the method which mutates the object `s` is referencing. so now both `value` and `s` reference the same object, `"HELLO".
    >
    > On `line 3` the `concat()` method is called on the variable `value` and passes in `'!'` as an argument. Because `concat()` mutates the caller, this modifies the object both `value` and `s` are referencing to now be `"HELLO!"`.
    >
    > The output of `line 9` is `"HELLO!"` and it returns `nil`.
    >
    > The output of `line 10` is `"HELLO!"` and it returns `nil`.
    >
    > This demonstrates the concept of mutability in Ruby. Specifically that reassignment of a variable to the return of a method that mutates the caller will not reassign the variable to a new object.

28. ```ruby
    def fix(value)
      value[1] = 'x'
      value
    end
    
    s = 'abc'
    t = fix(s)
    
    puts s
    puts t
    ```

    > On `lines 1-4` we define the method `fix` which has one parameter, `value`.
    >
    > On `line 6` we initilaize the variable `s` to the string `'abc'`. 
    >
    > On `line 7` we initiliaze the variable `t` to the return of invoking the `fix` method and passing the value of variable `s` as an argument, which gets assigned to the local variable `value`. Now both variables `s` and `value` reference the same object.
    >
    > Inside the method we use the `String#[]=` method to change the second character of the string `abc` to `'x'`. Because this method mutates the caller, both variables `value` and `s` have a string value of `'axc'`. On `line 3` we return the value `value`.
    >
    > On `line 9` we output `'axc'` and return `nil`.
    >
    > On `line 10` we output `'axc'` and return `nil`.
    >
    > This is an example of mutability in Ruby, specficially that methods inside a method definition that mutate the caller will mutate the argument passed into the method.

29. ```ruby
    def a_method(string)
      string << ' world'
    end
    
    a = 'hello'
    a_method(a)
    
    p a
    ```

    > On `lines 1-3` we define the method `a_method` which has one parameter, `string`. 
    >
    > On `line 5` we initialize the variable `a` and assign it to the string `'hello'`.
    >
    > On `line 6` we invoke the `a_method` and pass in the variable `a` as an argument. Within the method the variable `string` is assigned at method definition level to the same object that `a` references, `'hello'`.  On `line 2` we call the `<<` method on the variable `string` and pass in the argument `' world'`, because `<<` mutates the caller, the argument passed into the method, `a` is mutated and appended to now have a value of `hello world`.
    >
    > The output of `line 8` is `'hello world'` and it returns `'hello, world'`
    >
    > This demonstrates the concept of mutation in Ruby, specifically that actions within a method that mutate the argument will mutate the object outside of the method definition. 

30. ```ruby 
    num = 3
    
    num = 2 * num
    
    p num
    ```

    > On `line 1` we initialize the local variable `num` and assign it to the integer `3`. 
    >
    > On `line 3` we reassign the variable `num` to the return of integer `2.* (num)` which passes in the variable `num` as an argument. 
    >
    > On `line 5` the output is `6` and it returns `6`.
    >
    > This demonstrates that numbers are immutable in Ruby. 

31. ```ruby
    a = %w(a b c)
    a[1] = '-'
    
    p a
    ```

    > On `line 1` we initialize the variable `a` and assign it to an array object which contains three string elements, `['a', 'b', 'c']`
    >
    > On `line 2` we use the method `Array[]=` to mutate the array object referenced by variable `a` and reassign the element at  `a[1]` to be the string `'-'`.
    >
    > The output of `line 4` is `['a', '-', 'c']` and it returns `['a', '-', 'c']` .
    >
    > This demonstrates that indexed assignment is mutating, specifically that the indexed assignment mutates the original object and doesn't change it's binding. The collection element references a new object, not the collection itself.

32. ```ruby
    def add_name(arr, name)
      arr = arr + [name]
    end
    
    names = ['bob', 'kim']
    add_name(names, 'jim')
    
    p names
    ```

    > On `line 1-3` we define the method `add_name` which has two parameters, `arr` and `name`. 
    >
    > On `line 5` we initialize the `names` variable to an array object with two string elements, `'[bob', 'kim']`.
    >
    > On `line 6` we invoke the `add_name` method and pass in the value of `names` in as the first argument, were it is assigned to the local variable `arr`. And we pass in the string `'jim'` as the second argument, where it is assigned to the local variable `name`.
    >
    > Within the method on `line 2`, we reassign the variable `arr` to the return of `arr + [name]`. The `+` method concatenates `['jim']` to the arr that `arr` references. Because this is reassignment, the original array object that `names` references on `line 5` does not get modified. Which is why the output and return of `line 8` is `['bob', 'kim']`.
    >
    > This is an example of reassignment in Ruby, specifically that reassigning an argument to a variable will not mutate the object that was passed in as an argument.

33. ```ruby
    def add_name(arr, name)
      arr = arr << name
    end
    
    names = ['bob', 'kim']
    add_name(names, 'jim')
    
    p names
    ```

    > On `lines 1-3` we define the method `add_name` which takes two parameters, `arr` and `name`. 
    >
    > On `line 5` we initialize the local variable `names` and assign it to an array object with two string elements, `['bob', 'kim']`.
    >
    > On `line 6` we invoke the `add_name` method and pass `names` in as the first argument, and the string `'jim'` as the second argument. 
    >
    > Within the method, the `arr` variable is binded to the same object that `names` is referencing, so they both reference the same object and the `name` variable is binded to the string `'jim'`. `arr` is then reassigned to the output of `arr << name`, because the `<<` method mutates the caller, the object both `arr` and `names` is referencing is mutated by appending it with the `name` variable, which references `'jim'`. 
    >
    > The output and return of `line 8` is `['bob', 'kim', 'jim']` .
    >
    > This demonstrates mutation in Ruby. Specifically that actions within a method that mutate the argument will modify the object of the argument outside of the method definition. 

34. ```ruby
    array = [1, 2, 3, 4, 5]
    
    array.select do |num|
      puts num if num.odd?
    end
    ```

    > On `line 1` we initialize the local variable `array` and assign it to an array object with five integer elements. 
    >
    > On `lines 3-5` we invoke the `select` method on the `array` variable and pass in a `do..end` block with one parameter, `num`. Within the block we assign `num` to a consecutive element with each iteration.  On `line 4` we use a conditional `if` statement to evaluate if the current element, referenced by `num`, is odd. We then call the puts method and pass this boolean evaluation in as an argument. Because `puts` evaluates to `nil`, the select method will return `[]` and the output will be `1, 3, 5` .
    >
    > This demonstrates how the `select` method work in Ruby, specifically that it returns the block to a new array only if the block evaluates to `true`. Since `puts` always evaluates to `nil`, the method will return an empty array.

35. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    arr.select { |n| n.odd? }
    ```

    > On `line 1` we are initializing the local variable `arr` and assigning it to an array object with 10 integers as the elements.
    >
    > On `line 3` we are invokign the `select` method on the `arr` variable, and passing in a `{}` block as an argument with one parameter, `n`. 
    >
    > Inside of the block, `n` is referencing an individual element from the array consecutively, with each iteration. The `odd?` method is called on `n` for each element to test if `n` is an odd integer, which returns a boolean value. The `select` method creates a new array and each time the block evaluates to `true`, it moves the current element to the new array.
    >
    > The output will be `[1, 3, 5, 7, 9]`.
    >
    > This demonstrates how the `select` method block works in Ruby. Specifically that it selects the current element if the block evaluates to `true` and puts all of the selected elements into a new collection.

36. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    new_array = arr.select do |n|
      n + 1
    end
    
    p new_array
    ```

    > On `line 1` we initialize the local variable `arr` to an array object with 10 integer elements. 
    >
    > On `line 3` we initilize the local variable `new_array` to the return of calling the `select` method on the value of `arr`, where we pass a `do..end` block as an argument which has one parameter, `n`. Each element gets assigned to the local variable `n` by turn. 
    >
    > Within the method on `line 4`, we add integer `1` to the value of `n`. Because the `select` method selects elements based on the truthiness of the block, `n + 1` will always evaluate to `true`, so every element of the array will be selected and returned as a new array.
    >
    > The output and return of `line 7` is a array with the same elements as the elements in `arr`. 
    >
    > This is an example of how the `select` method works in Ruby, specifically that it only selects elements when last expression of the block evaluates to `true`. 

37. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    new_array = arr.select do |n|
      n + 1
      puts n
    end
    
    p new_array
    ```

    > On `line 1` we initilaize the local variable `arr` and assign it to an array object with 10 elements. 
    >
    > On `lines 3-6` we initialize the local variable `new_array` and assign it to the return of the `select` method called on the variable `arr` which passes in a `do..end` block as an argument with one parameter, `n`. 
    >
    > Within the block, the variable `n` references each element of the array in order of index number. On `line 4` we add the integer `1` to each element of the array without reassigning it, this returns a new integer. Then on `line 5` we call the `puts` method and pass in each element of the array. This outputs the each element, but because it returns `nil` and the select method evaluates the return of the last expression in the block, the method does not select anything.
    >
    > On `line 8` the output and return is `[]`.
    >
    > This demonstrates how the select method works in Ruby, specifically that select evalutates the return of a block and only selects elements when the block evaluates to `true`. 

38. ```ruby
    words = %w(jump trip laugh run talk)
    
    new_array = words.map do |word|
      word.start_with?("t")
    end
    
    p new_array
    ```

    > On `line 1` we initialize the local variable `words` and assign it to an array containing five string elements. 
    >
    > On `lines 3-5`, we initialize the loca variable `new_array` and assign it to the return of invoking the `map` method on the variable `words` while passing in a `do..end` block with one paramenter, `word`. 
    >
    > Within the method, the method definition scoped variable `word` is assigned to the current element of the iteration. On `line 4` the `start_with?` method is called on the current element which is referenced by the variable `word` and passes in the string `'t'` as an argument. The method `start_with` checks the caller if it starts with whatever argument was passed, in this case `'t'`  Because this returns a boolean value, the return of the `map` method invocation will be an array with the same number of elements but containing boolean values assigned to `new_array`.
    >
    > The output and return of `line 7` is `[false, true, false, false, true]` 
    >
    > This is an example of how the `map` method words in ruby, specifically that it returns a new collection containing the returned values of the blocks.

39. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    arr.each { |n| puts n }
    ```

    > On `line 1` we initailize the local variable `arr` and assing it to an array with ten integer elements. 
    >
    > On `line 3` we invoke the `each` method on the variable `arr` and pass in a `{}` block which has one parameter, `n`. Within the block, we invoke the `puts` method and pass in the variable `n`, which references the current element of the array. This block outputs the current element as a `string`, and returns `nil`. 
    >
    > The output of `line 3` is `1, 2, 3, 4, 5, 6 7, 8, 9, 10` and the return is the original array, `arr`. 
    >
    > This demonstrates how the `each` method functions in `ruby`, specifically that it is strictly iterative and returns the same collection it was called on. 

40. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    incremented = arr.map do |n|
                  n + 1
                end
    
    p incremented
    ```

    > On `line 1` we inititlize the local variable `arr` to the an array with 10 integer elements. 
    >
    > On `line 3` we initialize the local variable `incremeneted` to the return of calling the `map` method on the value of `arr`, and passing in a `do/end` block which is defined on `line 3-5`. The block has one parameter `n`. By turn, each element of the array is passed into the block as an argument and assigned to the local variable `n` .
    >
    > Within the block on `line 4`, we take the value of `n` and add it to integer `1`. Because the `map` method fills a new array with the return of the block, the variable `incremented` gets assigned to this array.
    >
    > The output and return of `line 7` is `[2, 3, 4, 5, 6, 7, 8, 9, 10, 11]`.
    >
    > This is an example of the `map` method in Ruby, specificlaly that it fills a new collection with the returned value of the block for each iteration. 

41. ```ruby
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    new_array = arr.map do |n|
      n > 1
    end
    
    p new_array
    ```

    > On `line 1 ` we initialize the local variable `arr` and assign it to an array object with ten integer elements. 
    >
    > On `lines 3-5` we initilaize the local variable `new_arr` and assign it to the return of calling the `map` method on variable `arr` and passing in a `do..end` block as an argument, with one parameter, `n`. 
    >
    > Inside the block, the current element of the iteration is passed into the block as an argument, referenced by method definition scoped variable `n`. 
    >
    > On `line 4` we compare the current element of the variable `arr` with integer `1` and return a boolean value. The `map` method creates a collection of blocks return and assigns the variable `new_array` to it.
    >
    > On `line 7` the output and return is `[false, true, true, true, true, true, true, true, true]`
    >
    > This demonstrates the `map` method in Ruby, specifically that the method returns a new collection of values evaluated by the last expression of the block. 

42. ```ruby
    a = "hello"
    
    [1, 2, 3].map { |num| a }
    ```

    > On `line 1` we initialize the local variable `a` and assign it to the string, `hello`. 
    >
    > On `line 3` we invoke the `map` method on the array, `[1, 2, 3]` and pass in a `{}` block with one parameter, `num`. Within the block we evaluate the variable `a` which always evalues to the `'hello'`, so the method returns a new array with `'hello'` as each element.
    >
    > This outputs and returns `['hello', 'hello', 'hello']`
    >
    > This demonstrates the how the `map` method works in Ruby, specifically that the method fills a new collection with the value of the last evaluated expression of the block. 

    

43. ```ruby
    [1, 2, 3].each do |num|
      puts num
    end
    ```

    > On `lines 1-3`, we call the `each` method on the array `[1, 2, 3]` and pass in a `do..end` block which takes one argument, `num`. 
    >
    > Inside the block on `line 2`, each element of the array is passed into the block as an argument referenced by `num`. We invoke the `puts` method and pass the variable `num` in as an argument, without outputs the current element and returns nil`.
    >
    > The output is `1 2 3` and the return is `[1, 2, 3]`
    >
    > This demonstrates how the `each` method works in Ruby, specifically that it returns the original collection it was called on. 

44. ```ruby
    [1, 2, 3].any? do |num|
      num > 2
    end
    ```

    > On `line 1` we call the `any?` method on the array `[1, 2, 3]`, and pass in a `do..end` block as an argument with one parameter, `num`. By turn, each element is passed into the block as an argument and assigned to the local variable `num`. 
    >
    > On `line 2`, we compare the value of `num` with the integer `2`, evaluating to `true` if the value of `num` is greater than `2`. 
    >
    > If any of the iterations of the block evaluate to `true`, then the method itself will return `true.` Since one of the elements, `3`, is greaten than `2`, the code will return `true`.
    >
    > This is an example of the `any?` method in Ruby, specifically that evaluates the truthiness of the blocks return value.

45. ```ruby
    { a: "ant", b: "bear", c: "cat"}.any? do |key, value|
      value.size > 4
    end
    ```

    > On `lines 1-3` we call the `any?` method on a hash that contains three keys and three values,  which passes in a `do..end` block that has two parameters, `key` and `value`. The keys of the hash are passed into the block as an argument and referenced by the variable `key`, and the values are passed in as the second argument and referenced by the variable `value`. 
    >
    > On `line 2` we call the `size` method on the variable `value` which returns an integer of number of characters in the string. We then compare this integer to the integer `4` and return a boolean value. 
    >
    > Because the method `any?` checks if any of the blocks are truthy, it returns `false` since none of the values in the hash have more than 4 characters. 
    >
    > This is an example of calling a collection's method on a hash in Ruby, specifically that a method that is called on a hash should use two arguments, one representing the keys of the hash and one repsresenting the values. 

46. ```ruby
    [1, 2, 3].all? do |num|
      num > 2
    end
    ```

    > On `lines 1-3`, the `all?`  method is called on the array `[1, 2, 3]` , and passes in a `do..end` block with one parameter, `num`. Within the block, each element of the array is referenced by the variable `num`, which is scoped at the method definition level.
    >
    > On `line 2`, each element of the array is compared to the integer `4`. Because the `all?` method requires every block to evaluate to `true`, when the block compares the first element `1` to the integer `2`, the block will return `false` since `1` is less than `2`. This means the method `all?`  will return `false`.
    >
    > This demonstrates how the `all?` method works in Ruby, specifically that every block needs to return `true` for the method to `return` true.

47. ```ruby
    { a: "ant", b: "bear", c: "cat"}.all? do |key, value|
      value.length >= 3
    end
    ```

    > On `lines 1-3` the `all?` method is called on a hash, and passes in a  `do..end` block with two parameters, `key`, and `value`. 
    >
    > Within the block, each `key` of the hash is referenced by the variable `key` and each value of the hash is referenced by `value`. 
    >
    > On `line 2` we call the `length` method on the current value of the hash, which returns an integer reprsenting the number of characters in the string. We then compare this integer to the integer `3`, and only return `true` if `value.length` returns an integer of `3` or greater. Because `all?`requires every block to return `true` for the method to return `true`, the method invocation on the hash returns `true` since every value in the hash has a string with a number of characters greater than or equal to `3`. 
    >
    > This is an example of how the `all?` method works in Ruby, specifically that it only returns `true` if every block returns `true`. 

48. ```ruby
    [1, 2, 3].each_with_index do |num, index|
      puts "The index of #{num} is #{index}."
    end
    ```

    > On `line 1` we call the `each_with_index` method on the array `[1, 2, 3]` and pass in a `do..end` block as an argument which has two parameters, `num` and `index`. By turn, we pass in each element into the block as an argument where it is assigned to the local variable `num`. 
    >
    > Inside the block on `line 2`, we invoke the `puts` method and pass in a string which uses string interpolation as an argument. Since the variable `num` references the current element, and `index` references the current index of the element, this code outputs the string three times with the respective element and index, and returns the original array.
    >
    > This is an example of the `each_with_index` method in Ruby, specifically that it can pass two arguments with one being the element of an array, and the second being the respective index of the current element.

49. ```ruby
    { a: "ant", b: "bear", c: "cat"}.each_with_object([]) do |pair, array|
      array << pair.last
    end
    ```

    > On `lines 1-3` we call the `each_with_object()` method on a hash, and pass in a an empty array object, and a `do..end` block with two paraments, `pair`, and `array`. Each key/value pair of the hash is referenced by the `pair` variable, and the empty array is referenced by the `array` variable.
    >
    > On `line 2` we call the `<<` method on variable `array` and pass in the output of calling the `last` method on variable `pair`. Because the `pair` variable references the key/value pairs as an array, the `last` method returns the last element of the array. The `array` method is mutated and adds the value of every pair to the collection.
    >
    > Because `each_with_object()` returns the object, the output and return is `['ant', 'bear', 'cat']`
    >
    > This demonstrates how the `each_with_object` method words in Ruby, specifically that when have one parameter for referencing the hash, this returns the key/value pair in the form of an array.

50. ```ruby
    { a: "ant", b: "bear", c: "cat"}.each_with_object({}) do |(key, value), hash|
      hash[value] = key
    end
    ```

    > On `line 1-3`, we call the `each_with_object` method on a hash, and pass in an empty hash as an argument, as well as a `do..end` block that has three parameters, `key`, `value`, and `hash`. The keys of the hash are assigned to the local variable `key`, the values of the hash are assigned to the local variable `value`,  and the new hash object is assigned to the local variable `hash`.
    >
    > Within the method on `line 2`. the use the `hash[]` method to create key/value pairs in the new hash. In this case, the key/values of the original hash are swapped. 
    >
    > This outputs to `'ant' => :a, 'bear' => :b, 'cat' => :c`
    >
    > This demonstrates the `each_with_object` method in ruby, specifically that within the method we can modify a collection passed into the method as an argument, and it returns the collection.

51. ```ruby
    odd, even = [1, 2, 3].partition do |num|
      num.odd?
    end
    
    p odd
    p even
    ```

    > On `line 1` we initialize two local variables, `odd` and `even` and parallel assign them to the return of the `partition` method call on the array object with three integers as elements. 
    >
    > We pass in a `do..end` block as an argument for the `partition` method, which has one parameter, `num`. 
    >
    > Inside the block, the local variable `num` is assigned to the current element of the iteration. On `line 2`, we call the `#odd?` method on the variable `num` to test if the value is an odd integer. This returns a boolean.
    >
    > On `line 5` we call the `p` method and pass in the variable `odd` as an argument, which returns `[1, 3]`. 
    >
    > On `line 6`, we call the `p` method and pass in the variable `even` as an argument, which returns `[2]`. 
    >
    > This demonstrates how the `#partition` method works in ruby alongside parallel assignment, specifically parition assigns the selected elements to the respective variable.

52. ```ruby
    a = "Hello"
    
    if a
      puts "Hello is truthy"
    else
      puts "Hello is falsey"
    end
    ```

    > On `line 1 ` we initialize the variable `a` and assign it to the string, `"hello"`. 
    >
    > On `line 3- 7` we have  a conditional `if..else` statement, where we check what variabel `a` evaulates to. 
    >
    > Because variable `a` is a string object with the value `Hello`, it is truthy and therefore evaluates to `true`. Therefore, the expression on `line 4` will always be returned. 

53. ```ruby
    def test
      puts "written assessment"
    end
    
    var = test
    
    if var
      puts "written assessment"
    else
      puts "interview"
    end
    ```

    > On `line 5` we initialize the local variable `var` and assign it to the return of the `test` method invocation. 
    >
    > On `lines 1-3` we define the method `test` . Within the method, we call `puts`  and pass in the string `'written assessment'` as an argument, which outputs `written assessment`, but returns `nil`. This means that on `line 5`, the variable `var` is assigned to the object, `nil`. 
    >
    > On `lines 7-11` we use a conditional `if..else` statement, and check if the variable `var` is truthy. Because `var` is assigned to `nil`, this is falsy and therefore the expression on `line 10` is output, which is `interview` and returns `nil`. 

54. ```ruby
    ['cot', 'bed', 'mat'].sort_by do |word|
      word[1]
    end
    ```

    > On `line 1` we call the `sort_by` method on the array, where we pass a `do..end` block as an argument with one parameter, `word`. By turn, each element of the array is passed into the block as an argument, and assigned to the local variable `word`, so `word` references the current element. 
    >
    > On `line 2` we call the `String#[]` method on the object `word` is pointing to, and pass in integer `1` as an argument. This returns the second character of each string, which is what `sort_by` uses as a comparison. 
    >
    > The code outputs a new array with the elements sorted in the order of their second characters. 
    >
    > This is an example of the `sort_by` method in Ruby, specifically how it sorts the elements of a collection by using the return of the block. 

55. 



