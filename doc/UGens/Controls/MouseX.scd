MouseX cursor ugen

superclass: UGen


*kr(minval, maxval, warp, lag)
 
minval, maxval range between left and right end of screen
 
warp mapping curve. 0 is linear, 1 is exponential (for freq or times e.g)
 alternative: 'linear', 'exponential'
 
lag lag factor to dezpipper cursor movement
 
 see also MouseX, MouseButton
 
 
 
 //example
 
 { SinOsc.ar(MouseX.kr(40, 10000, 1), 0, 0.1) }.play;
 
 