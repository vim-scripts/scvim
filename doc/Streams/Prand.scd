Prand 

superclass: ListPatterns

returns one item from the list at random for each repeat. 

(
var a, b;
a = Prand.new(#[1, 2, 3, 4, 5], 6); // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)

Prand used as a sequence of pitches:

(
SynthDef("help-sinegrain", 
 { arg out=0, freq=440, sustain=0.05;
 var env;
 env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).send(s);
)

(
a = Prand(#[60, 61, 63, 65, 72], inf).asStream;
Routine({
 loop({
 Synth("help-sinegrain", [\freq, a.next.midicps]);
 0.2.wait;
 })
}).play;
)

