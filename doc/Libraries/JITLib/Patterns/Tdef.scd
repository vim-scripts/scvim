
Tdef				 task reference definition

superclass: TaskProxy




keeps a reference to a task (time pattern) that can be replaced while playing.
It plays on when the old stream ended and a new stream is set and schedules the changes to the beat.

Tdef(key) returns the instance, Tdef(key, pat) defines the pattern and returns the instance, like Pdef and Ndef.
it is very similar to TaskProxy


	
	*new(key, obj)
			store the task in a global dictionary under key.
			if there is already a Tdef there, replace its task
			with the new one.
			obj is a function or a pattern of time values.
			
	*new(key)
			acess the task at that key (if none is there, a default task is created)
			
	*default
			a default source, if none is given. the default is a loop that does nothing with a 1.0 beat wait time
		
	*removeAll
			remove all tasks
	
	*all
			dict that stores all Tdefs
	
	*all_(envir)
			set the global environment
				
	quant_(beats)
			set the quantisation time for beat accurate scheduling
			can be a pair [offset, quant]
	
	*defaultQuant_(beats)
			set the default quantisation for new instances (default: 1.0)
			can be a pair [offset, quant]

	condition_(func)
			provide a condition under which the pattern is switched when a new one is inserted.
			the stream value and a count is passed into the function.
			the methods count_(n) simply counts up to n and switches the pattern then
	
	reset		
			switch the pattern immediately. (stuck conditions can be subverted by this)


	envir_(event)
			provide a default environment for the proxy.
			If given, it is used as an environment for the routine
			function. When set for the first time, the routine pattern is rebuilt.
	
	set(key, val, key2, val2, ...)
			set arguments in the environment.
			If there is none, it is created and the routine pattern is rebuilt.

	endless
			returns a Proutine that plays the proxy endlessly, replacing nil with a default
			value (1 s. wait time). This allows to create streams that idle on until a new pattern is inserted.


a) using it as stream reference
	
	
	embedInStream(inval)
			just like any stream, embeds itself in stream.
			see example for usage.
	
	

	
b) using it as Task

	play(clock, doReset, quant)
			starts the Pdef and creates a player.
			if you want to play multiple instances, use .playOnce(clock, doReset, quant)			quant can be an array of [quant, phase]
			
	stop
			stops the task
	
	player	
			the current task (if the Tdef is simply used in other streams this is nil)

	pause / resume / reset / mute / unmute
			perform player method
			
	isPlaying
			returns true if Tdef is running.
			if a Tdef is playing and its stream ends, it will schedule a task for playing
			as soon as a new function is assigned to it.
		




a) using Tdef as a task player


Tdef(\x).play; // create an empty Tdef and play it.

Tdef(\x, { loop({ "ggggggggggggggggg9999ggg999ggg999gg".scramble.postln; 0.5.wait; }) });


Tdef(\x, { loop({ "---------////----------------------".scramble.postln; 0.25.wait; }) });
Tdef(\x, { loop({ thisThread.seconds.postln; 1.wait; }) });
Tdef(\x, { loop({ thisThread.seconds.postln; 1.01.wait; }) });

TempoClock.default.tempo = 2;

Tdef(\x, { "the end".postln });
Tdef(\x, { "one more".postln });
Tdef(\x, { loop({ "some more".scramble.postln; 0.25.wait; }) });

TempoClock.default.tempo = 1;

Tdef(\x).stop;
Tdef(\x).play;

Tdef(\x).clear;




// sound example

(
// load a synthdef
s.boot;
SynthDef("pdef_grainlet",
	{ arg out=0, freq=440, dur=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, dur, 0.3), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).store;
)
Tdef(\x).play;

(
Tdef(\x, {
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, rrand(600, 640));
		0.1.wait;
	})
})
)

(
Tdef(\x, {
	var x;
	x = Pseries(300, 20, 100).loop.asStream;
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	})
})
)

(
Tdef(\x, {
	var x;
	x = Plazy({ Pseries(300 + 300.rand, 10 + 30.rand, 10 + 30.rand) }).loop.asStream;
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	})
})
)

// metronome
Tdef(\y, { loop({ s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, 1500); 1.wait; }) }).play;

// play ending stream once
(
Tdef(\x, {
	var x, dt;
	dt = [0.1, 0.125, 0.05].choose;
	x = Plazy({ Pseries(1300 + 300.rand, 110 + 130.rand, 16) }).asStream;
	x.do({ arg item;
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, item);
		dt.wait;
	})
})
)

... and so on ...

Tdef(\x).stop;
Tdef.removeAll;



b) embedding Tdef into other Tasks / Routines


(
Tdef(\a, {"one".postln; 1.wait; "two".postln });
Tdef(\c, { var z; z = Synth(\default); 0.5.wait; z.release });
r = Task({
	"counting...".postln;
	2.wait;
	Tdef(\a).embedInStream;
	1.wait;
	Tdef(\c).embedInStream;
	"done.".postln;
});
)

r.play; // play a stream

Tdef(\c, { var z; z = Synth(\default, [\freq, 300]); 1.5.wait; z.release }); // change the def

r.reset;
r.play;

// of course Tdefs can be used in other Tdefs:
(
Tdef(\b, {
	"counting...".postln;
	2.wait;
	Tdef(\a).embedInStream;
	1.wait;
	Tdef(\c).embedInStream;
	"done.".postln;
});
)
Tdef(\b).asStream.play;

// if one wants to branch off a stream in a separate thread, asStream is used.
// also the method playOnce can be used
(
Routine({
	Tdef(\c).asStream.play;
	0.1.wait;
	Tdef(\c).asStream.play;
	0.1.wait;
	Tdef(\a).asStream.play;

}).play;
)






Tdef as a time pattern

Instead of using a Pdefn for time values, it can be useful to use a Tdef.
When changing its source, it keeps the stream of values synchronized to its clock.


(
// load a synthdef
s.boot;
SynthDef("pdef_grainlet",
	{ arg out=0, freq=440, dur=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, dur, 0.3), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).store;
)




Tdef(\z, Pseq([1, 1, 1, 0.5, 0.5], inf));

(
	Pset(\instrument, \pdef_grainlet,
		Ppar([
			Pbind(
				\dur, Tdef(\z),
				\note, Pseq([1, 3, 2, 1, 0], inf),
				\x, Pfunc {TempoClock.default.elapsedBeats.postln } // posts the onset times
			),
			Pbind(
				\dur, 4, // reference beat
				\sustain, 0.1,
				\note, 8
			)
		])
	).play(quant:1);
)


Tdef(\z, Prand([1, 1, 0.23, 0.5, 0.5], inf)); // exchange time pattern
Tdef(\z, Pseq([1, 1, 1, 1], inf)); // pattern stays in sync.
Tdef(\z, Pseq([1, 1, 1, 0.5, 0.5], inf)); // but might be in different order (
									// to avoid this, set the quant to a appropriate value.




