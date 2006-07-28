Node Messaging


The most direct and fast way to send commands to the server is to send messages to the Server object, if you are within sc-lang. If you are in a shell you can use sendOSC (available from CNMAT).

this messaging scheme is explained in detail in 

Server-Architecture
Server-Command-Reference
Tutorial

When creating nodes on the server (synths and groups) the only things we need to know are the nodeID and the server (its address to be precise).

In order to communicate with a synth, one sends messages with its nodeID. If you do not intend to communicate with the node after its creation (and the node will cause itself to end without external messaging), the node id can be set to -1, which is the server's equivalent to nil.

As soon as you want to pass around the reference to a certain node, assuming that you might not have only one server, it can be useful to create a Synth or Group object. These objects also respond to messages, and when needed can be used to obtain the state of the server side node.

see Node, Synth, and Group help for more detailed helpfiles on node objects.


// the equivalent of
 n = s.nextNodeID;
 s.sendMsg("/s_new", "default", n);
 s.sendMsg("/n_free", n);
 
// is 
 n = Synth("default");
 n.free;
 
 
// when passing arguments:
 n = s.nextNodeID;
 s.sendMsg("/s_new", "default", n, 0, 0, \freq, 850);
 s.sendMsg("/n_set", n, \freq, 500);
 s.sendMsg("/n_free", n);
 
// it is
 n = Synth("default", [\freq, 850]);
 n.set(\freq, 500)
 n.free;
 

The answer to the question of whether one should work with node objects or directly with messages depends to some extent on context, and to some extent is a matter of personal taste.

The encapsulation of node objects results in a certain generalization, meaning that other compound objects can respond to the same messages and thus exploit polymorphism. They also provide a certain level of convienence, keeping track of indexes and IDs, etc.

In certain cases, such as for granular synthesis it is recommended to use messages directly, because there is no benefit to be gained from the node objects (i.e. no need to message them) and they add cpu load to the client side.
 
(
 SynthDef("grain", { 
 Out.ar(0, Line.kr(0.1, 0, 0.01, doneAction:2) * FSinOsc.ar(12000))
 }).send(s);
 )
 
 (
 Routine({ 
 20.do({
 s.sendMsg("/s_new", "grain", -1); 
 0.01.wait;
 })
 }).play;
 )


In cases where you need to keep track of the synth's state, it is advisable to use node objects and register them with a NodeWatcher. (see helpfile)

Apart from such cases it is a matter of taste whether you want to use the combination of message and a numerical global representation or an object representation. The two can be mixed, and certain advantages of the object style can be accessed when using messaging style. For instance Server.nextNodeID allows one to use dynamically assigned IDs in messaging style. As a gross generalization, it is probably fair to say that object style is more convienent, but messaging style is more efficient, due to reduce client-side CPU load.

IMPORTANT NOTE: If you wish to have the functionality of the default_group (e.g. problem free use of Server's record and scope functionality) you should treat ID 1 (the default_group) as the root of your node tree rather than ID 0 (the RootNode). See default_group for more details.

Note that Function-play and SynthDef-play return a synth object that can be used to send messages to.

x = { arg freq=1000; Ringz.ar(Crackle.ar(1.95, 0.1), freq, 0.05) }.play(s);
x.set(\freq, 1500);
x.free;





