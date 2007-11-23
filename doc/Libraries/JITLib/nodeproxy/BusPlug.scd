
BusPlug		a listener on a bus

superclass: AbstractFunction

a superclass to node proxy that listens to a bus.

it is mainly a basic subclass of NodeProxy, but it can be used as well for other things.
for most methods see NodeProxy.help.


monitor
	returns the current monitor (see Monitor )


//using as a control bus listener

s.boot;
z = Bus.control(s, 16);
a = BusPlug.for(z);

m = { Mix(SinOsc.ar(a.kr(16), 0, 0.1)) }.play;

z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));
z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));
z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));

m.free;


m = { SinOsc.ar(a.kr(2, MouseX.kr(0, 19)), 0, 0.1) }.play; //modulate channel offset

z.setn(Array.rand(16, 300, 1320).put(16.rand, rrand(500, 1000)));


m.free; z.free;

//using as a audio monitor

p = BusPlug.audio(s,2);
d = { Out.ar(p.index, PinkNoise.ar([0.1, 0.1])) }.play;


p.play; //monitor whatever plays in p (the execution order does not matter)



d.free;
d = { Out.ar(p.index, PinkNoise.ar([0.1, 0.1])) }.play;

p.stop;
p.play;

//also p can play to another bus:

p.stop;
p.play(12);

//listen to that bus for a test:
x = { InFeedback.ar(12,2) }.play;
x.free;





