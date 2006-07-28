Ndef node proxy definition

superclass: NodeProxy



reference to a proxy, forms an alternative to ProxySpace

Ndef(key) returns the instance, Ndef(key, obj) stores the object and returns the instance, like Tdef and Pdef.
see also ProxySpace, NodeProxy


*new(key, object)
 craete a new node proxy and store it in a global dictionary under key.
 if there is already an Ndef there, replace its object with the new one.
 The object can be any supported class, see NodeProxy help.
 if key is an association, it is interpreted as server -> key.
 
*clear 
 clear all proxies

*at(server, key)
return an instance at that key for that server
 
defaultServer_(a server)
set the default server (default: Server.local)


// examples

s = Server.local.boot;

Ndef(\sound).play;
Ndef(\sound).fadeTime = 1;
Ndef(\sound, { SinOsc.ar([600, 635], 0, SinOsc.kr(2).max(0) * 0.2) });
Ndef(\sound, { SinOsc.ar([600, 635] * 3, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
Ndef(\sound, { SinOsc.ar([600, 635] * 2, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
Ndef(\sound, Pbind(\dur, 0.17, \freq, Pfunc({ rrand(300, 700) })) );

Ndef(\lfo, { LFNoise1.kr(3, 400, 800) });
Ndef(\sound).map(\freq, Ndef(\lfo));
Ndef(\sound, { arg freq; SinOsc.ar([600, 635] + freq, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
Ndef(\lfo, { LFNoise1.kr(300, 400, 800) });

Ndef.clear; //clear all


recursion:

Ndefs can be used recursively.
a structure like the following works:


Ndef(\sound, { SinOsc.ar([600, 635], Ndef(\sound).ar * 10, LFNoise1.kr(2).max(0) * 0.2) });
Ndef(\sound).play;

this is due to the fact that there is a feedback delay (the server's block size), usually 64 samples,
so that calculation can reiterate over its own outputs.

