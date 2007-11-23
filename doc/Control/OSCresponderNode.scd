
OSCresponderNode			client side network responder


Register a function to be called upon receiving a specific command from a specific OSC address.
same interface like OSCresponder, but allows multiple responders to the same command.

note that OSCresponderNode evaluates its function in the system process.
in order to access the application process (e.g. for GUI access ) use { ... }.defer;



Setting up OSCresponder for listening to a remote application

// example: two SuperCollider apps communicating

// application 1:
n = NetAddr("127.0.0.1", 57120); // the url should be the one of computer of app 2 (or nil)

o = OSCresponder(n, '/chat', { |t, r, msg| ("time:" + t).postln; msg[1].postln }).add;

// application 2:
m = NetAddr("127.0.0.1", 57120); // the url should be the one of computer of app 1
m.sendMsg("/chat", "Hello App 1");

// sending bundles (including timestamps)
(
m.sendBundle(2.0, ["/chat", "Hello App 1"], ["/chat", "Hallo Wurld"]);
m.sendBundle(0.0, ["/chat", "Hello App 1"], ["/chat", "Hallo Wurld"]);
)

// end application 2:
m.disconnect;

// end application 1:
n.disconnect; o.remove;


Sending data from server to client

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

// end of group message

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


Watching for errors

// example from ServerErrorGui in crucial lib

f = OSCresponderNode(s.addr, '/fail', { arg time, responder, msg;
	{
		var mins,secs;
		mins = (time/60).round(1);
		secs = (time%60).round(0.1);
		if(secs<10,{ secs = "0"++secs.asString; },{ secs=secs.asString;});
		// put this on a gui
		//errors.label = "% % (%:%)".format(msg[1], msg[2], mins, secs);
		//errors.stringColor = Color.white;
		"% % (%:%)".format(msg[1], msg[2], mins, secs).postln;
	}.defer
});
f.add;

// cause a failure
Synth("gthhhhppppppp!");

f.remove
		




