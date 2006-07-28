TempoBus

A Bus whose value is set by a Tempo. It can be used as a multiplier in any Synth on the Server that needs to know the Tempo. It is used by BeatClockPlayer. Any Inst/Patch that needs a tempo input should use a TempoPlayer.

TempoBus.new(server,tempo)
TempoBus.new 
 default server, default tempo


There is one TempoBus per server, per tempo. After the first time it is created, the shared instance will be returned for any subsequent requests.

(
 a = TempoBus.new;
 b = TempoBus.new;
 a === b // they are the same object
)




(
s = Server.local;
t = TempoBus.new(s);

t.index.postln;

Tempo.bpm = 60;

SynthDef("help-TempoBus",{ arg out=0,tempoBus;
 var tempo,trig,amp;
 tempo = In.kr(tempoBus);
 trig = Impulse.kr(tempo);
 amp = Decay2.kr(trig,0.01,0.1).clip2(1.0);
 Out.ar(out,
 amp * SinOsc.ar(300)
 )
}).play(s,[0,0,1,t.index]);


Tempo.bpm = 40;

Tempo.bpm = 100;

Tempo.bpm = 666;

Sheet({ arg f;
 Tempo.default.gui(f); // move the slider, it works
})

)


see TempoPlayer
