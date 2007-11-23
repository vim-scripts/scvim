
SynthDesc			description of a synth definition


Contains a description of a SynthDef, including its name, control names and default values.
Information is also stored on its outputs and inputs and whether it has a gate control.



	*read(path, keepDefs, dict)
					adds all synthDescs in a path to a dict

	SynthDescs are created by SynthDescLib, by reading a compiled synth def file.

			SynthDescLib.global.read("synthdefs/default.scsyndef");
			SynthDescLib.global.synthDescs.at(\default)

	name			returns the name of the SynthDef
	controlNames		returns an array of instances of ControlName, each of which
					have the following fields: name, index, rate, defaultValue
	
			SynthDescLib.global.synthDescs.at(\default).controlNames.postln;
	
	hasGate			is true if the Synthdef has a gate input
	msgFunc			the function which is used to create an array of arguments for
					playing a synth def in patterns
					
			SynthDescLib.global.synthDescs.at(\default).msgFunc.postcs;

SynthDescs are needed by the event stream system, so when using Pbind and NotePlayer,
the instruments' default parameters are derived from the SynthDesc.


aSynthDef.store also creates a synthDesc in the global library:


	(
	SynthDef("test", { arg out, freq, xFade;
		XOut.ar(out, xFade, SinOsc.ar(freq))
	}).store
	);

	SynthDescLib.global.browse; // browse the properties of SynthDescs




