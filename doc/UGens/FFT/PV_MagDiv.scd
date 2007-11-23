
PV_MagDiv			division of magnitudes

PV_MagDiv(bufferA, bufferB,  zeroed)

Divides magnitudes of two inputs and keeps the phases of the first input.
bufferA - fft buffer A.
bufferB - fft buffer B.
zeroed - number to use when bins are zeroed out, i.e. causing division by zero (defaults to 0.0001)

See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
d = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-MagDiv", { arg out=0, bufnumA=0, bufnumB=1;
	var inA, chainA, inB, chainB, chain;
	inA = WhiteNoise.ar(0.2);
	inB = LFSaw.ar(100, 0, 0.2);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_MagDiv(chainA, chainB);
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum ]);
)

(
SynthDef("help-MagDiv2", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
	var inA, chainA, inB, chainB, chain;
	inA = LFSaw.ar([100, 150], 0, 0.2);
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT(bufnumA, inA);
	chainA = PV_RandComb(chainA, MouseY.kr, Impulse.kr(0.4));
	chainB = FFT(bufnumB, inB);
	chain = PV_MagDiv(chainA, chainB, 1);
	Out.ar(out, 0.1 * IFFT(chain));
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
)

b.free; c.free; d.free;


