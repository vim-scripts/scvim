Pwalk : ListPattern

A one-dimensional random walk.

*new(list, stepPattern, directionPattern, startPos)

list: The items to be walked over.
stepPattern: Returns integers that will be used to increment the index into list.
directionPattern: Used to determine the behavior at boundaries. When the index crosses a boundary, the next direction is drawn from this stream: 1 means use stepPattern as is, -1 means go in the reverse direction.

Common patterns: 1 -- always wrap around to the other boundary.
Pseq([1, -1], inf) -- go forward first, then backward, then forward again

startPos: Where to start in the list.

Example:

p = Pwalk(
 Array.series(20, 0, 1), // integers, 0-19
 // steps up to 2 in either direction, weighted toward positive
 Pwrand([-2, -1, 0, 1, 2], [0.05, 0.1, 0.15, 1, 0.1].normalizeSum, inf),
 // reverse direction at boundaries
 Pseq([1, -1], inf),
 10); // start in the middle
a = p.asStream;

200.do({ a.next.post; ", ".post });

q = p.copy.directionPattern_(1); // this one will always wrap around
b = q.asStream;

200.do({ b.next.post; ", ".post });

// non-random walk: easy way to do up-and-down arpeggiation
s.boot;
(
p = Pwalk(
 [60, 64, 67, 72, 76, 79, 84].midicps, // C major
 Pseq([1], inf),
 Pseq([1, -1], inf), // turn around at either end
 0);
f = p.asStream;

SynthDef("help-Pwalk", { arg freq;
 Out.ar(0, Saw.ar([freq, freq+1], 0.5) * EnvGen.kr(Env.perc(0.01, 0.1), doneAction:2))
}).send(s);
)

(
r = Task({
 {
 Synth.new("help-Pwalk", [\freq, f.next]);
 0.1.wait;
 }.loop;
}).play(SystemClock);
)

r.stop;