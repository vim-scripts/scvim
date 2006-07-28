Pswitch1 


Pswitch1(list, which)

the elements in the list are collected as streams,
the stream of indices (which) is used to in turn select
one of the elements. one value only is yielded from that stream.

this is different than Pswitch which embeds the element in the stream,
allowing it to play out until it is finished. Pswitch1 switches every event.

(
var a, b;
a = Pseq(#[1, 2, 3], inf);
b = Pseq(#[65, 76], inf);
c = Pswitch1([a, b, 800], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
24.do({ x.next.postln; });
)


Pswitch used as a sequence of pitches:


(
SynthDef("help-sinegrain", 
 { arg out=0, freq=440, sustain=0.05;
 var env;
 env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).send(s);
)



(
a = Pseq(#[73, 71, 69], inf);
b = Pseq(#[0, 0, 0, 4, 0]+64, inf);
c = Pswitch1([a, b, 75], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
Routine({
 loop({
 Synth("help-sinegrain", [\freq, x.next.midicps]);
 0.18.wait;
 })
}).play;
)


