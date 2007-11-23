

BPZ2					two zero fixed midpass

BPZ2.ar(in, mul, add)

A special case fixed filter. Implements the formula:

out(i) = 0.5 * (in(i) - in(i-2))

This filter cuts out 0 Hz and the Nyquist frequency.
Compare:

{ WhiteNoise.ar(0.25) }.play;

{ BPZ2.ar(WhiteNoise.ar(0.25)) }.play;



