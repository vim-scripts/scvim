PV_RandComb pass random bins

PV_RandComb.ar(buffer, wipe, trig)

Randomly clear bins.
buffer - fft buffer.
wipe - clears bins from input in a random order as wipe goes from 0 to 1.
trig - a trigger selects a new random ordering.

s.boot;

(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-randcomb", { arg out=0, bufnum=0;
 var in, chain;
 in = {WhiteNoise.ar(0.8)}.dup;
 chain = FFT(bufnum, in);
 chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4)); 
 Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)

(
//trig with MouseY
SynthDef("help-randcomb2", { arg out=0, bufnum=0, soundBufnum=2;
 var in, chain;
 in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
 chain = FFT(bufnum, in);
 chain = PV_RandComb(chain, MouseY.kr, Impulse.kr(0.4)); 
 Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)