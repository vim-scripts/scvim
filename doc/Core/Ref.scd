
Ref			a reference to a value
superclass: AbstractFunction

A Ref instance is an object with a single slot named 'value' that serves as a holder of
an object. Ref.new(object) one way to create a Ref, but there is a syntactic shortcut.
The backquote ` is a unary operator that is equivalent to calling Ref.new(something).

example: 

x = Ref.new(nil);
z = obj.method(x);		// method puts something in reference
x.value.doSomething;	// retrieve value and use it

Ref is also used as a quoting device to protect against multi channel expansion in certain UGens that require Arrays.

Class methods:

new(anObject)

create a Ref of an object.

`anObject

create a Ref of an object.

Instance methods:

value

Answer the value.

value_(aValue)

set the value.

get

Answer the value.

set(aValue)

set the value.

dereference

Answer the value. This message is also defined in class Object where it just returns the receiver. Therefore anything.dereference will remove a Ref if there is one. This is slightly different than the value message, because value will also cause functions to evaluate themselves whereas dereference will not.

asRef

Answers the receiver. In class Object this message is defined to create a Ref of the object.



