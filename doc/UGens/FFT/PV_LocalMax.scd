PV_LocalMax pass bins which are a local maximum

PV_LocalMax.ar(buffer, threshold)

Passes only bins whose magnitude is above a threshold and above their nearest neighbors.
buffer - fft buffer.
threshold - magnitude threshold.

s.boot;

(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-localMax", { arg out=0, bufnum=0;
 var in, chain;
 in = Mix.arFill(3, { LFSaw.ar(exprand(100, 500), 0, 0.1); });
 chain = FFT(bufnum, in);
 chain = PV_LocalMax(chain, MouseX.kr(0, 50)); 
 Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)

(
SynthDef("help-localMax2", { arg out=0, bufnum=0, soundBufnum=2;
 var in, chain;
 in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
 chain = FFT(bufnum, in);
 chain = PV_LocalMax(chain, MouseX.kr(0, 100)); 
 Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)


