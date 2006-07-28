Channel

output a fixed number of channels of a larger input array that can be moved across.
In this way it is similar to the In ugen.

if wrap is set to true (default) the index wraps across the input array, otherwise it clips.
Channel does not multi channel expand. For a channel mixer see NumChannels

 *ar(array, offset, numChannels, wrap)
 *kr(array, offset, numChannels, wrap)


(
{ 
 var a;
 a = Array.fill(8, { SinOsc.ar(Rand(500, 1800) * [1, 1.5], 0, 0.1) });
 Channel.ar(a, MouseX.kr(0, 20), 2);
 
}.play;
)

(
{ 
 var a;
 a = Array.fill(8, { SinOsc.kr(Rand(0.1, 8) * [1, 2], 0, Rand(0, 80), Rand(300, 900)) });
 SinOsc.ar(Channel.kr(a, MouseX.kr(0, 20), 2), 0, 0.1);
 
}.play;
)

// without wrapping
(
{ 
 var a;
 a = Array.fill(8, { SinOsc.ar(Rand(500, 1800) * [1, 1.5], 0, 0.1) });
 Channel.ar(a, MouseX.kr(0, 20), 2, false);
 
}.play;
)

// when the offset is fixed, Channel returns a fixed array accordingly.
// the othe ugens keep playing, so this makes sense only in certain cases.
// (similar to Select ugen)
(
{ 
 var a, b;
 a = Array.fill(8, { SinOsc.ar(Rand(300, 1800) * [1, 1.5] * LFNoise1.kr(0.01)) });
 b = Channel.ar(a, 3, 2);
 5.do({ b = b * Channel.ar(a, 8.rand, 2) });
 b * 0.1
 
}.play;
)

(
{ 
 var a, b, m;
 a = Array.fill(8, { SinOsc.ar(Rand(300, 1800) * [1, 1.5] * LFNoise1.kr(0.01)) });
 b = Channel.ar(a, 3, 2);
 m = MouseX.kr(0, a.size);
 5.do({ b = b * Channel.ar(a, 8.rand + m, 2) });
 b * 0.1
 
}.play;
)





 
Note: all the input ugens are continously running. This may not be the most efficient way if each input is cpu-expensive.
