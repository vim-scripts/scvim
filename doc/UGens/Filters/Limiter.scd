Limiter peak limiter

Limiter.ar(input, level, lookAheadTime)

Limits the input amplitude to the given level. Limiter will not overshoot
like Compander will, but it needs to look ahead in the audio. Thus there is a 
delay equal to twice the lookAheadTime.
Limiter, unlike Compander, is completely transparent for an in range signal.

input - the signal to be processed.
level - the peak output amplitude level to which to normalize the input.
lookAheadTime - the buffer delay time. Shorter times will produce smaller delays
and quicker transient response times, but may introduce amplitude modulation artifacts.

(
// example signal to process
Synth.play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, LFSaw.kr(0.25, -0.6, 0.7)), 
 0.001, 0.3, FSinOsc.ar(500));
}, 0.8)
)

(
Synth.play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, LFSaw.kr(0.25, -0.6, 0.7)), 
 0.001, 0.3, FSinOsc.ar(500));
 [z, Limiter.ar(z, 0.4, 0.01)]
}, 0.5)
)