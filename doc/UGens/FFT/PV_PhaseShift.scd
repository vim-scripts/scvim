PV_PhaseShift 

PV_PhaseShift.ar(buffer, shift)

buffer - fft buffer.
shift - phase shift in degrees.

s.boot;

b = Buffer.alloc(s,2048,1);

(
SynthDef("help-phaseShift", { arg out=0, bufnum=0, soundBufnum=2;
 var in, chain;
 in = SinOsc.ar(500);
 chain = FFT(bufnum, in);
 chain = PV_PhaseShift(chain, LFNoise2.kr(1, 180, 180)); 
 Out.ar(out, 0.5 * IFFT(chain).dup); 
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)

