
TwoZero two zero filter

TwoZero.ar(in, freq, radius, mul, add)

A two zero filter. 
in - input signal to be processed
freq - frequency of zero angle.
radius - radius of zero. 

{ TwoZero.ar(WhiteNoise.ar(0.125), XLine.kr(20,20000,8), 1) }.play

