BinaryOpStream

Superclass: Stream

A BinaryOpStream is created as a result of a binary math operation on a pair
of Streams. It is defined to respond to next by returning the result of the math operation
on the next value from both streams. It responds to reset by resetting both Streams.

(FuncStream.new({ 9.rand }) + 100).dump

(
x = (FuncStream.new({ 9.rand }) + 100);
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
)

