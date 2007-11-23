
PV_Diffuser				random phase shifting

PV_Diffuser(buffer, trig)

Adds a different constant random phase shift to each bin.
The trigger will select a new set of random phases.
buffer - fft buffer.
trig - a trigger selects a new set of random values.

See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
//trig with MouseY
SynthDef("help-diffuser", { arg out=0, bufnum=0 ;
	var in, chain;
	in = Mix.ar(SinOsc.ar(200 * (1..10), 0, Array.fill(10, {rrand(0.1, 0.2)}) ));
	chain = FFT(bufnum, in);
	chain = PV_Diffuser(chain, MouseY.kr > 0.5 );
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum ]);
)

(
//trig with MouseY
SynthDef("help-diffuser2", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_Diffuser(chain, MouseY.kr > 0.5 );
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)

b.free; c.free;


