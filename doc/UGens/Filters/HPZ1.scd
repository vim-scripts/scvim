

HPZ1					two point difference filter

HPZ1.ar(in, mul, add)

A special case fixed filter. Implements the formula:

out(i) = 0.5 * (in(i) - in(i-1))

which is a two point differentiator.
Compare:

{ WhiteNoise.ar(0.25) }.play;

{ HPZ1.ar(WhiteNoise.ar(0.25)) }.play;



