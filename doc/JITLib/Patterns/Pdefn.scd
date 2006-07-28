Pdefn value-stream reference definition

superclass: PatternProxy




access and assignment are done by *new

keeps a reference to a task that can be replaced while playing.

Pdefn(key) returns the instance, Pdefn(key, pat) defines the pattern 
and returns the instance, like Pdef, Tdef and Ndef.
it is very similar to [PatternProxy]

it can be used to store value patterns globally (for event patterns, see Pdef).


 *new(key, pattern)
 store the pattern in a global dictionary under key.
 the pattern can be anything that embeds in a stream.
 instead of a pattern, a function can be passed in, creating a routine. (see example below).
 
*new(key)
 acess the pattern at that key (if none is there, a default pattern is created)
 
*default
 a default source, if none is given. 
 the default is 1.0 (it is not 0.0 in order to make it safe for durations) 
*removeAll
 remove all patterns
*all
 dict that stores all Pdefn
 
*all_(envir)
 set the global environment
 
quant_(beats)
 set the quantisation time for beat accurate scheduling
 can be a pair [quant, offset]
 
 *defaultQuant_(beats)
 set the default quantisation for new instances (default: nil)
 can be a pair [quant, offset]
 
condition_(func)
 provide a condition under which the pattern is switched when a new one is inserted.
 the stream value and a count is passed into the function (see example)
 the methods count_(n) simply counts up to n and switches the pattern then
 
source_ 
set the pattern (internally done by *new(key, pattern).
 if quant is not nil, the change is scheduled to the beat
 (pattern_(..) is equivalent)
 
embedInStream(inval)
just like any stream, embeds itself in stream.
 
reset 
 switch the pattern immediately. (stuck conditions can be subverted by this)
 

envir_(event)
 provide a default environment for the proxy. 
 If given, it is used as an environment for the routine 
 function. When set for the first time, the routine pattern is rebuilt.
 
set(key, val, key2, val2, ...)
 set arguments in the environment. 
 If there is none, it is created and the pattern is rebuilt.
 
map(key, pdefKey, key, pdefKey ...)
 map one Pdefn to the other. the patterns can be accessed via the currentEnvironment


endless
 returns a Proutine that plays the proxy endlessly, replacing nil with a default
 value (1). This allows to create streams that idle on until a new pattern is inserted.


Pdefn is similar to [Pdef] and [Tdef] . see the other helpfiles for comparison.






Pdefn in expressions


Pdefn(\c, Pdefn(\a) + Pdefn(\b));

t = Pdefn(\c).asStream; // create a stream from Pdefn(\c)

t.value; // default value for a Pdefn is 1, so that it is a good time value default.

Pdefn(\a, 100); // (re)define Pdefn(\a) as 100

t.value;

Pdefn(\b, Pseq([1, 2, 3], inf)); // (re)define Pdefn(\b) as Pseq([1, 2, 3], inf)

3.do { t.value.postln };

Pdefn(\c, Pdefn(\a) * Pdefn(\b) - Pdefn(\a)); // (re)define Pdefn(\c) 

8.do { t.value.postln };

Pdefn(\a, Prand([1, 4, 2], inf)); // (re)define Pdefn(\a) 





Embedding Pdefn in other patterns



Pdefn(\x, Pseq([1, 2, 3],inf));

x = Pseq([0, 0, Pdefn(\x)], inf).asStream;

t = Task({ loop({ x.next.postln; 0.3.wait }) }).play;


Pdefn(\x, Pseq([55, 66, 77],inf));
Pdefn(\x, Pseq([55, 66, 77],1));

t.stop;



// Pdefn can be accessed in multiple streams

(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
 var env, u=1;
 env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
 5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
 Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
s.boot;
)

(
Pdefn(\deg, Pseq([0, 3, 2],inf));

Pset(\instrument, \Pdefhelp, 
 Ppar([
 Pbind(\degree, Pdefn(\deg)),
 Pbind(\degree, Pdefn(\deg), \dur, 1/3)
])
).play;
)

Pdefn(\deg, Prand([0, 3, [1s, 4]],inf));

Pdefn(\deg, Pn(Pshuf([0, 3, 2, 7, 6],2),inf));

(
Pdefn(\deg, Plazy { var pat;
 pat = [Pshuf([0, 3, 2, 7, 6],2), Pseries(0, 1, 11), Pseries(11, -1, 11)].choose;
 Pn(pat, inf)
 });
)




Timing: when does the definition change?


// if quant is set, the update is done at the next beat or whatever is specified:

Pdefn(\deg).quant = 4;
Pdefn(\deg, Pn(Pseries(0, 1, 8),inf));

Pdefn(\deg).quant = nil; // activate immediately again

(
Pdefn(\deg, {
 loop {
 5.do { |i|
 #[1, 3, 4].choose.yield;
 #[5, 0, 12].choose.yield;
 #[14, 3, 4].choose.do { |j|?(i % j).postln.yield };
 }
 }
})
)


update condition


In order to be able to switch to a new pattern under a certain condition, the instance variable
condition can be set to a function that returns a boolean. Value and a count index are passed to the function.
The condition is always valid for the next pattern inserted. For stuck conditions, the reset message can be used.

As counting up (such as "every nth event, a swap can happen") is a common task, there is a method for this,
called count(n).


z = Pbind(\degree, Pdefn(\x), \dur, 0.25).play;
Pdefn(\x, Pseq((0..5), inf)).condition_({ |val, i| i.postln % 6 == 0 });
Pdefn(\x, Pseq((0..8), inf)).condition_({ |val, i| i.postln % 9 == 0 });


// the above is equvalent to:
Pdefn(\x, Pseq((0..8), inf)).count(9);


reset
 
// reset to change immediately:
Pdefn(\x).reset;





Functions as arguments to Pdefn:
(experimental, bound to change!)

Pdefn(\deg, { loop { yield(0.1.rand.round(0.01) + [2, 3, 9].choose) } });

// equivalent to:

Pdefn(\deg, Proutine { loop { yield(0.1.rand.round(0.01) + [2, 3, 9].choose) } });

// this is not exactly true, see below..





The (inner) environment

when passing a function to 

// set() creates a local environment that overrides the outer currentEnvironment

Pdefn(\z).set(\a, 1, \b, 5);
(
Pdefn(\z, { |e| 
 loop {?yield((e.a + e.b) + 0.1.rand.round(0.01)) } 
})
); // [1]

t = Pdefn(\z).asStream;

t.nextN(3);

(
Pdefn(\z, { |e| 
 //(e.a + e.b) + 0.1.rand.round(0.01) 1
 Pseq([1, 2, e.b], 1)
})
); 

Pdefn(\z, Pseq([1, 2, 3], 1)); 

e = Pdefn(\z).envir
d

Pdefn(\z).set(\a, 3);

t.next;

Pdefn(\z).set(\a, Pseq([1, 2, 3], inf));

t.nextN(3);

Pdefn(\z).envir; // post the envir




// using the "map" message one can map one Pdefn to the other:

Pdefn(\z).map(\a, \other);

t.nextN(3); // Pdefn default value (1) is used

Pdefn(\other, Prand([200, 300, 400], inf)); // assign a pattern to \other

t.nextN(3);


// if you want to keep using the currentEnvironment at the same time, 
// assign the currentEnvironment to the envir's parent (or proto) field
// (this shouldn't be a proxy space of course.)

Pdefn(\z).envir.parent = currentEnvironment;
~a = 9;
~b = 10; 

t.nextN(3);


