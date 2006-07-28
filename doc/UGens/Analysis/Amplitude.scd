
Amplitude amplitude follower

Amplitude.kr(input, attackTime, releaseTime, mul, add)

Tracks the peak amplitude of a signal.
input - input signal.
attackTime - 60dB convergence time for following attacks.
releaseTime - 60dB convergence time for following decays.

(
// use input amplitude to control Pulse amplitude - use headphones to prevent feedback.
SynthDef("help-Amplitude",{ arg out=0;
 Out.ar(out,
 Pulse.ar(90, 0.3, Amplitude.kr(AudioIn.ar(1)))
 )
}).play;

)


(
// use input amplitude to control SinOsc frequency - use headphones to prevent feedback.
SynthDef("help-Amplitude",{ arg out=0;
 Out.ar(out,
 SinOsc.ar(
 Amplitude.kr(
 AudioIn.ar(1),
 0.01,
 0.01,
 1200,
 400)
 , 0, 0.3)
 )
}).play;

)

