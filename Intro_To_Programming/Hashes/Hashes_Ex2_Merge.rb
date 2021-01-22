#merge is nondestructive and returns a new hash.
#merge! is destructive and overwrites hsh.

h1 = {green: 1, blue: 2, red: 3}
h2 = {yellow: 4, blue: 5, pink: 7}

p h1.merge(h2) 
p h1 #not mutated

p h1.merge!(h2)
p h1 #mutated