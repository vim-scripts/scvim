MIDIPlayer


MIDIGatePlayer.new(spec)
 generates a gate with the level scaled from 0..127 to the requested spec
CCPlayer.new(controller,spec)
 controller value is scaled to the requested spec
MIDIFreqPlayer.new
 midi note to freq



Any attached midi keyboard should work
(

Instr(\monosynth,{ arg gate=0.0,freq=440.0,ffreq=500,rq=0.1,width=0.3;
 var amp;
 amp = Latch.kr(gate,gate);

 RLPF.ar(
 Pulse.ar(freq,width),
 ffreq,
 rq)
 
 * EnvGen.kr(Env.adsr,gate,amp)
 
});

Patch(\monosynth,[
 MIDIGatePlayer.new,
 MIDIFreqPlayer.new
]).gui

)



(
Patch(\monosynth,[
 BeatClockPlayer.new(16),
 MIDIFreqPlayer.new,
 CCPlayer(50,[100,3000,\exp,0.0,1500.0]),
 CCPlayer(51,[0.1,0.9,\exp,0.0,0.2]),
 CCPlayer(52,[0.05,1.0])
]).play

)
Note that the intial values are the spec's defaults, not the Instr function argument defaults.


/*
( PlayerBinop not yet implemented

Patch(\monosynth,[
 BeatClockPlayer.new(16) * MIDIGatePlayer.new,
 MIDIFreqPlayer.new,
 CCPlayer(50,[100,3000,\exp,0.0,1500.0]),
 CCPlayer(51,[0.1,0.9,\exp,0.0,0.2]),
 CCPlayer(52,[0.05,1.0])
]).play

)
*/


)



(

Instr(\fatsynth,{ arg gate=0.0,freq=440.0,ffreq=500,rq=0.1;
 var amp;
 amp = Latch.kr(gate,gate);

 RHPF.ar(
 Splay.arFill(9,{ arg i;
 Pulse.ar(freq + rrand(-100,100),LFNoise1.kr(0.01))
 }),
 ffreq * amp,
 rq)
 
 * EnvGen.kr(Env.adsr,gate,amp)
});

Patch(\fatsynth,[
 MIDIGatePlayer.new,
 MIDIFreqPlayer.new,
 CCPlayer(50,ControlSpec(100,3000,\exp,0.0,500.0)),
 CCPlayer(51,ControlSpec(0.1,0.9,\exp,0.0,0.1))
]).gui

)

Mod Wheel
(
Patch(\fatsynth,[
 MIDIGatePlayer.new,
 MIDIFreqPlayer.new,
 CCPlayer(1,[100,3000,\exp,0.0,500.0])
]).play

)
// command-. to stop

