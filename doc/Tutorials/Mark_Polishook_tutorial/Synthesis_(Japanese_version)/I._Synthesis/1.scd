
1.

2

SuperColliderSuperCollider

2

MIDISuperCollider 3



SuperCollider 3



////////////////////////////////////////////////////////////////////////////////////////////////////

SuperCollider 3

////////////////////////////////////////////////////////////////////////////////////////////////////

////////////
// 1
// define a simple synthesis process and schedule one synthesis event (on one machine)
// 

// 1
s = Server("thisMachine", NetAddr("localhost", 57110));	// "localhost""127.0.0.1"IP

// 2
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);

// 3
s.sendMsg("s_new", "sine", 1000, 1, 0);


////////////////////////////////////////////////////////////////////////////////////////////////////

////////////
// 2
// 12



// 1 ... 
// IP2 ...
// 2 ...
s = Server("thisMachine", NetAddr("... an ip number ...", 57110));

// 2 ... 
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);

// 3 .... 
s.sendMsg("s_new", "sine", 1000, 1, 0);


////////////////////////////////////////////////////////////////////////////////////////////////////

IP

// 
s = Server("thisMachine", NetAddr("localhost", 57110));	
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);
s.sendMsg("s_new", "sine", 1000, 1, 0);

vs.

// 
s = Server("thisMachine", NetAddr("... an ip number ...", 57110));
// 
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);
s.sendMsg("s_new", "sine", 1000, 1, 0);

////////////////////////////////////////////////////////////////////////////////////////////////////


