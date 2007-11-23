

RLPF

RLPF.ar(in, freq, rq, mul, add)

A resonant low pass filter.
in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q. bandwidth / cutoffFreq.

{ RLPF.ar(Saw.ar(200,0.1), FSinOsc.kr(XLine.kr(0.7,300,20),3600,4000), 0.2) }.play;


(
{ 	var ctl = RLPF.ar(Saw.ar(5,0.1), 25, 0.03);
	SinOsc.ar(ctl * 200 + 400) * 0.1;
}.play;
)

(
{ 	var ctl = RLPF.ar(Saw.ar(5,0.1), MouseX.kr(2, 200, 1), MouseY.kr(0.01, 1, 1));
	SinOsc.ar(ctl * 200 + 400) * 0.1;
}.play;
)


