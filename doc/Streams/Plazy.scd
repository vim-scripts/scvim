Plazy

superclass: Pattern


evaluates a function that returns a pattern and embeds it in a stream.

Plazy(func)


 
(
a = Plazy({ 
 var x, y;
 x = Array.series(rrand(2, 4), [1, 100].choose, 1);
 Pshuf(x,1);
});
x = Pn(a, inf).asStream;
30.do({ x.next.postln });
)


Plazy used to produce a sequence of pitches:
 
(
SynthDef("help-sinegrain", 
 { arg out=0, freq=440, sustain=0.05;
 var env;
 env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).store;
)



(
a = Plazy({ 
 var x, y;
 x = Array.series(rrand(2, 4), [1, 5].choose, 1);
 x.put(x.size.rand, 8+0.1.rand2);
 Pseq(x,1);
});
x = Pn(a, inf).asStream;

Routine({
 loop({
 Synth("help-sinegrain", [\freq, (x.next*5+70).midicps]);
 0.13.wait;
 })
}).play;
)

// using event streams

(
a = Plazy({ 
 var x, y;
 x = Array.series(rrand(2, 4), [1, 5].choose, 1);
 x.put(x.size.rand, 8+0.1.rand2);
 Pbind(
 \instrument, 'help-sinegrain',
 \dur, 0.12,
 \degree, Pseq(x, 2)
 )
});

Pn(a, inf).play;
)





