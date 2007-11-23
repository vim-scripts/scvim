
Timing in NodeProxy		4

Changes that happen to NodeProxy, most importantly setting its source, are normally done
whenever the put method is called (or, in ProxySpace, the assignment operation = ).
Sometimes it is desirable to time these changes relative to a clock.

previous: jitlib_basic_concepts_03		next: JITLib


a) clock
b) quant and offset
c) client and server tempo
d) sample accurate output



a) clock

generally, every node proxy can have its own time base, usually
a tempo clock. the clock is responsible for the timing of insertion
of new functions, per default at the next beat of the clock.



p = ProxySpace.push(s.boot);
~x.play; ~y.play;

// these two synths are started at the time when they are inserted:
~x = { Ringz.ar(Impulse.ar(1), 400, 0.05) };
~y = { Ringz.ar(Impulse.ar(1), 600, 0.05) };

// adding a common clock:
~x.clock = TempoClock.default;
~y.clock = TempoClock.default;

// now they are in sync
~x = { Ringz.ar(Impulse.ar(1), 400, 0.05) };
~y = { Ringz.ar(Impulse.ar(1), 600, 0.05) };

// for simplicity, one can provide a clock for a whole proxy space:

p.clock = TempoClock.default;
~y = { Ringz.ar(Impulse.ar(1), 800, 0.05) };

~z.play;
~z = { Ringz.ar(Impulse.ar(1), [500, 514], 0.8) };
~z = { Ringz.ar(Impulse.ar(1), exprand(300, 400 ! 2), 0.8) };
~z = { Ringz.ar(Impulse.ar(2), exprand(300, 3400 ! 2), 0.08) };
~z.end;



sequence of events:
When inserting a new function into the proxy, the synthdef is built, sent to the server
who sends back a message when it has completed. Then the proxy waits for the next beat to start
the synth. When using node proxies with patterns, the patterns are played using the clock as a scheduler.



b) quant and offset


In order to be able to control the offset/quant point of insertion, the 'quant' instance variable can be used,
which can be either a number or an array of the form [quant, offset], just like in pattern.play(quant).

~y.quant = [1, 0.3]; // offset of 0.3, quant of 1.0
~y = { Ringz.ar(Impulse.ar(1), 600, 0.05) };


quant and offset scheduling is used for the following operations:
play, put, removeAt, setNodeMap, wakeUp, rebuild (and the rebuild operations lag, setRates, bus_)





c) connecting client and server tempo

a ProxySpace has the method makeTempoClock, which creates an instance of TempoBusClock
together with a node proxy (~tempo) which it keeps in sync.


p.makeTempoClock(2.0); // create a new tempoclock with 2 beats/sec

~y.quant = 1; // set the quant back to 1 and the offset to 0
~y = { Ringz.ar(Impulse.ar(~tempo.kr), 600, 0.05) }; // impulse uses tempo
~x = Pbind(\instrument, \default, \freq, Pseq([300, 400], inf)); // pattern uses tempoclock

p.clock.tempo = 1.0; // set the tempo to 1
p.clock.tempo = 2.2; // set the tempo to 2.2

~x.free;
~y.free;




d) sample accurate output

for efficiency, NodeProxy uses a normal Out UGen for writing to its bus. If sample accurate
playback is needed (OffsetOut), the ProxySynthDef class variable sampleAccurate can be set to true:


// example

ProxySynthDef.sampleAccurate = false;

~x.play;

// the grain frees itself
~x = { SinOsc.ar(800) * EnvGen.ar(Env.perc(0.001, 0.03, 0.4), doneAction:2) };

	
// jittery tone.
(
r = Routine {
	loop {
		200.do { arg i;
			~x.spawn;
			(0.005).wait;
		};
		1.wait;
	}
}.play;
)

ProxySynthDef.sampleAccurate = true;

// steady tone, because sample accurate.

~x.rebuild;

r.stop;

p.clear; // remove all.	





previous: jitlib_basic_concepts_03



