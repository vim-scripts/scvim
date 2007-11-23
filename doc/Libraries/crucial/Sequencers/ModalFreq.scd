
ModalFreq

Control rate player

For backwards compatiblity and convenience. This actually returns a Patch on the pseudo-ugen ModalFreqUGen.

Takes floats or player inputs and puts out control rate signal of frequency.

	ModalFreq.new( degree, scaleArray, root, octave, stepsPerOctave )

Used as a kr rate Player.
(
m = 	ModalFreq.new(
			StreamKrDur.new(Pbrown(1,12,2,inf), 0.25, 0.1),
			FloatArray[ 0, 1, 2, 3, 4, 7,10 ],
			StreamKrDur.new(Pseq(#[ 7, 6,1,10 ], inf), 0.25, 0.1),
			StreamKrDur(Pbrown(2,6,1),Prand([0.25,1.0,4.0,8.0])),
			12
		);
	
Patch({ arg freq=200;
	Pulse.ar(
		[freq, freq * 0.5],
		LFNoise1.kr([0.3,0.1],0.5,0.5),
		0.2)
},[
	m
]).play

)


Used as a Stream. Can also be used with Pbind or any other Pattern.
Not as efficient as using it directly as a Player.
(

Patch({ arg freq=100,amp=1.0;
		SinOsc.ar([freq,freq + 30],0,amp)
	},[	
		StreamKrDur(
			ModalFreq(Pseq([1,2,3,4],inf)),
			Pseq([0.25,0.5,0.75],inf),
			0.1),
		1
	]).play;

)



