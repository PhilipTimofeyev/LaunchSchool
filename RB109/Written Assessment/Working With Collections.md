## **Arrays**



**An array is an ordered list of elements that can be of any type.**

```ruby
arr = []
arr = Array.new
```

> Defined using these methods.



```ruby
arr = [1, 2, 3]
arr[1] # => 2
arr.first # => 1
arr.last # => 2

# Retrieving index
arr.index(3) # => 2
```

> Accessing elements in an array and index.



**Modifying Arrays**

```ruby
arr = [1, 2, 2, 3]

arr.pop # => 3. Returns the last element, mutates the caller and modifies the array by removing the last element.
arr.shift # Same as pop but removes the first element.
arr.push(4, 5) # => [1, 2, 2, 3, 4, 5]. Mutates the caller by adding the argument to the end of the array, returning the modifed arr.
arr.unshift(4, 5) # Same as push but adds to beginning of array instead of end.
arr << 4 # => [1, 2, 2, 3, 4] Mutates the caller by adding the element to the end of the array.
arr[2] = 9 # => [1, 2, 9, 3]. Destructive
arr.delete_at(3) # => 2. Mutates the caller by removing the element at the index of the argument. Returns the deleted element.
arr.delete(2) # => 2. Removes all instances of the provided value. Destructive.
arr.uniq # => [1, 2, 3]. Deletes any duplicate values that exist. Returns the result as a new array. Non-destructive unless ! added.
```



**Comparing Arrays**

```ruby
a = [1, 2, 3]
b = [1, 2, 3, 4]

a == b # => false

b.pop
a == b # => true
```



**Common Array Methods**

```ruby
arr = [1, 2, 3]
arr.include?(3) # => true

arr = [1, 2, [3, 4]]
arr.flatten # => [1, 2, 3, 4] Non-destructive. 

arr_a = [1, 2]
arr_b = [3, 4]
arr_a.product(arr_b) # => [[1, 3] [1, 4], [2, 3], [2, 4]]
```

> *Methods that have a question mark at the end, usually mean to return a boolean value, true or false. These are called predicates.*



## **Hashes**



**A data structure that stores items by  associated keys.**

> There are two syntaxes for creating hashes.

```ruby
hsh = Hash.new
hsh = {}

old_hsh = {:name => 'bob'}
new_hsh = {name: 'bob'}
```



**Modifying a hash**

```ruby
# Add key/value pair
person = { height: '6 ft', weight: '160 lbs' }
person[:hair] = 'brown'

# Delete 
person.delete(:age) #returns the removed value

# Merging two hashes
person.merge!(new_hash) # Destructive with bang(!)

```



**Common Hash Methods**

```ruby
#HAS_KEY?
h = { "a" => 100, "b" => 200 }
h.has_key?("a")   #=> true

#FETCH
h = { "a" => 100, "b" => 200 }
h.fetch("a")                            #=> 100
h.fetch("z", "go fish")                 #=> "go fish"
```



*As of Ruby 1.9, hashes maintain the order in which they are stored. *



## **Hashes vs. Array**

**Which to use?**

| Does the data need to be associated with a specific lable? | If yes, use hash.  |
| ---------------------------------------------------------- | ------------------ |
| Does order matter?                                         | If yes, use array. |
| Do I need a "stack" or "queue" structure?                  | If yes, use array. |

