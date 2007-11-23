
PV_RandWipe				crossfade in random bin order

PV_RandWipe(bufferA, bufferB, wipe, trig)

Cross fades between two sounds by copying bins in a random order.
bufferA - fft buffer A.
bufferB - fft buffer B.
wipe - copies bins from bufferB in a random order as wipe goes from 0 to 1.
trig - a trigger selects a new random ordering.

See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
)

(
//trig with MouseY
SynthDef("help-randWipe", { arg out=0, bufnumA=0, bufnumB=1;
	var inA, chainA, inB, chainB, chain;
	inA = Mix.fill(6, { LFSaw.ar(exprand(400, 1000), 0, 0.1) });	inB = Mix.fill(6, {
		LFPulse.ar(exprand(80, 400), 0, 0.2, SinOsc.kr(8.0.rand, 0, 0.2).max(0))
	});
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_RandWipe(chainA, chainB, MouseX.kr, MouseY.kr > 0.5);
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum ]);
)

b.free; c.free;


