PV_RectComb make gaps in spectrum

PV_RectComb.ar(buffer, numTeeth, phase, width)

Makes a series of gaps in a spectrum. 
buffer - fft buffer.
numTeeth - number of teeth in the comb.
phase - starting phase of comb pulse.
width - pulse width of comb.

s.boot;

b = Buffer.alloc(s,2048,1);

(
SynthDef("help-rectcomb", { arg out=0, bufnum=0;
 var in, chain;
 in = {WhiteNoise.ar(0.2)}.dup;
 chain = FFT(bufnum, in);
 chain = PV_RectComb(chain, 8, LFTri.kr(0.097, 0, 0.4, 0.5), 
 LFTri.kr(0.24, 0, -0.5, 0.5)); 
 Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)

(
SynthDef("help-rectcomb2", { arg out=0, bufnum=0;
 var in, chain;
 in = {WhiteNoise.ar(0.2)}.dup;
 chain = FFT(bufnum, in);
 chain = PV_RectComb(chain, MouseX.kr(0, 32), MouseY.kr, 0.2); 
 Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)
