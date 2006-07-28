Enveloper2

gate the audio input with an Envelope;

(

b = Bus.control(Server.local);
{
 var p,qnty=4,gate;
 gate = In.kr(b.index);
 p = Mix.arFill(qnty.asInteger,{ arg i;
 SinOsc.ar(440 + rrand(1,5))
 }) * qnty.reciprocal;

 Enveloper2.ar(p,gate,Env.adsr)
}.play;

)


// On
b.value = 1.0;

// Off
b.value = 0.0;

b.value = 0.2;

b.value = 0.0;

b.free;

