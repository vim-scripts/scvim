


Understanding Streams, Patterns and Events - Part 7

Practical Considerations

Using your own ~instrument

(
SynthDef("Help-SPE7-BerlinB", { arg i_out=0, freq = 80, amp = 0.2, pan=0;
	var out, a, b;
	amp = Decay2.kr(Impulse.kr(0), 0.05, 8, amp);
	out = RLPF.ar(
		LFPulse.ar(freq, 0, SinOsc.kr(0.12,[0,0.5pi],0.48,0.5), amp),
		freq * SinOsc.kr(0.21,0,4,8),
		0.07
	);
	#a, b = out;
	DetectSilence.ar(a, 0.0001, doneAction: 2);
	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+1])));
}).store;

SynthDef("Help-SPE7-CFString1", { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
	var out, eg, fc, osc, a, b, w;
	fc = LinExp.kr(LFNoise1.kr(Rand(0.25,0.4)), -1,1,500,2000);
	osc = Mix.fill(8, { LFSaw.ar(freq * [Rand(0.99,1.01),Rand(0.99,1.01)], 0, amp) }).distort * 0.2;
	eg = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	out = eg * RLPF.ar(osc, fc, 0.1);
	#a, b = out;
	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).store;
)

Pattern-play creates an EventStreamPlayer for you and also supplies a default
protoEvent. If you were using your own event model you would just pass in your own
protoEvent to the play method.

(
Pbind(
	\instrument, Prand(['Help-SPE7-BerlinB','Help-SPE7-CFString1'],inf),
	\degree, Pseq([0,1,2,4,6,3,4,8],inf),
	\dur, 0.8,
	\octave, 3, 
	\amp, 0.03
).play; // this returns an EventStreamPlayer
)

Defining your own message bindings

NotePlayer uses a message function to compile it's message for the server, and no longer
does a valueEnvir like in SC2, but instead calls 'use' on the event, and then fills a message with
bindings which you need to specify. You can't just automatically add your own bindings to a Pbind
and expect them to be passed on to the server. Here's an example:

(
SynthDef("Help-SPE4-CFString2", { arg i_out, freq = 360, gate = 1, pan, amp=0.1, dorkarg=1;
	var out, eg, fc, osc, a, b, w;
	fc = LinExp.kr(LFNoise1.kr(Rand(0.25,0.4)), -1,1,500,2000);
	osc = Mix.fill(8, { LFSaw.ar(freq * [Rand(0.99,1.01),Rand(0.99,1.01)], 0, amp * dorkarg ) }).distort * 0.2;
	eg = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	out = eg * RLPF.ar(osc, fc, 0.1);
	#a, b = out;
	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).send(s);
)

As you can see I have added dorkarg to the arglist of the SynthDef from earlier.

(
Pbind(
	\instrument, "Help-SPE4-CFString2",
	\degree, Pseq([0,1,2,4,6,3,4,8],inf),
	\dur, 0.4,
	\octave, 3, 
	\amp, 0.03,
	\dorkarg, Pseq([1,0,1],inf) // silence every second note - doesn't work
).play;
)

Surprisingly \dorkarg has not been defined by the default \msgFunc, so we have to
supply a \msgFunc which does.

(
Pbind(
	\instrument, "Help-SPE4-CFString2",
	\degree, Pseq([0,1,2,4,6,3,4,8],inf),
	\dur, 0.4,
	\octave, 3, 
	\amp, 0.03,
	\dorkarg, Pseq([1,0,1],inf), // silence every second note - now works
	\msgFunc, { arg id, freq;
		[[
			9, ~instrument, id, 0, ~group,
			\out, ~out, \freq, freq, \amp, ~amp, \pan, ~pan, \vol, ~vol, \dorkarg, ~dorkarg
		]];
	}
).play;
)

This is quite clumsy and with some luck (read: work) will not always be the case so keep your eyes
open for changes.

The other option you have if you will be using unspecified bindings, is of course to define an event
with the appropriate msgFunc as default. Have a look at Event's source, it's easy, and it's cleaner than
passing in the msgFunc every time.

Manipulating an EventStreamPlayer in Realtime

(
p = Pbind(
	\degree, Pwhite(0,12),
	\dur, 0.2,
	\instrument, "Help-SPE4-CFString1"
);
// e is an EventStreamPlayer
e = p.play;
)

(
// you can change the stream at any point in time
e.stream = Pbind(
	\degree, Pseq([0,1,2,4,6,3,4,8],inf),
	\dur, Prand([0.2,0.4,0.8],inf),
	\amp, 0.05,
	\octave, 5,
	\instrument, 'Help-SPE4-BerlinB', // you can also use a symbol
	\ctranspose, 0
).asStream;
)

(
e.stream = Pbind(
	[\degree, \dur], Pseq(
		[
			Pseq([[0,0.1],[2,0.1],[3,0.1],[4,0.1],[5,0.8]],2),
			Ptuple([Pxrand([6,7,8,9],4), 0.4]),
			Ptuple([Pseq([9,8,7,6,5,4,3,2]), 0.2])
		], inf
	),
	\amp, 0.05,
	\octave, 5,
	\instrument, "Help-SPE4-CFString1"
).asStream;
)

The following methods are possible because an EventStreamPlayer is a PauseStream:

e.mute; // keeps playing, but replaces notes with rests

e.unmute;

e.reset; // reset the stream.

e.pause; // will resume where paused.

e.resume;

e.stop; // will reset before resume.

e.resume;





