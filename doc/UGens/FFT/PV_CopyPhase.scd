PV_CopyPhase copy magnitudes and phases

PV_CopyPhase.ar(bufferA, bufferB)

Combines magnitudes of first input and phases of the second input.

bufferA - fft buffer A.
bufferB - fft buffer B.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
d = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-copyPhase", { arg out=0, bufnumA=0, bufnumB=1;
 var inA, chainA, inB, chainB, chain;
 inA = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800)); inB = WhiteNoise.ar(0.2);
 chainA = FFT(bufnumA, inA);
 chainB = FFT(bufnumB, inB);
 chain = PV_CopyPhase(chainA, chainB); 
 Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum ]);
)

(
SynthDef("help-copyPhase2", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
 var inA, chainA, inB, chainB, chain;
 inA = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
 inB = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800));
 chainA = FFT(bufnumA, inA);
 chainB = FFT(bufnumB, inB);
 chain = PV_CopyPhase(chainA, chainB); 
 Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);

)
