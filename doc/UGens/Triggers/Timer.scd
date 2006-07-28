Timerreturns time since last triggered

superclass: UGen



 *ar(trig)
 *kr(trig)

 


 
// using timer to modulate sine frequency: the slower the trigger is the higher the frequency
(
{ var trig;
 trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
 SinOsc.ar(Timer.kr(trig) * 500 + 500, 0, 0.2)
}.play;
)



