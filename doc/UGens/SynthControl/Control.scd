Control

superclass: MultiOutUGen

Used to bring signals and floats into the ugenGraph function of your SynthDef. This is the UGen that delivers the args into your function. 

Generally you do not create Controls yourself. (See Arrays example below)

The rate may be either .kr (continous control rate signal) or .ir (a static value, set at the time the synth starts up, and subsequently unchangeable).

SynthDef creates these when compiling the ugenGraph function. They are created for you, you use them, and you don't really need to worry about them if you don't want to.

SynthDef("help-Control",{ arg freq=200;

 freq.inspect; // at the time of compiling the def

}).writeDefFile;

What is passed into the ugenGraph function is an OutputProxy, and its source is a Control.


The main explicit use of Control is to allow Arrays to be sent to running Synths:

// a synth def that has 4 partials
(
s = Server.local;
SynthDef("help-Control", { arg out=0,i_freq;
 var klank, n, harm, amp, ring;
 n = 9;
 
 // harmonics
 harm = Control.names([\harm]).ir(Array.series(4,1,1).postln);
 // amplitudes
 amp = Control.names([\amp]).ir(Array.fill(4,0.05));
 // ring times
 ring = Control.names([\ring]).ir(Array.fill(4,1));
 
 klank = Klank.ar(`[harm,amp,ring], {ClipNoise.ar(0.003)}.dup, i_freq);
 
 Out.ar(out, klank);
}).send(s);
)

// nothing special yet, just using the default set of harmonics.
a = Synth("help-Control",[\i_freq, 300]);
b = Synth("help-Control",[\i_freq, 400]);
c = Synth("help-Control",[\i_freq, 533.33]);
d = Synth("help-Control",[\i_freq, 711.11]);

a.free;
b.free;
c.free;
d.free;

// in order to set the harmonics amps and ring times at
// initialization time we need to use an OSC bundle.
(
s.sendBundle(nil,
 ["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
 ["/n_setn", 2000, "harm", 4, 1, 3, 5, 7] // set odd harmonics
 );
)

s.sendMsg("/n_free", 2000);

(
s.sendBundle(nil,
 ["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
 // set geometric series harmonics
 ["/n_setn", 2000, "harm", 4] ++ Array.geom(4,1,1.61)
 );
)

s.sendMsg("/n_free", 2000);

(
// set harmonics, ring times and amplitudes
s.sendBundle(nil,
 ["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
 ["/n_setn", 2000, "harm", 4, 1, 3, 5, 7], // set odd harmonics
 ["/n_setn", 2000, "ring", 4] ++ Array.fill(4,0.1), // set shorter ring time
 ["/n_setn", 2000, "amp", 4] ++ Array.fill(4,0.2) // set louder amps
 );
)

s.sendMsg(\n_trace, 2000);
s.sendMsg(\n_free, 2000);

(
// same effect as above, but packed into one n_setn command
s.sendBundle(nil,
 ["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
 ["/n_setn", 2000, "harm", 4, 1, 3, 5, 7,
 "ring", 4] ++ Array.fill(4,0.1)
 ++ ["amp", 4] ++ Array.fill(4,0.2)
 );
)

s.sendMsg(\n_trace, 2000);
s.sendMsg(\n_free, 2000);