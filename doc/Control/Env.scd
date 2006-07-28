Env envelope specification

superclass: Object

An Env is a specification for a segmented envelope. Envs can be used both server-side, by an EnvGen within a SynthDef, and clientside, with methods such as at and asStream, below. An Env can have any number of segments which can stop at a particular value or loop several segments when sustaining. An Env can have several shapes for its segments.
 
Basic Creation

*new(levels, times, curves, releaseNode, loopNode)

 Create a new envelope specification.
levels - an array of levels. The first level is the initial value of the envelope.
times - an array of durations of segments in seconds. There should be one fewer duration than there are levels.
curve - this parameter determines the shape of the envelope segments.
 The possible values are:
 'step' - flat segments
 'linear' - linear segments, the default
 'exponential' - natural exponential growth and decay. In this case, the levels must all be nonzero
 and the have the same sign.
 'sine' - sinusoidal S shaped segments.
 'welch' - sinusoidal segments shaped like the sides of a Welch window.
 a Float - a curvature value for all segments.
 An Array of Floats - curvature values for each segments.
releaseNode - an Integer or nil. The envelope will sustain at the release node until released.
loopNode - an Integer or nil. If not nil the sustain portion will loop from the releaseNode to the loop node.


 s.boot;
 // different shaped segments:
 Env.new([0,1, 0.3, 0.8, 0], [2, 3, 1, 4],'linear').test.plot;
 Env.new([0.001, 1, 0.3, 0.8, 0.001], [2, 3, 1, 4],'exponential').test.plot;
 Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4],'sine').test.plot;
 Env.new([0.001, 1, 0.3, 0.8, 0.001],[2,3,1,4],'welch').test.plot;
 Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4],'step').test.plot;
 Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4], -2).test.plot;
 Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4], 2).test.plot;
 Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4], [0, 3, -3, -1]).test.plot;
 
If a release node is given, and the gate input of the EnvGen is set to zero, it outputs the nodes after the release node:
 
//release node is node 2; releases after 5 sec
Env.new([0.001,1,0.3,0.8,0.001],[2,3,1,4] * 0.2, 2, 2).test(5).plot;
 Env.new([0.001,1,0.3,0.8,0.5,0.8,0],[2,3,1,2,2,1] * 0.2, 2, 2).test(5).plot;
 //instant release 
 Env.new([0.001,1,0.3,0.8,0.5,0.8,0],[2,3,1,2,2,1] * 0.2, 2, 2).test(0.1).plot; 
 
If a loop node is given, the EnvGen outputs the nodes between the release node and the loop node until it is released:
 
//release node is node 3, loop node is node 1
Env.new([0.001,1,0.3,0.8,0.5,0.8,0],[2,1,1,2,3,1] * 0.1, 'lin', 3, 1).test(3).plot; 

Note:
 
The starting level for an envelope segment is always the level you are at right now. For example when the gate is released and you jump to the release segment, the level does not jump to the level at the beginning of the release segment, it changes from the whatever the current level is to the goal level of the release segment over the specified duration of the release segment.

There is an extra level at the beginning of the envelope to set the initial level. After that each node is a goal level and a duration, so node zero has duration equal to times[0] and goal level equal to levels[1].
 
The loop jumps back to the loop node. The endpoint of that segment is the goal level for that segment and the duration of that segment will be the time over which the level changed from the current level to the goal level.

*newClear(numSegments)

 Creates a new envelope specification with numSegments for filling in later. This can be useful when passing Env parameters as args to a [Synth]. Note that the maximum number of segments is fixed and cannot be changed once embedded in a [SynthDef]. Trying to set an Env with more segments than then this may result in other args being unexpectedly set.
 
(
 SynthDef("Help-Env-newClear", { arg i_outbus=0, t_gate ;
 var env, envctl;
 // make an empty 4 segment envelope
 env = Env.newClear(4);
 // create a control argument array
 envctl = Control.names([\env]).kr( env.asArray );
 Out.ar(i_outbus, SinOsc.ar(EnvGen.kr(envctl, t_gate), 0, 0.3));
 }).send(s);
 )
 (
 s.makeBundle(nil, {
 // must not have more segments than the env above
 e = Env([700,900,900,800], [1,1,1], \exp); // 3 segments
 x = Synth("Help-Env-newClear", [\t_gate, 1]);
 x.setn(\env, e.asArray);
 });
 )
 (
 // reset then play again
 e = Env([800,300,400,500,200], [1,1,1,1], \exp); // 4 segments
 x.setn(\env, e.asArray);
 x.set(\t_gate, 1);
 )
 x.free;
 
Standard Shape Envelope Creation Methods

The following class methods create some frequently used envelope shapes based on supplied durations.
 
*linen(attackTime, sustainTime, releaseTime, level, curve)
 
 Creates a new envelope specification which has a trapezoidal shape.
attackTime - the duration of the attack portion.
sustainTime - the duration of the sustain portion.
releaseTime - the duration of the release portion.
level - the level of the sustain portion.
curve - the curvature of the envelope.

s.boot;
 Env.linen(1, 2, 3, 0.6).test.plot;
 Env.linen(0.1, 0.2, 0.1, 0.6).test.plot;
 Env.linen(1, 2, 3, 0.6, 'sine').test.plot;
 Env.linen(1, 2, 3, 0.6, 'welch').test.plot;
 Env.linen(1, 2, 3, 0.6, -3).test.plot;
 Env.linen(1, 2, 3, 0.6, -3).test.plot;


*triangle(duration, level)
 
 Creates a new envelope specification which has a triangle shape.
duration - the duration of the envelope.
level - the peak level of the envelope.
 
 Env.triangle(1, 1).test.plot;


*sine(duration, level)
 
 Creates a new envelope specification which has a hanning window shape.
duration - the duration of the envelope.
level - the peak level of the envelope.
 
Env.sine(1,1).test.plot;
 
  
*perc(attackTime, releaseTime, peakLevel, curve)
 
 Creates a new envelope specification which (usually) has a percussive shape.
attackTime - the duration of the attack portion.
releaseTime - the duration of the release portion.
peakLevel - the peak level of the envelope.
curve - the curvature of the envelope.

 Env.perc(0.05, 1, 1, -4).test.plot;
 Env.perc(0.001, 1, 1, -4).test.plot; // sharper attack
 Env.perc(0.001, 1, 1, -8).test.plot; // change curvature
 Env.perc(1, 0.01, 1, 4).test.plot; // reverse envelope


Sustained Envelope Creation Methods

The following methods create some frequently used envelope shapes which have a sustain segment.

*adsr(attackTime, decayTime, sustainLevel, releaseTime, peakLevel, curve)
 
 Creates a new envelope specification which is shaped like traditional analog attack-decay-sustain-release (adsr) envelopes.
attackTime - the duration of the attack portion.
decayTime - the duration of the decay portion.
sustainLevel - the level of the sustain portion as a ratio of the peak level.
releaseTime - the duration of the release portion.
peakLevel - the peak level of the envelope.
curve - the curvature of the envelope.
 
 Env.adsr(0.02, 0.2, 0.25, 1, 1, -4).test(2).plot;
 Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(2).plot; 
 //release after 0.45 sec
 Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(0.45).plot; 
*dadsr(delayTime, attackTime, decayTime, sustainLevel, releaseTime, peakLevel, curve)

 As *adsr above, but with it's onset delayed by delayTime in seconds. The default delay is 0.1.
 
*asr(attackTime, sustainLevel, releaseTime, peakLevel, curve)
 
 Creates a new envelope specification which is shaped like traditional analog attack-sustain-release (asr) envelopes.
attackTime - the duration of the attack portion.
sustainLevel - the level of the sustain portion as a ratio of the peak level.
releaseTime - the duration of the release portion.
peakLevel - the peak level of the envelope.
curve - the curvature of the envelope.
 

 Env.asr(0.02, 0.5, 1, 1, -4).test(2).plot;
 Env.asr(0.001, 0.5, 1, 1, -4).test(2).plot; // sharper attack
 Env.asr(0.02, 0.5, 1, 1, 'linear').test(2).plot; // linear segments

*cutoff(releaseTime, level, curve)
 
 Creates a new envelope specification which has no attack segment. It simply sustains at the peak level until released. Useful if you only need a fadeout, and more versatile than [Line].
releaseTime - the duration of the release portion.
level - the peak level of the envelope.
curve - the curvature of the envelope.

 Env.cutoff(1, 1).test(2).plot;
 Env.cutoff(1, 1, 4).test(2).plot;
 Env.cutoff(1, 1, 'sine').test(2).plot;


Instance Methods
 
blend(anotherEnv, blendFraction)

 Blend two envelopes. Returns a new Env.
anotherEnv - an Env.
blendFraction - a number from zero to one.
 
 a = Env([0, 0.2, 1, 0.2, 0.2, 0], [0.5, 0.01, 0.01, 0.3, 0.2]).test.plot;
 b = Env([0, 0.4, 1, 0.2, 0.5, 0], [0.05, 0.4, 0.01, 0.1, 0.4]).test.plot;
 
 (
 Task({
 f = (0, 0.2 .. 1);
 f.do { |u|
 blend(a, b, u).test.plot;
 2.wait;
 SCWindow.allWindows.pop.close; // close last opened window
 }
 }).play(AppClock);
 )

 // in a SynthDef
 (
 SynthDef("Help-EnvBlend", { arg fact = 0;?
Out.ar(0, EnvGen.kr(Env.perc.blend(Env.sine, fact), 1.0, doneAction: 2)?
* SinOsc.ar(440,0,0.1)
)?
}).send(s));

 (
 {
f = (0, 0.1..1);
f.do({|fact| Synth("Help-EnvBlend", [\fact, fact.postln]); 1.wait;});

 }.fork;)
 
delay(delay)

 Returns a new Env based on the receiver in which the start time has been offset by adding a silent segment at the beginning.
delay - The amount of time to delay the start of the envelope.
 
a = Env.perc(0.05, 1, 1, -4);
 b = a.delay(2);
 a.test.plot;
 b.test.plot;

test(releaseTime)

 Test the envelope on the default [Server] with a [SinOsc].
releaseTime - If this is a sustaining envelope, it will be released after this much time in seconds. The default is 3 seconds.
 
plot(size)

 Plot this envelope's shape in a window.
size - The size of the plot. The default is 400.
 
asSignal(length)

 Returns a Signal of size length created by sampling this Env at length number of intervals.
 
asArray

 Converts the Env to an Array in a specially ordered format. This allows for Env parameters to be settable arguments in a [SynthDef]. See example above under *newClear.
 
isSustained

 Returns true if this is a sustaining envelope, false otherwise.

Client-side Access and Stream Support

Sustain and loop settings have no effect in the methods below.

at(time)

 Returns the value of the Env at time.
 
Env.triangle(1, 1).at(0.5);
 
embedInStream

 Embeds this Env within an enclosing [Stream]. Timing is derived from thisThread.beats.

asStream

 Creates a Routine and embeds the Env in it. This allows the Env to function as a [Stream].
 
(
 {
 e = Env.sine.asStream;
 5.do({
 e.next.postln;
 0.25.wait;
 })}.fork
 )