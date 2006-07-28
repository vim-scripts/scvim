BufDelayC buffer based simple delay line with cubic interpolation

BufDelayC.ar(buf, in, delaytime, mul, add)
BufDelayC.kr(buf, in, delaytime, mul, add)

Simple delay line with cubic interpolation which uses a buffer for its internal memory. See also [BufDelayN] which uses no interpolation, and [BufDelayL] which uses linear interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also [DelayC].

buf - buffer number.
in - the input signal.
delaytime - delay time in seconds.


// allocate buffer
b = Buffer.alloc(s,44100,1);

(
// Dust randomly triggers Decay to create an exponential 
// decay envelope for the WhiteNoise input source
{
z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);
BufDelayC.ar(b.bufnum, z, 0.2, 1, z); // input is mixed with delay via the add input
}.play
)

