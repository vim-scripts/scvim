
FFT			 Fast Fourier Transform

The fast fourier transform analyzes the frequency content of a signal. See also FFT Overview.

	FFT(buffer, input)
	
FFT uses a local buffer for holding the buffered audio. The window size corresponds to the buffer size, which must be a multiple of the control block size as well as being a power of two.

The overlap between frames defaults to 50%, and the window defaults to a Hann window. These are good choices for phase-vocoder manipulation; for other settings see the advanced options below.


s = Server.local.boot;

b = Buffer.alloc(s,2048,1);

(
SynthDef("help-noopFFT", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.05);
	chain = FFT(bufnum, in);
	chain.inspect; // its an FFT
	Out.ar(out,
		IFFT(chain) // inverse FFT
	);
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-sineFFT", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	chain = FFT(bufnum, in);
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-magAbove", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	//in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_MagAbove(chain, 310);
	Out.ar(out, 0.5 * IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-brick", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_BrickWall(chain, SinOsc.kr(0.1));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-randcomb", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.8);
	chain = FFT(bufnum, in);
	chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-rectcomb", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_RectComb(chain, 8, LFTri.kr(0.097,0,0.4,0.5),
		LFTri.kr(0.24,0,-0.5,0.5));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-magFreeze", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
	chain = FFT(bufnum, in);
	// moves in and out of freeze
	chain = PV_MagFreeze(chain, SinOsc.kr(-0.2) );
	Out.ar(out, 0.5 * IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)


Advanced options

The full list of arguments is

	FFT(buffer, input, hop, wintype, active)

where:

hop is the amount of offset from one FFT analysis frame to the next, measured in multiples of the analysis frame size. This can range between zero and one, and the default is 0.5 (meaning each frame has a 50% overlap with the preceding/following frames).
wintype defines how the data is windowed:
	-1 is for rectangular windowing, simple but typically not recommended;
	0 (the default) is for Welch windowing, typically recommended for phase-vocoder work;
	1 is for Hann windowing, typically recommended for analysis work.
active is a simple control allowing FFT analysis to be active (>0) or inactive (<=0). This is mainly useful for signal analysis processes which are only intended to analyse at specific times rather than continuously.

Note that for phase-vocoder usage, changing the "advanced" settings from their defaults will typically result in unnatural sound when used in combination with IFFT, due to windowing artifacts. (A hop of 0.25,with Hann windowing, can be a useful combination for phase-vocoder work.)



