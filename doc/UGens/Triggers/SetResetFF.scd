
SetResetFF set-reset flip flop

SetResetFF.ar(trig, reset)

Output is set to 1.0 upon receiving a trigger in the set input, and to 0.0 upon receiving a trigger
in the reset input. Once the flip flop is set to zero or one further triggers in the same input
are have no effect. One use of this is to have some precipitating event cause something to
happen until you reset it.
trig - trigger sets output to one
reset - trigger resets output to zero

(
play({
 a = Dust.ar(5); // the set trigger
 b = Dust.ar(5); // the reset trigger
 SetResetFF.ar(a,b) * BrownNoise.ar(0.2); 

}))
