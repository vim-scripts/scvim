

LPF				2nd order Butterworth lowpass filter

LPF.ar(in, freq, mul, add)

A second order low pass filter.
in - input signal to be processed
freq - cutoff frequency.

{ LPF.ar(Saw.ar(200,0.1), SinOsc.kr(XLine.kr(0.7,300,20),0,3600,4000)) }.play;

// kr:
(
{ var ctl = LPF.kr(LFPulse.kr(8), SinOsc.kr(XLine.kr(1, 30, 5)) + 2);
	SinOsc.ar(ctl * 200 + 400)
}.play;
)

(
{ var ctl = LPF.kr(LFPulse.kr(8), MouseX.kr(2, 50, 1));
	SinOsc.ar(ctl * 200 + 400)
}.play;
)


