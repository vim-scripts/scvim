IFFTInverse Fast Fourier Transform

The inverse fast fourier transform converts from frequency content to a signal. See also [FFT Overview].

 IFFT(buffer)

s = Server.local; 

b = Buffer.alloc(s,2048,1);


SynthDef("help-noopFFT", { arg out=0,bufnum=0;
 var in, chain;
 in = WhiteNoise.ar(0.01);
 chain = FFT(bufnum, in);
 chain.inspect; // its an FFT
 Out.ar(out, 
 IFFT(chain) // inverse FFT
 );
}).play(s,[\out,0,\bufnum,b.bufnum]);

See FFT for more examples.