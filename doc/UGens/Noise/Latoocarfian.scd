
Latoocarfian chaotic function

Latoocarfian.ar(a, b, c, d, mul, add)

This is a function given inClifford Pickover's book Chaos In Wonderland, pg 26. 
The function has four parameters a, b, c, and d.
The function is:

xnew = sin(y * b) + c * sin(x * b);
ynew = sin(x * a) + d * sin(y * a);
x = xnew;
y = ynew;
output = x;

According to Pickover, parameters a and b should be in the range from -3 to +3,
and parameters c and d should be in the range from 0.5 to 1.5.
The function can, depending on the parameters given, give continuous chaotic
output, converge to a single value (silence) or oscillate in a cycle (tone).
This UGen is experimental and not optimized currently, so is rather hoggish of CPU.

//not installed yet!
(
SynthDef("help-Latoocarfian", { arg out=0, a=1.0, b=1.0, c=0.7, d=0.7;
 var env, a, b, c, d;
 env = EnvGen.kr(Env.linen(0.1, 1, 0.1), doneAction:2);
 Out.ar(out, 
 Latoocarfian.ar(a, b, c, d, 0.05)
 )
}).send(s);
)

{
 Synth.new("help-Latoocarfian", [
 \a, 3.0.rand, \b, 3.0.rand, 
 \c, 0.5 + 1.5.rand, \d, 0.5 + 1.5.rand]
 );
 1.0.wait;
}.play;


//todo:
(
// GUI version:
w = GUIWindow.new("Latoocarfian", Rect.newBy(40,40,200,300));
SliderView.new(w, Rect.newBy(8,8,20,280), nil, 0, -3, 3);
SliderView.new(w, Rect.newBy(32,8,20,280), nil, 0, -3, 3);
SliderView.new(w, Rect.newBy(56,8,20,280), nil, 1, 0.5, 1.5);
SliderView.new(w, Rect.newBy(80,8,20,280), nil, 1, 0.5, 1.5);
{ XFadeTexture.ar({
 w.views.at(0).value = 3.0.rand2;
 w.views.at(1).value = 3.0.rand2;
 w.views.at(2).value = 0.5 + 1.0.rand;
 w.views.at(3).value = 0.5 + 1.0.rand;
 //[a, b, c, d].postln;
 Latoocarfian.ar(w.views.at(0).value, w.views.at(1).value, 
 w.views.at(2).value, w.views.at(3).value, 0.05)
}, 1, 0.1, 1) }.play;
)

