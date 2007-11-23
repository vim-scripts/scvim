
play


start a process


this message is of common use in sc. Different objects respond to it in various
ways, but the simple meaning is: start a process.
It is usually implemented by objects in contributed libraries as well.

play usually returns the playing object which might not be the same as the one
the message was sent to.

opposite: stop



clock.play(stream)
returns: the clock
	
	(
	r = Routine.new({ "...playing".postln; 1.wait; "ok, that was it".postln });
	SystemClock.play(r);
	)

routine.play(clock)
returns: the routine

	Routine.new({ "...playing".postln; 1.wait; "ok, that was it".postln }).play;


stream.play(clock)
returns the stream
	the stream will loop until it returns nil
	
	FuncStream({ "ok, that was it".postln; 1 }).play;
	
	
pausestream.play(clock) / task.play(clock)
returns the stream

	a = PauseStream.new(FuncStream.new({ "ok, that was it".postln; 1 }));
	a.play;
	a.stop;
	a.play;
	a.stop;
	
	a = Task.new({ loop({ "ok, that was it".postln; 1.wait; }) });
	a.play;
	a.stop;
	
	
pattern.play(clock, protoEvent)
returns: an EventStreamPlayer

	(
	Pseq([
		Pbind(\freq, Pn(500, 1)),
		Pbind(\dur, Pn(0.1, 1))
	], 2).play;
	)



______________________________________________________
	
The following play messages both cause a SynthDef to be written, send it to the server
and start a synth with it there.

they should not be used in quickly running automated processes,
as there are more efficient alternatives (see SynthDefsVsSynths)



synthDef.play(target, args, addAction)
returns: a Synth
	
	note that you need an out ugen to hear the result.
	in sc3 synths can write to busses using an out ugen or they can also just run without any writing activity.
	one example of a synth without an out ugen is SendTrig, whereas you find different examples
	of how to write to the busses in the helpfiles: Out / ReplaceOut / XOut / OffsetOut
	as what is audible through the hardware busses must be written on them, one way or another
	an out ugen is always needed.
	some operations provide an out ugen internally: see for example function.play, which plays out
	to a bus number provided in the argument passed to .play



(
x = SynthDef("test", { arg out, amp=0.1;
	var sound;
	sound = PinkNoise.ar(amp * [1,1]);
	Out.ar(out, sound);
}).play;
)

//set the synth
x.set(\amp, 0.2);
//free the synth
x.free;


note: Synth.play(function), is synonymous. for backwards compatibility with sc2


function.play(target, outbus, fadeTime)
returns: a Synth
	adds to tail by default
	soft fade in and out.

//note that you can use Out ugens but you do not need to
{ PinkNoise.ar(0.1*[1,1]) }.play;

//mouse x controls level
{ XOut.ar(0, MouseX.kr(0,1), PinkNoise.ar(0.1*[1,1])) }.play;



the arguments of the function are the same as in SynthDef.new, which means you cannot pass
in any value - they are used to build Controls for the synth.

you can set the controls in the running synth:


x = { arg freq=900; Resonz.ar(PinkNoise.ar([1,1]), freq, 0.01) }.play(s, 0);
x.set(\freq, 1400);
x.free;

which this is equivalent to:
(
x = SynthDef("nextrandomname", { arg freq=900;
	Out.ar(0, Resonz.ar(PinkNoise.ar([1,1]), freq, 0.01))
}).play(s);
)
x.set(\freq, 1400);
x.free;


more modularity can be achieved by using [Instr] from the CRUCIAL-LIBRARY.









	


