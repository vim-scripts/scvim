
pvcalc2		Process the bins of two FFT chains

	chain = chain.pvcalc2(chain2, numframes, func, frombin, tobin, zeroothers)

pvcalc2 is just like pvcalc but can combine two FFT chains together. See pvcalc for more information.

func should be a function that takes four arrays as inputs (magnitudes1, phases1, magnitudes2, phases2) and returns a resulting pair of arrays [magnitude, phase].


Example

(
s.boot.doWhenBooted{
~fftsize = 1024;
b = Buffer.alloc(s, ~fftsize, 1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
d = Buffer.alloc(s, ~fftsize, 1);
//// Load a second audio file of some sort:
//e = Buffer.read(s,"sounds/amenfast.wav");
e = Buffer.read(s,"sounds/break.aiff");
}
)

(
x = {
	var in, chain, in2, chain2, out;
	in = PlayBuf.ar(1, c.bufnum, BufRateScale.kr(c.bufnum), loop: 1);
	chain = FFT(b.bufnum, in);
		
	in2 = PlayBuf.ar(1, e.bufnum, BufRateScale.kr(e.bufnum), loop: 1);
	chain2 = FFT(d.bufnum, in2);
	
	chain = chain.pvcalc2(chain2, b.numFrames, {|mags, phases, mags2, phases2|
		[mags * mags2 / 10, phases2 + phases]
	}, frombin: 0, tobin: 125, zeroothers: 0);
	
	out = IFFT(chain);
	Out.ar(0, 0.5 * out.dup);
}.play(s);
)
x.free;


