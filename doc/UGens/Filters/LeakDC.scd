LeakDC remove DC

LeakDC.ar(in, coef, mul, add)

This filter removes a DC offset from a signal.
in - input signal.
coef - leak coefficient.

(
// this is really better with scope()
play({
 var a;
 a = LFPulse.ar(800, 0.5, 0.5, 0.5);
 [a, LeakDC.ar(a, 0.995)]
}))
