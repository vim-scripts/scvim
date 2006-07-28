
LFPulse pulse oscillator

LFPulse.ar(freq, iphase,width, mul, add)

A non-band-limited pulse oscillator. Outputs a high value of one and a low value of zero.
freq - frequency in Hertz
iphase - initial phase offset in cycles ( 0..1 )
width - pulse width duty cycle from zero to one.

//Synth.plot({ LFPulse.ar(500, 0, 0.3, 1, 0) });

// used as both Oscillator and LFO:
play({ LFPulse.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1) });

compare:
//plot({ 
// [Pulse.ar(10.0, 0.3, 1, 0),
// LFPulse.ar(10.0, 0.3, 1, 0)]
//},1.0);


