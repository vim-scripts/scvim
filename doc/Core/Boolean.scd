Boolean

superclass: Object

Boolean is an abstract class whose instances represent a logical value. 
Boolean is the superclass of True and False which are the concrete realizations.

xor(aBoolean)

Answers the exclusive or of the receiver and another Boolean.

and(function)
and: function

If the receiver is true then answer the evaluation of function.
If the receiver is false then function is not evaluated and the message answers false.

or(function)
or: function

If the receiver is false then answer the evaluation of function.
If the receiver is true then function is not evaluated and the message answers true.

&& aBoolean

Answers true if the receiver is true and aBoolean is true.

|| aBoolean

Answers true if either the receiver is true or aBoolean is true.

not

Answers true if the receiver is false, and false if the receiver is true.

if( trueFunc, falseFunc )

If the receiver is true, answer the evaluation of the trueFunc. If the receiver is false, answer the evaluation of the falseFunc.

binaryValue

Answer 1 if the receiver is true, and 0 if the receiver is false.

