bob = Person.new
bob.hi

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'


# This shows that the method 'hi' is private and cannot be called outside of the class. The way to fix it is to make the method public by putting it above private.