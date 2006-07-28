
HPZ2 two zero fixed highpass

HPZ2.ar(in, mul, add)

A special case fixed filter. Implements the formula:

out(i) = 0.25 * (in(i) - (2*in(i-1)) + in(i-2))

Compare:

{ WhiteNoise.ar(0.25) }.play;

{ HPZ2.ar(WhiteNoise.ar(0.25)) }.play;

