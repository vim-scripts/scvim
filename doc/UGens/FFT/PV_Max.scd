
PV_Max					maximum magnitude

PV_Max(bufferA, bufferB)

Output copies bins with the maximum magnitude of the two inputs.
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
var exBuf;
	CocoaDialog.getPaths({ arg paths; //get a second soundfile;
	paths.do({ arg p; exBuf = Buffer.read(s, p);

SynthDef("help-max", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum1=2, soundBufnum2 = 3;
	var inA, chainA, inB, chainB, chain ;
	inA = PlayBuf.ar(1, soundBufnum1, BufRateScale.kr(soundBufnum1), loop: 1);
	inB = PlayBuf.ar(1, soundBufnum2, BufRateScale.kr(soundBufnum2), loop: 1);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_Max(chainA, chainB);
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum1, d.bufnum, \soundBufnum2, exBuf.bufnum]);
	})
},{
	"cancelled".postln;
});
)

b.free; c.free; d.free;


