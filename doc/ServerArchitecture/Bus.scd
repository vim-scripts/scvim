
Bus

The clientside representation of an audio or control bus on a server. Encapsulates all the OSC messages a Bus can receive. Manages allocation and deallocation of bus indices so that you don't need to worry about conflicts. The number of control busses, audio busses, and input and output busses is fixed and cannot be changed after the server has been booted. For more information see ClientVsServer and Server-Architecture.

Note that using the Bus class to allocate a multichannel bus does not 'create' a multichannel bus, but rather simply reserves a series of adjacent bus indices with the bus' Server object's bus allocators. abus.index simply returns the first of those indices. When using a Bus with an In or Out ugen there is nothing to stop you from reading to or writing from a larger range, or from hardcoding to a bus that has been allocated. You are responsible for making sure that the number of channels match and that there are no conflicts.

You can control which allocator determines the bus index numbers by setting the server options blockAllocClass variable prior to booting the server. Two allocators are available to support different kinds of applications. See the ServerOptions help file for details.

Class Methods

Bus.control(server, numChannels);
	Allocate a control bus on the server. 
	Defaults: default server, 1 channel.
	
Bus.audio(server, numChannels);
	Allocate an audio bus on the server.
	Defaults: default server, 1 channel.
	
Bus.alloc(rate, server, numChannels);
	Allocate a bus of either rate as specified by the symbols:
		\control or \audio
		
Bus.new(rate, index, numChannels);
	This method does not allocate a bus index, but assumes that you
	already have allocated the appropriate bus index and can supply it
	yourself.
	

Instance Methods

index - Get the Bus' index.
	
free - Return the bus' indices to the server's bus allocator so they can be reallocated.
	
rate - Get the Bus' rate. This is a symbol, either \control or \audio.
	
numChannels - Get the Bus' number of channels.

server - Get the Bus' server object.

asMapArg - Returns a symbol consisting of the letter 'c' followed by the bus's index. This may be used when setting a synth node's control inputs to maps the input to the control bus. See the Node help file for more information on mapping controls to buses.

Note: It is impossible to map a synth control to an audio rate bus. Calling this method on an audio bus will throw an error.

(
var	ffreqbus = Bus.control(s, 1),
	rqbus = Bus.control(s, 1);

SynthDef(\rlpf, { |bus, ffreq, rq|
	ReplaceOut.ar(bus, RLPF.ar(In.ar(bus, 1), ffreq, rq))
}).play(s, [\ffreq, ffreqbus.asMapArg, \rq, rqbus.asMapArg]);
)

Asynchronous Control Bus Methods

The following commands apply only to control buses and are asynchronous. For synchronous access to control buses one should use the internal server's shared control buses and SharedIn / SharedOut.

value_(aFloat) - Set all channels to this float value. This command is asynchronous.
	
set(...values) - A list of values for each channel of the control bus. The list of values supplied should not be greater than the number of channels. This command is asynchronous.

setn(values) - As set but takes an array as an argument.
	
get(action) - Get the current value of this control bus. This command is asynchronous. action is a function that will be evaluated when the server responds, with the current value of the bus passed as an argument. For multichannel buses use getN.

getn(count, action) - Get the current values of this control bus. This command is asynchronous. count is the number of channels to read, starting from this bus' first channel. action is a function that will be evaluated when the server responds, with the current values of the bus in an array passed as an argument.

OSC Bundle Methods

getMsg - Returns a msg of the type /c_get for use in osc bundles.

getnMsg(count) - Returns a msg of the type /c_getn for use in osc bundles. count is the number of channels to read, starting from this bus' first channel. The default is this bus' numChannels.

setMsg(... values) - Returns a msg of the type /c_set for use in osc bundles.

setnMsg(values) - Returns a msg of the type /c_setn for use in osc bundles. values is a an array of values to which adjacent channels should be set, starting at this bus' first channel.

fillMsg(value) - Returns a msg of the type /c_fill for use in osc bundles. value is the value to which this bus' channels will be set.


s = Server.local;
s.boot;
	
(
// something to play with
SynthDef("help-Bus", { arg out=0,ffreq=100;
	var x;
	x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1),
			 ffreq, 0.1)
			 .clip2(0.4);
	Out.ar(out, x);
}).send(s);

)

x = Synth("help-Bus");

// get a bus
b = Bus.control(s);

// map the synth's second input (ffreq) to read
// from the bus' output index
x.map(1,b.index);

// By setting the bus' value you send a /c_fill message
// to each channel of the bus setting it to supplied float value
b.value = 100;
b.value = 1000;
b.value = 30;

// Since this is a single channel bus this has the same effect
b.set(300);
b.numChannels.postln;

// multi-channel: b.set(300,350);
// Get the current value. This is asynchronous so you can't rely on it happening immediately.
(
a = "waiting";
b.get({arg value; a = value; ("after the server responds a is set to:" + a).postln;});
("a is now:" + a).postln;
)

x.free;

b.free; // release it so it may be reallocated!

	


