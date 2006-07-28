Formant formant oscillator

Formant.ar(kfundfreq, kformfreq, kwidthfreq, mul, add)

Generates a set of harmonics around a formant frequency at a given fundamental frequency.
kfundfreq - fundamental frequency in Hertz.
kformfreq - formant frequency in Hertz.
kwidthfreq - pulse width frequency in Hertz. Controls the bandwidth of the formant.
Widthfreq must be greater than or equal fundfreq.

// modulate fundamental frequency, formant freq stays constant
{ Formant.ar(XLine.kr(400,1000, 8), 2000, 800, 0.125) }.play

// modulate formant frequency, fundamental freq stays constant
{ Formant.ar(200, XLine.kr(400, 4000, 8), 200, 0.125) }.play

// modulate width frequency, other freqs stay constant
{ Formant.ar(400, 2000, XLine.kr(800, 8000, 8), 0.125) }.play
