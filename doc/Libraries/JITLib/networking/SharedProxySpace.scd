
SharedProxySpace			distributed system

experimental.

superclass: ProxySpace




	*new(broadcastServer, name, clock)
		return a new instance. the server should be a fresh, unused BroadcastServer
	
	*push(broadcastServer, name, clock)
		return a new instance and make it the currentEnvironment
	
	broadcast
		return the broadcast server
		
	server
		return the home server
	
	makeSharedProxy(key, rate, numChannels)
		create a SharedNodeProxy with a group id that is derived from the
		key: only short strings work. This should be done with a fresh, unused server.
	
	
	addSharedKeys(controlKeys, audioKeys, firstAudioKey)
		create multiple SharedNodeProxies.
		This should be done with a fresh, unused server
			controlKeys: names of the control rate proxies
			audioKeys: names of the audio rate proxies
			firstAudioKey: if the above are not given, generate them automatically.
							using the letters a-z.
							this is a character (default: $s) of the first audio key in alphabet
	
	




// examples:

// prepare and boot two servers
(
x = NetAddr("127.0.0.1", 57201);
y = NetAddr("127.0.0.1", 57202);

a = BroadcastServer(\B1, x, nil, 0).allAddr_( [x, y]);
b = BroadcastServer(\B2, y, nil, 1).allAddr_( [x, y]);

a.boot;
b.boot;
a.makeWindow;
b.makeWindow;
)


(
p = SharedProxySpace.new(a, "Elizabeth");
r = SharedProxySpace.new(b, "George");

// this has to be done with the fresh servers:
p.makeSharedProxy(\ensemble, \audio, 1);
r.makeSharedProxy(\ensemble, \audio, 1);
)

p.envir[\ensemble]; // returns a shared node proxy.


// Elizabeth pushes her proxspace:
p.push;
currentEnvironment === p;

~out.play; // play locally

// play sine tone with freq dependant on ensemble, but a little random.
~out = { SinOsc.ar(440 + (300 * ~ensemble.ar) + Rand(0, 10), 0, 0.1) };
~ensemble = 1; // tune up a bit;
~ensemble = {Line.ar(0, 2, 10) };


// Henry pushes his proxyspace
r.push;
~out.play;
~out = {Ringz.ar(Impulse.ar(9, 0, 0.8), ~ensemble.ar * 300 + 400, 0.2) };
~ensemble = 0.5; // now both depend on the "same" bus.
~ensemble = { SinOsc.ar(0.4, 0, 0.6) };

// Elizabeth

p.push;

~freq = 300 * ~ensemble + 400;
~out = { SinOsc.ar(~freq.ar * [1, 1.02], SinOsc.ar(~freq.ar, 0, pi)) * 0.1 };

~out.stop; // stop only locally

// Henry

r.push;
~out.stop; // stop only locally


// finish:
r.clear;
p.clear;


// quit the servers
a.quit;
b.quit;



