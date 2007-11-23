
Pbind

superclass: Pattern

Pbind(pattern pairs)

The class Pbind provides a bridge between value patterns and event patterns. It binds symbols in each event to values obtained from a pattern. Pbind takes arguments in pairs, the first of a pair being a Symbol and the second being a value Pattern. Any object can act as a Pattern, so constants can be used as values.


The Pbind stream returns nil whenever the first one of its streams ends or if nil is passed in.

// example:

a = Pbind(\x, 77, \y, Pseq([1, 2, 3]));
x = a.asStream;
4.do { x.next(Event.new).postln };

a = Pbind(\x, 77, \y, Pseq([1, 2, 3]));
x = a.asStream;
x.next; // this returns nil.


An event stream is created for a Pattern by sending it the asEventStream message. The asEventStream message takes an Event as an argument. This event is copied for each call to next to pass down and back up the tree of patterns so that each pattern can modify the event. What Pbind does is put the values for its symbols into the event, possibly overwriting previous bindings to those symbols.

This uses the default event. In the next example we will supply our own event (synth function).

// example:
(
Pbind(
	\degree, Pseq([1,3,5,7], inf),
	\dur, 0.125,
	\octave, 4,
	\root, 3
).play
)


To use another than the default SynthDef, we need to read the synth description library so that event know's what kind of arguments there are in each SynthDef. Use .store or .memStore (instead of load or send) to create a Synth Description (SynthDesc). The difference between store and memStore is that store rights the synthdef file to disk so that the definition will be loaded automatically in the future. memStore makes the synthdef ready to use with event patterns, but does not write the file to disk.. See [SynthDef] help.

Special control name conventions which should be used so that the SynthDef works with the default system:

out		output bus index
gate		envelope gate (not level!) - should default to 1.0
amp		synth amplitude - should default to 0.1

The control names of the synth definition should match the keys. The default event scheme omplements a couple of useful parameter transformations in addition to that.

sustain	envelope duration (not dur!) - should default to 1.0. legato and dur values are translated to sustain
freq		some frequency input - often defaults to 440. degree, note and midinote values are translated to freq.
bufnum	buffer number
pan		panning position




(
SynthDef(\cfstring1, { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
	var out, eg, fc, osc, a, b, w;
	fc = LinExp.kr(LFNoise1.kr(Rand(0.25,0.4)), -1,1,500,2000);
	osc = Mix.fill(8, {LFSaw.ar(freq * [Rand(0.99,1.01),Rand(0.99,1.01)], 0, amp) }).distort * 0.2;
	eg = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	out = eg * RLPF.ar(osc, fc, 0.1);
	#a, b = out;
	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).store;
)


(
e = Pbind(
	\degree, Pwhite(0,12),
	\dur, 0.2,
	\instrument, \cfstring1
).play; // returns an EventStream
)

// the event stream's stream can be changed while it is running:

(
e.stream = Pbind(
			\degree, Pseq([0,1,2,4,6,3,4,8],inf),
			\dur, Prand([0.2,0.4,0.8],inf),
			\amp, 0.05, \octave, 5,
			\instrument, \cfstring1, \ctranspose, 0
).asStream;
)

(
e.stream = Pbind(
			\degree, Pseq([0,1,2,4,6,3,4,8],inf),
			\dur, Prand([0.2,0.4,0.8],inf),
			\amp, 0.05, \octave, 5,
			\instrument, \cfstring1, \ctranspose, 0
).asStream;
)

(
e.stream = Pbind(
			\degree, Pxrand([0,1,2,4,6,3,5,7,8],inf),
			\dur, Prand([0.2,0.4,0.8],inf), \amp, 0.05,
			\octave, 5, \instrument, \cfstring1
).asStream;
)

// pairs of names can be used to group several parameters

(
e.stream = Pbind(
	[\degree, \dur], Pseq([
			Pseq([[0,0.1],[2,0.1],[3,0.1],[4,0.1],[5,0.8]],2),
			Ptuple([Pxrand([6,7,8,9],4), 0.4]),
			Ptuple([Pseq([9,8,7,6,5,4,3,2]), 0.2])
		],inf),
	\amp, 0.05, \octave, 5, \instrument, \cfstring1, \mtranspose, 0).asStream;
)

(
e.stream = Pbind(
	[\degree, \dur], Pseq([
			Pseq([[0,0.1],[2,0.1],[3,0.1],[4,0.1],[5,0.8]],2),
			Ptuple([Pxrand([6,7,8,9],4), 0.4]),
			Ptuple([Pseq([9,8,7,6,5,4,3,2]), 0.2])
		],inf),
	\amp, 0.05, \octave, 6, \instrument, \cfstring1, \mtranspose, 0).asStream;
)




// play control:

e.mute; // keeps playing, but replaces notes with rests

e.unmute;

e.reset; // reset the stream.
e.reset; // reset the stream.
e.reset; // reset the stream.
e.reset; // reset the stream.

e.pause; // will resume where paused.

e.play;

e.stop; // will reset before resume.

e.play;




Another example with a different SynthDef:

(
SynthDef(\berlinb, { arg out=0, freq = 80, amp = 0.01, pan=0, gate=1;
	var synth, env;
	env = Decay2.kr(gate, 0.05, 8, 0.0003);
	synth = RLPF.ar(
		LFPulse.ar(freq, 0, SinOsc.kr(0.12,[0,0.5pi],0.48,0.5)),
		freq * SinOsc.kr(0.21,0,18,20),
		0.07
	);
	#a, b = synth*env;
	DetectSilence.ar(a, 0.1, doneAction: 2);
	Out.ar(out, Mix.ar(PanAz.ar(4, [a,b], [pan, pan+1])));
}).store;
)

(
f = Pbind(
		\degree, Pseq([0,1,2,4,6,3,4,8],inf),
		\dur, 0.5, \octave, 3, \instrument, \berlinb
).play;
)

(
f.stream = Pbind(
		\degree, Pseq([0,1,2,4,6,3,4,8],inf),
		\dur, 0.5, \octave, [2,1],
		\instrument, \berlinb,
		\pan, Pfunc({1.0.rand2})
).asStream;
)



Additional arguments
Here is an example with more bindings; Here we have added a filter with cutoff and resonance arguments.
You will need to hit command '.' before executing the next few pbind ex. without having them stack up.
also, due to the synthdef's and synthdeclib, if the server is shut down you will have to reload the
synthdef and re-read the synthdesclib.

(
SynthDef("acid", { arg out, freq = 1000, gate = 1, pan = 1, cut = 4000, rez = 0.8, amp = 1;
	Out.ar(out,
		Pan2.ar(
			RLPF.ar(
				Pulse.ar(freq,0.05),
			cut, rez),
		pan) * EnvGen.kr(Env.linen(0.01, 1, 0.3), gate, amp, doneAction:2);
	)
}).store;
)

(
Pbind(\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],inf), \root,-12,
	 \degree,Pseq([0,3,5,7,9,11,5,1],inf), \pan,Pfunc({1.0.rand2}),
	 \cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}), \amp,0.2).play;
)


The ListPatterns can be put around Event Streams to create sequences of Event Streams.
(
Pseq([
	Pbind(\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],4), \root,-24,
		\degree,Pseq([0,3,5,7,9,11,5,1],inf), \pan,Pfunc({1.0.rand2}),
		\cut,Pxrand([1000,500,2000,300],inf),\rez,Pfunc({0.7.rand +0.3}), \amp,0.2),

	Pbind(\instrument,\acid, \dur,Pseq([0.25],6), \root,-24, \degree,Pseq([18,17,11,9],inf),
		\pan,Pfunc({1.0.rand2}),\cut,1500, \rez,Pfunc({0.7.rand +0.3}), \amp,0.16)

],inf).play;
)

'Pseq' in the above ex. can be any pattern object:
(
Prand([
	Pbind(\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],4), \root,-24,
		\degree,Pseq([0,3,5,7,9,11,5,1],inf),\pan,Pfunc({1.0.rand2}),
		\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}),
		\amp,0.2),

	Pbind(\instrument,\acid, \dur,Pseq([0.25],6), \root,-24, \degree,Pseq([18,17,11,9],inf), 		\pan,Pfunc({1.0.rand2}),\cut,1500, \rez,Pfunc({0.7.rand +0.3}), \amp,0.16)

],inf).play;
)



Multichannel Expansion.
If we supply an array for any argument, the synth node will
automatically replicate to handle the additional arguments.
When we give the 'root' argument an array, we should hear a chord....

(
Pbind(
	\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],inf),
	\root,[-24,-17],
	\degree,Pseq([0,3,5,7,9,11,5,1],inf),
	\pan,Pfunc({1.0.rand2}),\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}),
	\amp,0.2).play;

)


Using Pdef (JITLib) makes it easy to replace patterns on the fly:


(
Pdef(\buckyball).play;
)

(
Pdef(\buckyball, Pbind(\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],inf), \root,[-24,-17],
	\degree,Pseq([0,3,5,7,9,11,[5,17],1],inf), \pan,Pfunc({[1.0.rand2,1.0.rand2]}),
	\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}), \amp,[0.15,0.22]));
)
(
Pdef(\buckyball, Pbind(\instrument,\acid, \dur,Pseq([0.25,0.5,0.25],inf), \root,[-24,-17],
	\degree,Pseq([0b,3b,5b,7b,9b,11b,5b,0b],inf), \pan,Pfunc({1.0.rand2}), //notice the flats
	\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}), \amp,0.2));
)

//stop the Pdef
Pdef(\buckyball).stop;

//start the Pdef
Pdef(\buckyball).resume;

//removing the Pdef
Pdef.remove(\buckyball);


Sending to effects.
Assignment to effect processors can be achieved by setting the 'out' argument to the desired
efx's input bus. The effect Synth must also be created. Synth.new is one way of doing this.

(
//efx synthdef- dig the timing on the delay and the pbind. :-P
SynthDef("pbindefx", { arg out, in, time1=0.25, time2=0.5; 	var audio, efx;
	audio = In.ar([20,21],2);
	efx=CombN.ar(audio, 0.5, [time1,time2], 10, 1, audio); 	Out.ar(out, efx);
	}).load(s);

//create efx synth
a = Synth.after(1, "pbindefx");

//if you don't like the beats change to 0.4,0.24
//a.set(\time1,0.4, \time2,0.24);

SynthDef("acid", { arg out, freq = 1000, gate = 1, pan = 0, cut = 4000, rez = 0.8, amp = 1;
	Out.ar(out,
		Pan2.ar(
			RLPF.ar(
				Pulse.ar(freq,0.05),
			cut, rez),
		pan) * EnvGen.kr(Env.linen(0.02, 1, 0.3), gate, amp, doneAction:2);
	)
}).load(s);

SynthDescLib.global.read;

)


(
Pbind(\instrument,\acid, \out, 20, \dur,Pseq([0.25,0.5,0.25],inf), \root,[-24,-17],
	\degree,Pseq([0,3,5,7,9,11,5,1],inf), \pan,Pfunc({1.0.rand2}),
	\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}), \amp,0.12).play;
)




//UGens as Event values.
//The following example creates unit generators instead of scalar values for
//the values bound to the arguments. This shows that you can use patterns
//to dynamically build your patch. Score data is not limited to scalar values.
//This example can generate 36 different patches: 3 instruments * 3 freqs
//* 2 amps * 2 pans
//
//
//I don't know if this is possible in sc3. 
////(
//SynthDef(\cfstring1.postln, { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
//	var out, eg, fc, osc, a, b, w;
//	fc = LinExp.kr(LFNoise1.kr(Rand(0.25,0.4)), -1,1,500,2000);
//	osc = Mix.fill(8, { LFSaw.ar(freq * [Rand(0.99,1.01),Rand(0.99,1.01)], 0, amp) }).distort * 0.2;
//	eg = EnvGen.kr(Env.asr(0.1,1,1), gate, doneAction:2);
//	out = eg * RLPF.ar(osc, fc, 0.1);
//	#a, b = out;
//	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
//}).load(s);
//
//SynthDef(\berlinb, { arg out=0, freq = 80, amp = 0.01, pan=0, gate=1;
//	var synth, env;
//	env = Decay2.kr(gate, 0.05, 8, 0.0003);
//	synth = RLPF.ar(
//		LFPulse.ar(freq, 0, SinOsc.kr(0.12,[0,0.5pi],0.48,0.5)),
//		freq * SinOsc.kr(0.21,0,18,20),
//		0.07
//	);
//	#a, b = synth*env;
//	DetectSilence.ar(a, 0.1, doneAction: 2);
//	Out.ar(out, Mix.ar(PanAz.ar(4, [a,b], [pan, pan+1])));
//}).load(s);
//
//SynthDef("acid", { arg out, freq = 1000, gate = 1, pan = 0, amp = 0.3;
//	Out.ar(out,
//		Pan2.ar(
//				Pulse.ar(freq*0.125,0.05),
//		pan) * EnvGen.kr(Env.linen(0.01, 1, 0.3), gate, amp, doneAction:2);
//	)
//	}).load(s);
//
//SynthDescLib.global.read;
//)
//
//(
//var a, b, c, pattern, stream;
//
//pattern = Pbind(
//	\freq, Pfunc({Line.kr(40, 2000, 0.2)}),
//		
//	\amp, Pfunc({ 
//			[
//				{ SinOsc.kr(20.0.rand, 0, 0.1, 0.1) },
//				{ XLine.kr(exprand(0.002, 0.2), exprand(0.002, 0.2), 2.2) }
//			].choose.value;
//		}),
//	\pan, Pfunc({ 
//			[
//				{ Line.kr(1.0.rand2, 1.0.rand2, 2.2) },
//				{ SinOsc.kr(4.0.rand) }
//			].choose.value;
//		}),
//	\instrument, Prand([ \cfstring1, \acid, \berlinb ], inf)
//);
//
//)
//


