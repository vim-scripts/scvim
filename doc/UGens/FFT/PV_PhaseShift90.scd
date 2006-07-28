PV_PhaseShift90 shift phase by 90 degrees 
PV_PhaseShift90.ar(buffer)

Shift phase of all bins by 90 degrees.
buffer - fft buffer

Server.internal.boot;

b = Buffer.alloc(Server.internal,2048,1);
c = Buffer.alloc(Server.internal,2048,1);

(
{ arg out=0, bufnum=0;
 var in, fft, fft2, shifted;
 in = SinOsc.ar(500, 0, 0.4);
 fft = FFT(b.bufnum, in);
 fft2 = FFT(c.bufnum, in);
 shifted = PV_PhaseShift90(fft); 
 Out.ar(0, [IFFT(fft2),IFFT(shifted)]); 
}.scope
)