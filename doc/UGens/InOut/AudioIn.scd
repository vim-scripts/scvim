
AudioIn			read audio input

AudioIn.ar(channel, mul, add)

Reads audio from the sound input hardware.
channel - input channel number to read.
	Channel numbers begin at 1.

// watch the feedback

// patching input to output
(
SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar(1)
	)
}).play;
)

// stereo through patching from input to output
(
SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar([1,2])
	)
}).play;
)


