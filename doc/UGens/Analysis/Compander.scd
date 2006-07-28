
Compander compressor, expander, limiter, gate, ducker

Compander.ar(input, control, threshold, slopeBelow, slopeAbove, 
 clampTime, relaxTime, mul, add)

General purpose dynamics processor. 

(
// example signal to process
play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, 0,LFSaw.kr(0.3, 0, -0.3, 0.3)), 
 0.001, 0.3, Mix.ar(Pulse.ar([80,81], 0.3)))
})
)

(
// noise gate
play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, 0,LFSaw.kr(0.3, 0, -0.3, 0.3)), 
 0.001, 0.3, Mix.ar(Pulse.ar([80,81], 0.3)));
 Compander.ar(z, z, MouseX.kr(0.1, 1), 10, 1, 0.01, 0.01);
})
)

(
// compressor
play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, 0,LFSaw.kr(0.3, 0, -0.3, 0.3)), 
 0.001, 0.3, Mix.ar(Pulse.ar([80,81], 0.3)));
 Compander.ar(z, z, MouseX.kr(0.1, 1), 1, 0.5, 0.01, 0.01);
})
)

(
// limiter
play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, 0,LFSaw.kr(0.3, 0, -0.3, 0.3)), 
 0.001, 0.3, Mix.ar(Pulse.ar([80,81], 0.3)));
 Compander.ar(z, z, MouseX.kr(0.1, 1), 1, 0.1, 0.01, 0.01);
})
)

(
// sustainer
play({
 var z;
 z = Decay2.ar(
 Impulse.ar(8, 0,LFSaw.kr(0.3, 0, -0.3, 0.3)), 
 0.001, 0.3, Mix.ar(Pulse.ar([80,81], 0.3)));
 Compander.ar(z, z, MouseX.kr(0.1, 1), 0.1, 1, 0.01, 0.01);
})
)

