
NodeProxy		a reference on a server

superclass: BusPlug


Generally a proxy is a placeholder for something, which in this case
is something playing on a server that writes to a limited number of busses.

(this can be for example a synth or an event stream). The rate and number
of channels is determined either when the instance is created (.control/.audio)
or by lazy initialisation from the first source.[the_lazy_proxy]
These objects can be replaced, mapped and patched and used for calculation.

ProxySpace returns instances of NodeProxy. all the examples below apply to ProxySpace accordingly:

a = NodeProxy(s) 	is equivalent to ~a;
a.source = ...		is equivalent to ~a = ...
a[3] = ...			is equivalent to ~a[3] = ...

see also: [jitlib_efficiency]




note that NodeProxy plays on a private bus.
if you want to hear the output, use p.play and p.stop.
free only the inner players:		 	p.free
for free inner players and stop listen:	p.end
entirely removing all inner settings:  	p.clear



instance creation

	*new(server)
	*audio(server, numChannels)
	*control(server, numChannels)



reading from the bus


	play(index, numChannels, group, multi)
		play output on specified bus index (default: public busses)
		this works like a monitor.
		if multi is set to true it can create multiple monitors
	stop(fadeTime)
		stop to play out public channels (private channels keep playing as others might listen still)
		this stop the monitoring. to stop the objects playing, use free, release
		fadeTime: decay time for this action
	
	end(fadeTime)
		releases the synths and stops playback
		fadeTime: decay time for this action
		
		
	ar(numChannels)
	kr(numChannels)
	
		return a link to my output, which is limited by [numChannels]
		causes an uninitialized proxy to create a matching bus.
	
	normally ar defaults to stereo, kr to mono. this can be set in the classvars:
	defaultNumAudio, defaultNumControl
	

supported inputs
			
	NodeProxy					played by reading from
	Function					interpreted as UGenFunc
	SimpleNumber				used to write to bus continously
	Bus						reads from that bus
	SynthDef					plays a synth from the def
	Symbol					plays a synth from the def with this name
	Pattern					played as event pattern
	Stream					played as event stream
	nil						removes all objects
	Pdef						played like a stream
	Task						played, no output assigned
	Tdef						played like Task
	AbstractPlayer			started in a separate bus, mapped to this bus
	Instr					converted to player and started
	
	Associations:
	(\filter -> func)			filter previous input
	(\set -> event pattern)		set controls
	
	
setting the source:


	source_(anObject)
		play a new synth through me, release old one.
		anObject can be one of the supported inputs (see above)
			[only if the used synthdef (applies also to patterns) has the right number of channels
			and an out argument, this can be used to do filtering.
			if you supply a gate, the nodeProxy will assume doneAction 2 and fade out].
			
	prime(anObject)
		set source without starting the synth. To start it, send can be used later.
		running synths are released
		
	add(anObject, channelOffset, extraArgs)
		play a new synth, add it to the present ones
	
	removeAt(index)
		remove the synth at index i and its player definition
	
	removeLast
		remove the last synth and its player definition
	
	put(index, anObject, channelOffset, extraArgs, now)
		set the source by index.
			index:	
						where the object should be placed in the internal order.
						if -1, all objects are freed
			anObject:	
						can be a Function, an Instr, any valid UGen input
						a pattern can be used if it returns an EventStream.
			channelOffset:	
						using a multichannel setup it can be useful to set this.
						when the objects numChannels is smaller than the proxy
						
			extraArgs: 	extra arguments that can be sent with the object directly (not cached)
			
			now			if set to false, only prepare the source and do not start the object (see prime)
			
	put can be used as array indexing: a[0] = { SinOsc.ar }
	one can put an object at any index, only the order of indices is relevant.
	if the index equals an existing index, the object at this index is replaced.
	using multiple index expands into multiple objects: a[0..3] = ... or a[[0, 4, 6]] = [ .., ..., ..]
	
	pause
		pause all objects and set proxy to paused
	
	resume
		if paused, start all objects



	
	
group-like behaviour:

	set(key, val, ...)
		I behave like my nodeMap: see [NodeMap]
		set, setn, unset, unmap
		
	map(key(s), proxy, ... )
		map the arguments in keys to the subsequent channels of a control proxy
		(keys can be a symbol or a number)
		if the proxy has multiple channels, subsequent channels of the control,
		if present, are mapped (mapn)
			note that you should not map to more channels than the control has.
		
	setn(key, list, ...)
		set ranges of controls
	
	run(flag)
		pause/unpause all synths in the group
		
	

extended group-like behaviour:
	
	xset(key, val, ...)
		set with crossfade into new setting
		
	xmap(keys, proxy)
		map with crossfade into new setting
	
	xsetn()
		untested
	
	lag(key, val, ...)	
		set the lag values of these args (identical to setRates)
		to remove these settings, use: lag(\key1, nil, key2, nil, ...)
	
	setRates(key, rate1, ...)
		set the default rate (\tr, \ir, numerical) for synthDef arg
		rate of nil removes setting



bus-like behaviour:

	line(value, dur)
		set my bus to the new value in dur time linearly
	xline(value, dur)
		set my bus to the new value in dur time exponentially
	gate(value, dur)
		gate my bus to the level value for dur time
		
	// do not work properly yet !
	lineAt(key, value, dur)
		set the control value to the new value in dur time linearly
	xlineAt(key, value, dur)
		set control value to the new value in dur time exponentially
	gateAt(key, value, dur)
		gate my control to the level value for dur time.
		if the control was not set before, stay at the new value




	
sending synths to server
	(normally the source_() message does the sending already, but it can be used for spawning)
	
	wakeUp
			until the proxy is not used by any output ( either .play or .ar/.kr )
			it is not running on the server. you can wake it up to force it playing.
			normally this is not needed.
	
	send(argList, index, freeLast)
		send a new synth without releasing the old one.
		the argument list is applied to the synth only.
		freeLast: if to free the last synth at that index
		if index is nil, sends all
		
	sendAll(argList, freeLast)
		send all synths without releasing the old one.
		the argument list is applied to all synths.
		freeLast: if to free present synths
	
	
			
release and cleaning up:

	free(fadeTime)
		release all my running synths and the group
		fadeTime: decay time for this action
	
	release(fadeTime)
		release running synths
		fadeTime: decay time for this action
	
	clear(fadeTime)
		reset everything to nil, neutralizes rate/numChannels
		if a fadeTime is given, first fade out, then clear.
	

setting properties:
	
	fadeTime_(time)
		set the attack/release time
	
	clock_(aClock)
		use a tempo clock for scheduling beat accurate
	
	
misc:

	record(path, headerFormat, sampleFormat)
		record output to file (returns a [RecNodeProxy] that you can use for control)
		returns a [RecNodeProxy]
	
	*defaultNumAudio_(n)
		set the default channel number for audio busses
	
	*defaultNumControl_(n)
		set the default channel number for control busses
		
_________________________________________________________



for more examples see [ProxySpace]	



// examples
s = Server.local;
s.boot;


using node proxy with ugen functions


a = NodeProxy.audio(s, 2);
a.play; // play to hardware output, return a group with synths

// setting the source
a.source = { SinOsc.ar([350, 351.3], 0, 0.2) };

// the proxy has two channels now:
a.numChannels.postln;
a.source = { SinOsc.ar([390, 286] * 1.2, 0, 0.2) };

// exeeding channels wrap:
a.source = { SinOsc.ar([390, 286, 400, 420, 300] * 1.2, 0, 0.2) };

// other inputs
a.source = { WhiteNoise.ar([0.01,0.01]) };
a.source = 0;
a.source = \default; // synthDef on server
a.source = SynthDef("w", { arg out=0; Out.ar(out,SinOsc.ar([Rand(430, 600), 600], 0, 0.2)) });
a.source = nil; // removes any object

// feedback
a.source = { SinOsc.ar(a.ar * 7000 * LFNoise1.kr(1, 0.3, 0.6) + 200, 0, 0.1) };
a.source = { SinOsc.ar(a.ar * 6000 * MouseX.kr(0, 2) + [100, 104], 0, 0.1) };

// fadeTime
a.fadeTime = 2.0;
a.source = { SinOsc.ar([390, 286] * ExpRand(1, 3), 0, 0.2) };


// adding nodes
a.add({ SinOsc.ar([50, 390]*1.25, 0, 0.1) });
a.add({ BrownNoise.ar([0.02,0.02]) });

// setting nodes at indices:
a[0] = { SinOsc.ar( 700 * LFNoise1.kr(1, 0.3, 0.6) + 200, 0, 0.1) };
a[1] = { LFPulse.kr(3, 0.3) * SinOsc.ar(500, 0, 0.1) };
a[2] = { LFPulse.kr(3.5, 0.3) * SinOsc.ar(600, 0, 0.1) };
a[3] = { SinOsc.ar([1,1.25] * 840, 0, 0.1) };

// filtering: the first argument is the previous bus content. more args can be used as usual.
a[3] = \filter -> { arg in; in * SinOsc.ar(Rand(100,1000)) };
a[2] = \filter -> { arg in; in * MouseY.kr(0,1) };
a[8] = \filter -> { arg in; in * MouseX.kr(0,1) };
a[4] = \filter -> { arg in; in * SinOsc.ar(ExpRand(1,5)).max(0) };



// setting controls
a.fadeTime = 2.0;
a.source = { arg f=400; SinOsc.ar(f * [1,1.2] * rrand(0.9, 1.1), 0, 0.1) };
a.set(\f, rrand(900, 300));
a.set(\f, rrand(1500, 700));
a.xset(\f, rrand(1500, 700)); // crossfaded setting
a.source = { arg f=400; RLPF.ar(Pulse.ar(f * [1,1.02] * 0.05, 0.5, 0.2), f * 0.58, 0.2) };

// control lags
a.fadeTime = 0.01;
a.lag(\f, 0.5); // the objects are built again internally and sent to the server.
a.set(\f, rrand(1500, 700));
a.lag(\f, nil);
a.set(\f, rrand(1500, 700));
a.fadeTime = 1.0;

// mapping controls to other node proxies

c = NodeProxy.control(s, 2);
c.source = { SinOsc.kr([10,20] * 0.1, 0, 150, 1300) };
a.map(\f, c);
a[0] = { arg f=400; RHPF.ar(Pulse.ar(f * [1,1.2] * 0.05, 0.5, 0.2), f * 0.58, 0.2) };
c.source = { SinOsc.kr([10,16] * 0.02, 0, 50, 700) };
c.source = { Line.kr(300, 1500, 10) + SinOsc.kr(20 * [1,2], 0, 100) };
a[1] = { arg f; LFPar.ar(f % MouseX.kr(1, 40, 1) * 4 + 360, 0, 0.2) };

// map multiple channels of one proxy to multiple controls of another
// recently changed behaviour!

a.source = { arg f=#[400, 400]; LPF.ar(Pulse.ar(f[0] * [0.4,1], 0.2, 0.2), f[1] * 3) };
a.map(\f, c); // multichannel proxy c is mapped to multichannel control of a
a.source = { arg f=#[400, 400]; LPF.ar(Pulse.ar(f, 0.2, 0.2), f[1]) };
a.source = { arg f=#[400, 400]; Formant.ar(140, f * 1.5, 100, 0.1) };
c.source = { SinOsc.kr([Line.kr(1, 30, 10), 1], 0, [100, 700], [300, 700]) };
c.source = 400;


c.fadeTime = 5.5;
c.source = { LFNoise0.kr([2.3, 1.0], [100, 700], [300, 1700]) };
c.source = { SinOsc.kr([2.3, 1.0], 0, [100, 700], [300, 1700]) };
c.source = 400;


// behave like a sc2 plug
c.gate(1400, 0.1);
c.gate(1000, 0.1);
c.line(1000, 1);

// direct access
a.lineAt(\f, 300, 2);
a.xlineAt(\f, 600, 0.3);
a.gateAt(\f, 1600, 0.3);


// changing nodeMaps
a.unmap(\f);
n = a.nodeMap.copy;
n.set(\f, 700);
a.fadeToMap(n);
n = a.nodeMap.copy;
n.set(\f, 400);
a.fadeTime = 1.0;
a.fadeToMap(n, [\f]); // linear interpolation to new map: experimental
a.map(\f, c); // restore mapping


// sending envelopes (up to 8 levels)
w = Env.new(Array.rand(3, 400, 1000),Array.rand(2, 0.3, 0.001), -4);
c.env(w);
c.env(w);
w = Env.new(Array.rand(8, 400, 1000),Array.rand(7, 0.03, 0.1));
c.env(w);
c.env(w);

// stop synthesis, then wake up proxies:

a.stop; // stop the monitor
a.play; // start the monitor
a.end;	// release the synths and stop the monitor
c.free; // free the control proxy c



channel offset/object index

a = NodeProxy.audio(s,2);
a.play;
a[0] = { Ringz.ar(Impulse.ar(5, 0, 0.1), 1260) };
a.put(1, { Ringz.ar(Impulse.ar(5.3, 0, 0.1), 420) }, 1);
a.put(0, { Ringz.ar(Dust.ar([1,1]*15.3, 0.1), 720) }, 1);
a.put(1, { Ringz.ar(Impulse.ar(5.3, 0, 0.1), 420) }, 1);
a.end;



beat accurate playing


a = NodeProxy.audio(s,2);
a.play;

a.clock = TempoClock(2.0).permanent_(true); // round to every 2.0 seconds
a.source = { Ringz.ar(Impulse.ar(0.5, 0, 0.3), 3000, 0.01) };
a[1] = { Ringz.ar(Impulse.ar([0.5, 1], 0, 0.3), 1000, 0.01) };
a[2] = { Ringz.ar(Impulse.ar([3, 5]/2, 0, 0.3), 8000, 0.01) };
a[3] = { Ringz.ar(Impulse.ar([3, 5]*16, 0, 0.3), 5000, 0.01) * LFPulse.kr(0.5, 0, 0.05) };

a.removeLast;
a.removeAt(2);

a.clear;

using patterns - event streams



(
// must have 'out' or 'i_out' argument to work properly
SynthDef("who", { arg freq, gate=1, out=0, ffreq=800, amp=0.1;
	var env;
	env = Env.asr(0.01, amp, 0.5);
	Out.ar(out, Pan2.ar(
		Formant.ar(freq, ffreq, 300, EnvGen.kr(env, gate, doneAction:2)), Rand(-1.0, 1.0))
	)
}).store;

)


(
s.boot;
a = NodeProxy.audio(s, 2);
a.fadeTime = 2;
b = NodeProxy.audio(s,2);
b.fadeTime = 3;
)

a.play; // monitor output

// play the pattern silently in b
b.source = Pbind(\instrument, \who, \freq, 500, \ffreq, 700, \legato, 0.02);

// play b out through a:
a.source = b;

// filter b with ring modulation:
a.source = { b.ar * SinOsc.ar(SinOsc.kr(0.2, 300, 330)) }; // filter the input of the pattern
a.source = { b.ar * LFCub.ar([2, 8], add: -0.5) }; // filter the input of the pattern

a.source = b;

// map b to another proxy
c = NodeProxy.control(s, 1).fadeTime_(1);
c.source = { SinOsc.kr(2, 0, 400, 700) };


// now one can simply embed a control node proxy into an event pattern.
// (this works not for \degree, \midinote, etc.)
// embedding in other patterns it will still return itself.


b.source = Pbind(\instrument, \who, \freq, 500, \ffreq, c, \legato, 0.02);

c.source = { SinOsc.kr(SinOsc.kr(0.2, 0, 10, 10), 0, 400, 700) };

c.source = { LFNoise1.kr(5, 1300, 1500) };
c.source = { MouseX.kr(100, 5500, 1) };

(
b.source = Pbind(
			\instrument, \who,
			\freq, Pseq([600, 350, 300],inf),
			\legato, 0.1,
			\ffreq, Pseq([c, 100, c, 100, 300, 600], inf), // use proxy in a pattern
			\dur, Pseq([1, 0.5, 0.75, 0.25] * 0.4, inf),
			\amp, Pseq([0.2, 0.2, 0.1, 0.1, 0.2], inf)
		);
)



b[2] = Pbind(\instrument, \who, \freq, 620, \ffreq, Prand([500,c],inf), \legato, 0.1, \dur, 0.1);
b[3] = Pbind(\instrument, \who, \ffreq, 5000, \freq, Pseq([720, 800],inf), \legato, 0.1, \dur, 0.1, \amp, 0.01);
b[4] = Pbind(\instrument, \who, \freq, Pseq([700, 400],inf), \legato, 0.1, \ffreq, 200);
b[1] = { WhiteNoise.ar([0.01,0.01]) };
b[4] = { arg ffreq=800; Resonz.ar(WhiteNoise.ar([1,1]), ffreq, 0.05) };


b.map(\ffreq, c); // map the control to the proxy
b.removeLast;
b.removeLast;
a.source = { b.ar * WhiteNoise.ar(0.1, 1) };
a.source = { b.ar * WhiteNoise.ar(0.1, 1) + (b.ar * SinOsc.ar(SinOsc.kr(0.01, 0, 50, 330))) };

c.source = { XLine.kr(1900, 10, 10) };

a.clear; b.clear; c.clear; // clear all, free bus








