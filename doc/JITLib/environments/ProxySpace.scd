ProxySpace an environment of references on a server 

superclass: LazyEnvir 


Generally a proxy is a placeholder for something, which in this case 
is something playing on a server that writes to a limited number of busses.
(this can be for example a synth or an event stream)



When accessed, ProxySpace returns a [NodeProxy]. 

The rate is determined in a lazy way from the first object put into this environment. 
Once it is created it can only be set to a function that returns the same rate and a number 
of channels equal to the intial one or smaller. see [the_lazy_proxy]

if the ugen function's number of channels is smaller, the offset in 'put' can be used to offset the ugens
if the number of channels is larger, the outputs will wrap around and mix accordingly.


// note that the two expressions are equivalent: 
~out = something;  
currentEnvironment.put(\out, something);

a proxyspace can be created when its server is not running and played later.


 

Note:
The following examples can be executed line by line, usually in any order. 
code that should be evaluated together is set in parentheses.




class methods


*new(server, name, clock)
 
server: a Server object. note that on remote computers the clock must be in sync
name: a symbol. if a name is given, the proxy space is stored in ProxySpace.all under this name.
clock: for event-based or beat-sync playing use a TempoClock.
 
*push(server, name, clock)
 
replace the currentEnvironment with a new ProxySpace and clear the current one, if
 it is a ProxySpace (this is to avoid piling up proxy spaces in performance).

In order to move to another ProxySpace while keeping the current,
 use pop and then push a new one.To have multiple levels of proxy spaces, 
 use .new.push;
 
*pop
restore the previous currentEnvironment
 



 
 
instance methods

 
play(key)
returns a group that plays the NodeProxy at that key. 
 default key: \out
 
record(key, path, headerFormat, sampleFormat)
 
returns a RecNodeProxy that records the NodeProxy at that key
 
ar(key, numChannels, offset)
 kr(key, numChannels, offset)
 
returns a NodeProxy output that plays the NodeProxy at that key,
 to be used within a function used as input to a node proxy
 
wakeUp
 when the proxyspace is created without a running server this method can be used
 to run it (internally this is done by play(key) as well.
 
 
fadeTime_ set the fadetime of all proxies as well as the default fade time
 
clock_ set the clock of all proxies as well as the default clock.
 
free(fadeTime) free all proxies (i.e. free also the groups)
 
release(fadeTime) release all proxies (i.e. keep the groups running)
 
clear(fadeTime) clear the node proxy and remove it from the environment. 
 this frees all buses. If a fadeTime is given, first fade out, then clear.
 
 
*clearAll clear all registered spaces
 
 
 

"garbage collecting":

clean(exclude)
 free and remove all proxies that are not needed in order to play the 
 ones passed in with 'exclude'. if none are passed in, all proxies
 that are monitoring (with the .play message) are kept as well as their parents etc. 
 
reduce(to)
 free all proxies that are not needed in order to play the 
 ones passed in with 'to'. if none are passed in, all proxies
 that are monitored (with the play message) are kept as well as their parents etc.


storing
 
 document(keys)
 creates a new document with the current proxyspace state. This does not allow
 open functions as proxy sources. see: [jitlib_asCompileString]
keys: list of keys to document a subset of proxies
 

for more examples see: [proxyspace_examples] [jitlib_basic_concepts_01]







// examples

(
s = Server.local;
s.boot;
p = ProxySpace.push(s);
)

~out.play;

~out = { SinOsc.ar([400, 407] * 0.9, 0, 0.2) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * LFPulse.kr([1, 1.3]) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * ~x.value };

~x = {?LFPulse.kr([1, 1.3] * MouseX.kr(1, 30, 1)) };

~out = { SinOsc.ar([400, 437] * Lag.kr(0.1 + ~x, 0.3), 0, 0.2) * ~x };

p.fadeTime = 5;

~out = { SinOsc.ar([400, 437] * 1.1, 0, 0.2) * ~x.kr(2) };

p.end(8); // end all in 8 sec.


p.clear.pop; // remove all, move out.







