
PV_BrickWall				zero bins

PV_BrickWall(buffer, wipe)

Clears bins above or below a cutoff point.
buffer - fft buffer.
wipe - can range between -1 and +1.
if wipe == 0 then there is no effect.
if wipe > 0 then it acts like a high pass filter, clearing bins from the bottom up.
if wipe < 0 then it acts like a low pass filter, clearing bins from the top down.

See also FFT Overview.

s.boot;

b = Buffer.alloc(s,2048,1);

(
SynthDef("help-brick", { arg out=0, bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_BrickWall(chain, SinOsc.kr(0.1));
	Out.ar(out, IFFT(chain));
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)

b.free;


