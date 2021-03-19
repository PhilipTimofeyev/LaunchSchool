name = 'Bob'
save_name = name
name.upcase!
puts name, save_name

#prints BOB, BOB because upcase is destructive. Name now points to BOB, and since save_name pointed to bob, but bob was changed to BOB, save_name also points to BOB.