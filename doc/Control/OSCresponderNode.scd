OSCresponderNode client side responder


Register a function to be called upon receiving a specific command from a specific OSC address.
same interface like OSCresponder, but allows multiple responders to the same command.

note that OSCresponderNode evaluates its function in the system process.
in order to access the application process (e.g. for GUI access ) use { ... }.defer;






// example from SendTrig

(
s = Server.local;
s.boot;
s.notify;
)

(
SynthDef("help-SendTrig",{
 SendTrig.kr(Dust.kr(1.0), 0, 0.9);
}).send(s);

// register to receive this message
a = OSCresponderNode(s.addr, '/tr', { arg time, responder, msg;
 [time, responder, msg].postln;
}).add;
b = OSCresponderNode(s.addr, '/tr', { arg time, responder, msg;
 "this is another call".postln;
}).add;
)


x = Synth.new("help-SendTrig");
a.remove;
b.remove;
x.free;


Watching for something specific

s.boot;

a = OSCresponderNode(s.addr,'/n_end',{ arg time,responder,msg;
 [time, responder, msg].postln;
 if(msg[1] == g.nodeID,{
 "g is dead !".postln;
 // g = Group.new;
 });
}).add;

g = Group.new;

g.free;

a.remove;


Errors
from ServerErrorGui in crucial lib

f = OSCresponderNode(s.addr, '/fail', { arg time, responder, msg;
 {
 var mins,secs;
 mins = (time/60).round(1);
 secs = (time%60).round(0.1);
 if(secs<10,{ secs = "0"++secs.asString; },{ secs=secs.asString;});
 // put this on a gui
 //errors.label = msg[1].asString + msg[2].asString + "("++(mins.asString++":"++secs)++")";
 //errors.stringColor = Color.white;
 (msg[1].asString + msg[2].asString + "("++(mins.asString++":"++secs)++")").postln;
 }.defer
});
f.add;

// cause a failure
Synth("gthhhhppppppp!");

f.remove
 


