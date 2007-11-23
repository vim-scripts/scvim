
Pgpar				embed event streams in parallel and put each in its own group

superclass: Ppar

Embeds several event streams so that they form a single output stream with all their events in temporal order.
When one stream ends, the other streams are further embedded until all have ended.

Pgpar(list, repeats)
			
			list:			list of patterns or streams
			repeats:		repeat the whole pattern n times (default: 1)


In order to fully separate these layers from other synths, use Pbus.




// synthdefs
(
SynthDef("gap", { arg out, sustain=1.0, attack=0.0001, decay=0.01, leak;
		var level;
		level = EnvGen.ar(Env.linen(attack, sustain, decay, 1-leak), doneAction:2);
		XOut.ar(out, level, Silent.ar ! 2)
}).store;

SynthDef("help_sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
}).store;
)


// play a layered pattern with gaps and overlays
(
x = Pbind(
		\instrument, \help_sinegrain,
		\degree, Pn(Plazy({ Prand([0, 4, 5], 16) + 5.rand })) + Prand(#[0, [0, 3], [0, 7]], inf),
		\dur, Prand([0.25, 0.5, 1.0], inf),
		\scale, #[0, 3, 5, 9, 10]
	);
y = Pbind(
		\instrument, \gap,
		\dur, Prand([0.25, 0.5, 1.0], inf) * 0.25,
		\legato, Prand([0.25, 0.5, 1.0], inf),
		\leak, 0.25
	);
a = Pgpar([x, y, x, y, x, y]);
a.play;
)



