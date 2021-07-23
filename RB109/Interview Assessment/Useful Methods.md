

## **STRINGS**

```ruby
#CASECMP?
"aBcDeF".casecmp?("abcde")     #=> false
"aBcDeF".casecmp?("abcdef")    #=> true

#SCAN
a = "cruel world"
a.scan(/\w+/)        #=> ["cruel", "world"]
a.scan(/.../)        #=> ["cru", "el ", "wor"]

#TR
"hello".tr('el', 'ip')      #=> "hippo"
"hello".tr('aeiou', '*')    #=> "h*ll*"

#SQUEEZE
"yellow moon".squeeze                  #=> "yelow mon"
"  now   is  the".squeeze(" ")         #=> " now is the"

#SUCC
'1'.succ				#=>  '2'
```



## **NUMBERS**

```ruby
11.divmod(3)        #=> [3, 2]
```



## **ARRAYS**

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



**Useful Array Methods**

```ruby
#INCLUDE
arr = [1, 2, 3]
arr.include?(3) # => true

#FLATTEN
arr = [1, 2, [3, 4]]
arr.flatten # => [1, 2, 3, 4] Non-destructive. 

#PRODUCT
arr_a = [1, 2]
arr_b = [3, 4]
arr_a.product(arr_b) # => [[1, 3] [1, 4], [2, 3], [2, 4]]

#KEEP_IF
a = %w{ a b c d e f }
a.keep_if { |v| v =~ /[aeiou]/ }  #=> ["a", "e"]

#GREP
(1..100).grep 38..44   #=> [38, 39, 40, 41, 42, 43, 44]

#PARTITION
(1..6).partition { |v| v.even? }  #=> [[2, 4, 6], [1, 3, 5]]

#EACH_CONS
(1..10).each_cons(3) { |a| p a }
```

> *Methods that have a question mark at the end, usually mean to return a boolean value, true or false. These are called predicates.*



## **HASHES**

```ruby
#ASSOC
h = {"colors"  => ["red", "blue", "green"],"letters" => ["a", "b", "c" ]}
h.assoc("letters")  #=> ["letters", ["a", "b", "c"]]


```







