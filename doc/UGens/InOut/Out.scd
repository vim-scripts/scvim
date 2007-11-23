
Out				write a signal to a bus

superclass: AbstractOut

*ar(bus, channelsArray) - write a signal to an audio bus.
*kr(bus, channelsArray) - write a signal to a control bus.
	
bus - the index of the bus to write out to. The lowest numbers are written to the audio hardware.
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

N.B. Out is subject to control rate jitter. Where sample accurate output is needed, use OffsetOut.		
Note that using the Bus class to allocate a multichannel bus simply reserves a series of adjacent bus indices with the Server object's bus allocators. abus.index simply returns the first of those indices. When using a Bus with an In or Out ugen there is nothing to stop you from reading to or writing from a larger range, or from hardcoding to a bus that has been allocated. You are responsible for making sure that the number of channels match and that there are no conflicts.

See the Server-Architecture and Bus helpfiles for more information on buses and how they are used.

	(
	SynthDef("help-out", { arg out=0, freq=440;
		var source;
			source = SinOsc.ar(freq, 0, 0.1);

			// write to the bus, adding to previous contents
			Out.ar(out, source);

	}).send(s);
	)
	
	
	Synth("help-out", [\freq, 500]);
	Synth("help-out", [\freq, 600]);
	Synth("help-out", [\freq, 700]);


