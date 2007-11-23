
PV_Add	 	complex addition

PV_Add(bufferA, bufferB)

Complex Addition: RealA + RealB, ImagA + ImagB
bufferA - fft buffer A.
bufferB - fft buffer B.
See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
d = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-add", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum;
	var inA, chainA, inB, chainB, chain ;
	inA = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum) * 0.5, loop: 1);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_Add(chainA, chainB);
	Out.ar(out, 0.1 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
)

b.free; c.free; d.free;


