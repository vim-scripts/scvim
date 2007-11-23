

Impulse		impulse oscillator

Impulse.ar(freq, phase, mul, add)

Outputs non band limited single sample impulses.
freq - frequency in Hertz
phase - phase offset in cycles ( 0..1 )

{ Impulse.ar(800, 0.0, 0.5, 0) }.play

{ Impulse.ar(XLine.kr(800,100,5), 0.0, 0.5, 0) }.play

modulate phase:

{ Impulse.ar(4, [0, MouseX.kr(0, 1)], 0.2) }.play;


