
abs absolute value

a.abs
abs(a)

abs(-5).postln;

(
{
 var a;
 a = SyncSaw.ar(100, 440, 0.1);
 // Absolute value
 a.abs
}.play
)

compared to

(
{
 var a;
 a = SyncSaw.ar(100, 440, 0.1);
 a
}.play
)
