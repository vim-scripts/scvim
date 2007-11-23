
Association

superclass: Magnitude

Associates a key with a value.
Associations can be created via the -> operator which is defined in class Object.

(
x = 'name' -> 100;
x.postln;
)


Accessing

<>key

the key object.

<>value

the value object.


Creation

*new(key, value)

Create an Association between two objects.
key - any object.
value - any object.


Testing

== anAssociation

Compare the keys of two Associations.

< anAssociation

Compare the keys of two Associations.

hash

Compute the hash value of the Association.


Streams

printOn(stream)

Write a string representation to the stream.

storeOn(stream)

Write a compileable string representation to the stream.



