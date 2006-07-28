Delay1 single sample delay

Delays the input by 1 sample.
Delay1.ar(in, mul, add)

in - input to be delayed.

(
plot({
 var z;
 z = Dust.ar(1000);
 [z, z - Delay1.ar(z)] // [ original, subtract delayed from original ]
}))



