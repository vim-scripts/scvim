Wrap wrap a signal outside given thresholds

Wrap.ar(in, lo, hi)
Wrap.kr(in, lo, hi)

This differs from the BinaryOpUGenwrap2 in that it allows one to set both low and high thresholds.
in - signal to be wrapped
lo - low threshold of wrapping
hi - high threshold of wrapping


Server.internal.boot;

{ Wrap.ar(SinOsc.ar(440, 0, 0.2), -0.15, 0.15) }.scope;
