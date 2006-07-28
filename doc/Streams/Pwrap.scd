Pwrap

superclass: FilterPattern

Pwrap(pattern,lo,hi)


(
SynthDef("help-sinegrain", 
 { arg out=0, freq=440, sustain=0.05;
 var env;
 env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).send(s);
)

(
a = Pn(
 Pwrap(
 Pgeom(200,1.07,96),
 200,
 1000.0
 ),
 inf
);
x = a.asStream;

Routine({
 loop({
 Synth("help-sinegrain", [\freq, x.next.debug,\dur,0.3]);
 0.12.wait;
 })
}).play;

)



-felix