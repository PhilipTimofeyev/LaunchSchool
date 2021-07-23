## **Variables as Pointers**



**Variables act as pointers to a specific address space in memory.**

```ruby
a = "hi there"
b = a
a = "not here"
```

> Here, the variable `a` is initialized and assigned to the string, `"hi there"`. The variable `a` now points to a specific physical space in memory containing the string, `"hi there"`. When variable `b` gets initialized and assigned to variable `a`, it does not point to variable `a`, but points to the same physical space in memory as `a`, which is the string `"hi there"`. Both variables `a` and `b` now point to the same address space. When `a` is reassigned to the string `"not here"`, `a` now points to a new address space containing string `"not here"` while `b` continues to point to the original address space containing the string `"hi there"`. 

<img src="https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers1.jpg" alt="Variables as Pointers 1" style="zoom:33%;" />

**Difference memory space can hold the same value, but they are still different places in memory.**

> If the second `a =` were to be `a = 'hi there'`, `a` and `b` would be pointing to two different places in memory containing the same string.



**Some operations mutate the address space in memory, but others simply change the variable to point to a different address space.**

```ruby
a = "hi there"
b = a
a << ", Bob"
```

> Here, the `<<` mutates the caller `a` and therefore modifies the existing string, which variable `b` also points to. This is why both `a` and `b` are `'hi there, Bob'`.

<img src="https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers2.jpg" alt="Variables as Pointers 2" style="zoom: 33%;" />



**This applies to variables that poiint to arrays, hashes, or any data structure that has methods that mutate the caller. If a method mutates the caller, it will change the value in that address space, and any variable pointing to the space will be affected.**



