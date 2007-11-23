
UnaryOpUGen

superclass: UGen

UnaryOpUGens are created as the result of a unary operator applied to a UGen.

Examples

SinOsc.ar(300).abs.dump;

{ SinOsc.ar(300).abs }.plot



