Pdef stream reference definition

superclass: EventPatternProxy



keeps a reference to a stream that can be replaced while playing, just like its superclass.
It plays on when the old stream ended and a new stream is set and schedules the changes to the beat.
It is very similar to [EventPatternProxy], but handles the storing of global instances:

Pdef(key) returns the instance, Pdef(key, pat) stores the pattern and returns the instance, like Tdef and Ndef.

It can be used to store event Patterns globally. Changes in this global library have effect immediately, or if quant/offset values are given, at the next time step. For value patterns (numerical, non event patterns) 
[Pdefn] is used.

 
 note that exchanging the source of a Pdef while playing does not work with Pmono and Pfx yet,
 due to their incopatibility with Pfindur.


*new(key, pattern)
 store the pattern in a global dictionary under key.
 if there is already a Pdef there, replace its pattern
 with the new one.
 if the pattern is a function, Pdef creates a PlazyEnvir internally
 that dynamically creates the pattern returned from the function, 
 applying the arguments from the inevent.
*new(key)
 acess the pattern at that key (if none is there, a default pattern is created)
 
*default
 a default source, if none is given. the default is a Pbind with resting notes of 1.0 beat duration
 
*removeAll
 remove all streams
*all
 environment (IdentityDictionary) that stores all Pdefs.
 
*all_(envir)
 set the global environment
 
 
quant_(beats)
 set the quantisation time for beat accurate scheduling.
 can be an array [quant, offset, outset]
 
 *defaultQuant_(beats)
 set the default quantisation for new instances (default: 1.0)
 can be an array [quant, offset, outset]
 
condition_(func)
 provide a condition under which the pattern is switched when a new one is inserted.
 the stream value and a count is passed into the function (see example)
 the methods count_(n) simply counts up to n and switches the pattern then

reset 
 switch the pattern immediately. (stuck conditions can be subverted by this)

 
fadeTime_(beats)
 when the synthdefs that are used contain an \amp control, the patterns are replaced
 by crossfading the previous with the new over this time (in beats)
 
envir_(event)
 provide a default event for the Pdef. It is used to filter the incoming stream before it
 is passed to the source pattern. This is similar to NodeProxy-nodeMap.
 When set for the first time, the pattern is rebuilt.
 
set(key, val, key2, val2, ...)
 set arguments in the default event. If there is none, it is created and the pattern is rebuilt.

 
map(key, pdefKey, key, pdefKey ...)
 map Pdefn to the keys in the event.
 
 
source_ 
set the pattern (internally done by *new(key, pattern)
 (pattern_(..) is equivalent)
 
 
endless
 returns a Proutine that plays the proxy endlessly, replacing nil with a default
 value (silent event). This allows to create streams that idle on until a new pattern is inserted.

 
 

a) using it as stream reference
 
 
embedInStream(inval)
just like any pattern, embeds itself in stream
 


b) using it as EventStreamPlayer

play(clock, protoEvent, quant)
 starts the Pdef and creates a player. 
 if you want to play multiple instances, use .playOnce(clock, protoEvent, quant)
 quant can be an array of [quant, phase]
 
stop
 stops the player
 
player 
 the current player (if the Pdef is simply used in other streams this is nil)

pause / resume / reset / mute / unmute
perform player method 
 
isPlaying 
 returns true if Pdef is running.
 if a Pdef is playing and its stream ends, it will schedule a stream for playing 
 as soon as a new one is assigned to it.
 
 

for another use of Pdef see also [recursive_phrasing] 





a) embedding Pdef into a stream:



(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
 var env, u=1;
 env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
 3.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
 Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)
s.boot;

Pdef(\metronom, Pbind(\instrument, \Pdefhelp, \dur, 1, \degree, 16, \legato, 0.1)).play;

x = Pseq([Pdef(\a), Pdef(\b), Pdef(\c)], inf).play;

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3])));
Pdef(\b, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[7, 8, 7, 8])));
Pdef(\c, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 1, 2], 2)));




Pdef(\c, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[4, 3, 1, 2]*3)));


// infinite loops are scheduled (to ths clock's next beat by default) and released:

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pseq(#[0, 5, 4, 3, 2], inf)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5, 4, 3] + 1, 1)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3] - 4, 1)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5] - 1, 1)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pshuf(#[0, 5, 4, 3, 2], inf)));

x.stop;
Pdef(\metronom).stop;

// Pdef can be used in multiple patterns:

(
x = Ppar([
 Pbindf(Pn(Pdef(\a), inf),
 \gtranspose, Pstutter(8, Pseq(#[0, 2, 0, 3],inf))
 ),
 Pbindf(Pn(Pdef(\a), inf),
 \gtranspose, Pstutter(8, Pseq(#[7, 4, 0, 3],inf)), 
 \dur, 0.6
 ),
 Pbindf(Pn(Pdef(\a), inf),
 \degree, Pseq(#[0, 5, 4, 3, 2, 3, 2], 1)
 )
]).play;
)

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1, 0, 1, 2], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 1, \degree, Pseq([0, 4], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4, Prand([6, 8b],2)], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1b, 1, 2b, 2, 3, 4b, 4, 5], inf)));

// using a fade time, the above changes are crossfaded
Pdef(\a).fadeTime = 2;

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4, Prand([6, 8b],2)], inf)));

// ...

Pdef(\a).set(\detune, -50); // set environment
Pdef(\a).set(\detune, 0);

x.stop;


b) playing Pdef

 
(
// load a synthdef
s.boot;
SynthDef("gpdef", 
 { arg out=0, freq=440, dur=0.05, amp=0.1;
 var env;
 env = EnvGen.kr(Env.perc(0.01, dur), doneAction:2) * amp;
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).store;
)


Pdef(\x); // creates a Pdef with a default pattern.


Pdef(\x).play; // play it. A silent resting pattern is used.
Pdef(\y).play; // play a second one (automatically instantiated)


// assign various patterns to it:

Pdef(\x, Pbind(\dur, 0.25, \instrument, \gpdef)); 
Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6], inf), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]+1, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-1, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b]-2, inf), \instrument, \gpdef));

// using fadeTime:

Pdef(\y).fadeTime = 8.0;
Pdef(\y, Pbind(\dur, 0.125, \degree, Pseq([3, 4, 5b, 6]+4.rand, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-2, inf), \instrument, \gpdef));

(
Pdef(\x, Pbind(
 \dur, 1 / 6, 
 \degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1) - 5, 6]+1, inf), 
 \instrument, \gpdef
 )
 );
)
(
Pdef(\x, Pbind(
 \dur, 0.25, 
 \degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1), 6], inf), 
 \instrument, \gpdef)
 );
)
Pdef(\x).stop;

Pdef(\x).play;

// tempo change
TempoClock.default.tempo = 1.3;
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5, 6]+1, inf), \instrument, \gpdef));

// drop in ending patterns

Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, [7,4], 5, 6]-2), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.125, \degree, Pseq([3, [7,4], 5, 4]-3), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.35, \degree, Pseq([3, [7,4], 5, 4, 3]-3), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.25, \degree, Pshuf([3, [7,4], 5, 6]-2), \instrument, \gpdef));


// clear all.
Pdef(\x).clear; 
Pdef(\y).clear; 
TempoClock.default.tempo = 1.0;




recursion:

Pdefs can be used recursively under the condition that the stream call structure allows it.
a structure like the following works:


Pdef(\x, Pseq([Pbind(\instrument, \gpdef), Pdef(\x)], inf)); 
Pdef(\x).play;

but the following would crash, because .embedInStream is called recursively with no limit:

// Pdef(\y, Pseq([Pdef(\y), Pbind(\instrument, \gpdef)], inf));




outset

When quantizing to a larger number of beats, the changes become very slow if one has to wait for the next beat. Providing an outset quant value is a way to make the change so that it appears as if it had been done at the previous grid point already. The stream is fast forwarded to the current position relative to the quant grid.
Providing a number larger than zero, the next possible quant point is used as outset.

For example, if quant is 32, and one has just missed the first beat when changing the pattern,
one has to wait for 32 beats until the change happens. Using an outset of 1, it is assumed that you had already
changed the pattern at the first beat, the stream is fast forwarded to the time it would be at now if you had done so. The new pattern is inserted at the next beat (outset=1).

quant can be: [quant, offset, outset]

// examples
(
Pdef(\x).quant_([8, 0, 1]);
Pdef(\y).quant_([8, 0.5, 1]); // offset by half a beat
Pdef(\x).play;
Pdef(\y).play;
)

Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf)));
Pdef(\y, Pbind(\degree, Pseq((0..7)-2, inf)));
Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf), \dur, 0.5));
Pdef(\y, Pbind(\degree, Pseq((0..7).scramble-2, inf), \dur, 0.25, \legato, 0.3));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf)));

Pdef(\x, Pbind(\degree, Pseq([ 1, 5, 6, 7, 0, 3, 2, 4 ], inf), \dur, 1));
Pdef(\x, Pbind(\degree, Pseq([ 0, 2, 2, 4, 0, 4, 0, 4 ], inf), \dur, 1));

Pdef(\x).quant_([8, 1/3, 1]); // offset by 1/6 beat relative to y
Pdef(\x, Pbind(\degree, Pseq([ 1, 1, 1, 7, 0, 2, 2, 4 ], inf), \legato, 0.1));
Pdef(\x, Pbind(\degree, Pseq([ 3, 3, 3, 4b ], inf), \legato, 0.1));
Pdef(\y, Pbind(\degree, Pseq((0..7).scramble-4, inf), \dur, 0.25, \legato, 0.3));




note 

this fast forwarding might create a cpu peak if the pattern is very complex/fast or
quant is very long. This is hard to avoid, so it simply has to be taken into account.




// some testing
(
var quant = #[8, 0, 1]; // quantise to 8 beats, no offset, insert quant to 1 beat
Pdef(\x).quant_(quant);
Pdef(\x).play;
Routine { loop { 8.do { |i|?("uhr:"+i).postln; 1.wait } } }.play(quant:quant);
Pbind(\degree, Pseq((0..7), inf)).play(quant:quant);
)

Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf)).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf) + [0, 3]).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf) + [0, 6], \dur, 0.5).trace(\degree));


Pdef(\x).fadeTime = 8;

Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7).reverse, inf) + [0, 6], \dur, 0.5));

Pdef(\x).fadeTime = nil;
Pdef(\x).quant = 1;

Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));

Pdef(\x).quant = 8;
Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));



update condition


In order to be able to switch to a new pattern under a certain condition, the instance variable
condition can be set to a function that returns a boolean. Value and a count index are passed to the function.
The condition is always valid for the next pattern inserted. For stuck conditions, the reset message can be used.

As counting up (such as "every nth event, a swap can happen") is a common task, there is a method for this,
called count(n).


Pdef(\x).play;
Pdef(\x).quant = 0; // we don't want quant here.
Pdef(\x, Pbind(\degree, Pseq((0..5), inf), \dur, 0.3)).condition_({ |val, i| i.postln % 6 == 0 });
Pdef(\x, Pbind(\degree, Pseq((0..7) + 5.rand, inf), \dur, 0.3)).condition_({ |val, i| (i % 8).postln == 0 });

// the above is equvalent to:
Pdef(\x, Pbind(\degree, Pseq((0..7) + 5.rand, inf), \dur, 0.3)).count(8);

// the value that is sent in is the event, so decisions can be made dependent on the event's fields



reset
 
// reset to change immediately:
Pdef(\x).reset;







