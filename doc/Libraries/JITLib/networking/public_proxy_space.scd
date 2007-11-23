
public ProxySpace				distributed system


this is an example how to create a networked proxyspace.


Using a dispatch such as Public, a changes to a ProxySpace can be transmitted by code to a remote (or local) other ProxySpace and is compiled there as well. This is very flexible and leightweight but it also means that one has to be careful not to do harm to other systems. Code is only sent if it interprets without error on the sender side. Timing is still not yet synchronized, although it works pretty well for not too costly code.

see Public help for more about the configuration.
	
	
// example
	
	

(
var addresses;

Public.startListen;
addresses = [NetAddr("127.0.0.1", 57120)];

a = ProxySpace(s);
b = ProxySpace(s);

d = Public(a);
e = Public(b);

a.dispatch = d;
b.dispatch = e;


d.addresses = addresses;
e.addresses = addresses;

e.join(\waitingroom, \eve);
d.join(\waitingroom, \ade);
e.sendingKeys = \all;
d.sendingKeys = \all;
d.listeningKeys = \all;
e.listeningKeys = \all;
)

(
d.makeLogWindow; // see what is going on
e.makeLogWindow;
)

// modify space

s.boot; // boot server


a[\out].play; // play here
a[\out] = { PinkNoise.ar(0.1 ! 2) }; // set here
b[\out].play; // play here too
b[\out] = {SinOsc.ar(rrand(300, 400)) ! 2 * 0.1 }; // two different tones
b[\out] = {SinOsc.ar(300) ! 2 * 0.1 }; // same tone
d.public = false; // be private
b[\out] = { PinkNoise.ar(0.1 ! 2) };
d.public = true;

// you can also enter the space:
a.push;
	~out.free;
a.pop; // exit



// now you can type into both of them, just as in examples in ProxySpace.help:
(
var str;
str = "\n ~out = { LFNoise2.ar(3000 + exprand(1.0, 2000), 0.1) }; "; // example string
EnvirDocument(a, "a", str);
EnvirDocument(b, "b", str);
)






