DelayL simple delay line with linear interpolation

DelayL.ar(in, maxdelaytime, delaytime, mul, add)
DelayL.kr(in, maxdelaytime, delaytime, mul, add)

Simple delay line with linear interpolation. See also [DelayN] which uses no interpolation, and [DelayC] which uses cubic interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also [BufDelayL].

in - the input signal.
maxdelaytime - the maximum delay time in seconds. used to initialize the delay buffer size.
delaytime - delay time in seconds.

(
// Dust randomly triggers Decay to create an exponential 
// decay envelope for the WhiteNoise input source
{
z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);
DelayL.ar(z, 0.2, 0.2, 1, z); // input is mixed with delay via the add input
}.play
)

