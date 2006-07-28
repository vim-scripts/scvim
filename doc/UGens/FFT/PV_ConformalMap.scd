PV_ConformalMap complex plane attack 

PV_ConformalMap.ar(buffer, real, imag)

Applies the conformal mapping z -> (z-a)/(1-za*) to the phase vocoder bins z with a given by the real and imag imputs to the UGen.

ie, makes a transformation of the complex plane so the output is full of phase vocoder artifacts but may be musically fun. Usually keep |a|<1 but you can of course try bigger values to make it really noisy. a=0 should give back the input mostly unperturbed.

See http://mathworld.wolfram.com/ConformalMapping.html

buffer - buffer number of buffer to act on, passed in through a chain (see examples below).
real - real part of a. 
imag - imaginary part of a.


//explore the effect
(
SynthDef("conformer1", {
 var in, chain;
 in = AudioIn.ar(1,0.5);
 chain = FFT(0, in);
 chain=PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(-1.0,1.0));
 Out.ar(0, Pan2.ar(IFFT(chain),0));
}).load(s);
)

s.sendMsg("/b_alloc", 0, 1024, 1);
s.sendMsg("/s_new", "conformer1", 2002, 1, 0);
s.sendMsg("/n_free", 2002);



(
SynthDef("conformer2", {
 var in, chain, out;
 in = Mix.ar(LFSaw.ar(SinOsc.kr(Array.rand(3,0.1,0.5),0,10,[1,1.1,1.5,1.78,2.45,6.7]*220),0,0.3));
 chain = FFT(0, in);
 chain=PV_ConformalMap(chain, MouseX.kr(0.01,2.0, 'exponential'), MouseY.kr(0.01,10.0, 'exponential'));
 out=IFFT(chain);
 
 Out.ar(0, Pan2.ar(CombN.ar(out,0.1,0.1,10,0.5,out),0));
}).load(s);
)


s.sendMsg("/b_alloc", 0, 2048, 1);
s.sendMsg("/s_new", "conformer2", 2002, 1, 0);
s.sendMsg("/n_free", 2002);
