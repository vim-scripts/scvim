
Symbol

superclass: Object

A Symbol is a name that is guaranteed to be unique. They can be used to represent
symbolic constant values, Dictionary keys, etc.

Symbols are represented syntactically as literals which are described in [01 Literals] .

Testing

isClassName

Answer whether the symbol is a class name.

isSetter

Answer whether the symbol has a trailing underscore.

Conversion

asString

Convert to a String

asClass

Answer the Class named by the receiver.

asSetter

Return a symbol with a trailing underscore added.

asGetter

Return a symbol with a trailing underscore removed.

Math

Symbols respond to all unary and binary math operations by returning themselves.
The result of any math operation between a Number or other math object and a Symbol
is to return the Symbol. This allows operations on lists of notes which contain 'rest's
to preserve the rests.



