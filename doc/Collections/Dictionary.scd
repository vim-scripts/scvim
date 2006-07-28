Dictionary

Superclass: Set

A Dictionary is an associative collection mapping keys to values.
Two keys match if they are equal. i.e. == returns true.

The contents of a Dictionary are unordered. 
You must not depend on the order of items in a Dictionary.


Creation:

*new(n)

Creates a Dictionary with an initial capacity for n key value mappings.

Adding and Removing:

add(anAssociation)

Add anAssociation to the Dictionary. 
If the key value pair already exists in the Dictionary, the key's value will be replaced.

(
d = Dictionary.new;
d.add('monkey' -> 0).postln;
// Add robot as a key with a value of 1
d.add('robot' -> 1).postln;
// Replaces the value for the key monkey with 2
d.add('monkey' -> 2).postln;
)

put(key, obj)

Associate two objects and add them to the Dictionary.
key - key to associate with object
obj  - an object

d.put("abc", 10).postln;

removeAt(key)

Remove the key and the value associated with it from the Dictionary.

d.removeAt('monkey').postln;

Accessing:

at(key)

Access the value associated with the key.

// Get the value associated with key
d.at('robot');
// Key doesn't exist
d.at('monkey');

matchAt(item)

The dictionary's keys are used as conditions against which the arbitrary item is matched. 

Note: if an item matches multiple criteria, the value returned is arbitrary. This is because a dictionary is an unordered collection. It's the user's responsibility to make sure that criteria are mutually exclusive.

If the key is an object, the item will be matched by identity (if key === item, the value will be returned). 
If the key is a collection, the item is matched if it's contained in the collection. 
If the key is a function, the function is evaluated with the item as an argument and the item is matched if the function returns true.

d = Dictionary[
 0 -> 'zero',
 'abc' -> 'alpha',
 [1, 2, 3, 5, 8, 13, 21] -> 'fibonacci',
 { |x| x.even } -> 'even'
];

d.matchAt(0)
d.matchAt(1)
d.matchAt(2) // matches both 'fibonacci' and 'even', but 'fibonacci' is returned
d.matchAt(4)
d.matchAt('abc')
