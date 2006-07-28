SampleRateserver sample rate

superclass: InfoUGenBase

returns the current sample rate of the server

 *ir
 
// example

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

// compares a 441 Hz sine tone derived from sample rate (44100 * 0.01, left) 
// with a 440 Hz tone (right), resultin in a 1 Hz beating
(
{ 
 var freq;
 freq = [ SampleRate.ir(0) * 0.01, 440];
 SinOsc.ar(freq, 0, 0.1) 
}.play; 
)