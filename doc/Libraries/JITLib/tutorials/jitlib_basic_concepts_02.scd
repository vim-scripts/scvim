
proxy space - basic concepts 		2


external structure of the node proxy, referencing in proxyspace and environments.

previous: jitlib_basic_concepts_01		next: jitlib_basic_concepts_03



a) 	normal environment lookup
b) 	proxyspace as an environment
c) 	using the proxyspace to change processes on the fly
d) 	when are the node proxies initialized?
e) 	moving out of the proxy space
f ) 	using ProxySpace together with other Environments





a) normal environment lookup



currentEnvironment.postln; // anEnvironment (if not, you haven't left it from last helppage..)

~a; // access the environment: there is nothing stored: nil
~a = 9; // store something
~a; 	// now 9 is stored
~a + 100; // calculate with it

currentEnvironment.postln; // the value is stored in the environment

~b + ~a; // cause an error: ~y is nil.
~b = -90; // set ~y

~b + ~a; // this works.

// note that you can always access environments (or ProxySpaces) from outside as well:

x = currentEnvironment;
x[\a] + x[\b] // equivalent to ~b + ~a

// or, if "know" is true,
x.know = true;
x.a + x.b;





	further readings: Environment





b) proxyspace as an environment


one can replace the current environment with a special type of environment, a proxy space
this environment represents processes that play audio on a server.


p = ProxySpace.new(s); // create a new environment, store it in variable p for now.
p.push;				// push it, so i becomes the current environment.
currentEnvironment.postln;
currentEnvironment === p; // this is identical.

~x;		 // accessing creates a NodeProxy (uninitialized) automatically.
~x + ~y; 	// this works immediately, because the lookup does not return nil,
	  // but a placeholder (proxy) instead

p.postln; // now there is two placeholders in the environment.






c) using the proxyspace to change processes on the fly


// boot the server
s.boot;


// as soon as a sound function (or any compatible input) is assigned to a proxy
// this sound plays on its own private bus (so it is not audible yet.)
(
~x = {
	
	RLPF.ar(Impulse.ar(4) * 20, [850, 950], 0.2)
	
}
)

// the proxy has been initialized by its first assignment.
// it plays at audio rate (because we have assigned an audio rate ugen function)
// and it has two channels (because the function has stereo output)

~x.index; // what bus index is it? this posts the index to the postwindow
		// before it was .ir(nil), now it is initialized to .ar(2)
~x.bus // what bus is it?


~x.play; // now listen to it. a monitor is created (see Monitor) that plays
		// the signal onto a public bus. This is independent of the proxy itself.
		// for further info see: jitlib_basic_concepts_03 (part c)



// the sound function can be changed at any time:
(
~x = {
		RLPF.ar(Impulse.ar([5, 7]) * 5, [1450, 1234], 0.2)
}
)

// You can tune a sound function to your liking very easily
// by replacing it with little (or big) variations:

		// filter freqs higher:
~x = {	RLPF.ar(Impulse.ar([5, 7]) * 5, [1800, 2000], 0.2) }
		
		// same pulse ratio (5/8), different pulse tempo:
~x = {	RLPF.ar(Impulse.ar([5, 8] * 3.2) * 5, [1800, 2000], 0.2) }

		// different filter:
~x = {	Ringz.ar(Impulse.ar([5, 8] * 3.2), [1800, 2000], 0.05) }

// and if you set the proxy's fadeTime, you can create little
// textures by hand:

~x.fadeTime = 3;
		// different filter freqs every time:
~x = {	Ringz.ar(Impulse.ar([5, 8] * rrand(0.5, 1.5)) * 0.5, ({ exprand(200, 4000) } ! 2), 0.05) }



// here is another proxy:
~y = { Pan2.ar(Dust.ar(20), 0) };

~y.bus; // it has two channels, just as the ~x., but it plays on another (private) bus.

// note that ~y is not audible directly,
// but it can be used in any other proxy:
(
~x = {
	
	RLPF.ar(~y.ar * 8, [1450, 1234], 0.2)
}
)

// when the proxy changes, the result changes dynamically:

~y = {Impulse.ar(MouseX.kr(2, 18, 1)) * [1, 1] };

~y = {PinkNoise.ar(MouseX.kr(0, 0.2) * [1, 1]) };

~y = {Impulse.ar([MouseX.kr(2, 18, 1), MouseY.kr(2, 18, 1)]) };



// stop listening. the proxies run in the background.

~x.stop;

~y.bus; // ~y is playing on another bus.
~x.bus; // than ~x

// we can also listen to ~y directly:
~y.play;

// to remove an input, nil can be used:

~y = nil;

// stop listening
~y.stop;


	further readings: proxyspace_examples Bus AbstractFunction UGens





d) when are the node proxies initialized?

bus initialization of a node proxy happens as soon as it is used for the first time.
later inputs are adjusted to this bus, as far as it is possible.


~z2 = { LFNoise0.kr([1, 2, 3, 4]) }; // a four channel control rate proxy
~z2.bus.postln;

~z100 = 0.5; // a constant value causes a single channel control rate proxy.
~z100.bus.postln;

~z34.ar(3) 		// the first access allocates the bus
~z34.bus.postln;	 // a 3 channel audio proxy

// these initializations can be removed by using clear:
~z34.clear;
~z34.bus.postln;

This initialisation happens whenever the proxy is first used. Later, the proxy can
be accessed with other rate/numChannels combinations as needed (rates are converted,
numChannels are extended by wrapping).

Note that this might cause ambiguous initialisation in which case the proxy should
be always initialized first. A typical problem is demonstrated here:

~u.play(0, 2); 	// initialize 2 audio channels (default). 0 is the output bus number.
				// if the proxy is not inititialized, play defaults to 2 channels.
				// here it is explicitly given only to make it more clear.
~u = { PinkNoise.ar(0.2) }; // use only one
~u.numChannels; // 2 channels
~u.clear;

if evaluated the other way round, only one channel is used:

~u = { PinkNoise.ar(0.2) }; // initialize 1 audio channel
~u.play(0, 2); 	// play 2 channels: the 1 channel is expanded into 2.
				// numChannels of .play defaults to the proxy's numChannels.
				// here it is explicitly given, so to expand the channels
~u.numChannels; // 1 channel
~u.clear;

Thus it can be useful to explicitly initialize proxies that use variable type inputs:

~b.kr(8); ~c.ar; // explicit initialisation
p.postln;		// post the whole proxy space



e) moving out of the proxy space:


// play the audio:
~x.play;

~x = { PinkNoise.ar(0.5) };

// p is the proxy space:
p.postln;

// to end all processes in p, use end:
p.end(2) // 2 seconds fade out.

// to remove all bus objects and free them from the bus allocato, use clear:
p.clear;

currentEnvironment.postln;

// restore original environment:

p.pop;

currentEnvironment.postln;

~a + ~b; // the old values are still here.

p === currentEnvironment; // this is not the case anymore.

// remove the content, so the garbage collector can release their memory.
p.clear;

// note that if you use this kind of accessing scheme, the objects are not garbage collected
// until the keys are set to nil. This is a common mistake when using normal environments.

// clear all in the normal environment:

currentEnvironment.clear;





f) using ProxySpace together with other Environments

using proxy space as an access scheme for node proxies can get in the way of the
normal use of environments as pseudo variables. Here is some ways to cope with this.

// if you want to keep using the current environment as usual, you can restrict the
// scope of proxyspace to one document (note: this is mac-only currently)

EnvirDocument(p, "proxyspace"); 	// to test this, check for currentEnvironment here
							// and in the envir document.

// you can also access the proxy space indirectly:
p[\x].play;
p[\x] = { SinOsc.ar(450, 0, 0.1) };

// or: when the proxyspace is pushed, you can use a normal environment indirectly:
p.push;
d = ();
d[\buffer1] = Buffer.alloc(s, 1024);
d.use { ~buffer1.postln; ~zz = 81; }; // for more than one access to the environment, use use


// to access the inner environment of proxy space directly,
// without creating new proxies, use .envir:

p.envir.postln;
p.envir[\x].postln;

// this can be useful for lookup, when you want to know if a certain proxy exists already.
// direct access would create that proxy, which would not make sense in that case.



previous: jitlib_basic_concepts_01		next: jitlib_basic_concepts_03


