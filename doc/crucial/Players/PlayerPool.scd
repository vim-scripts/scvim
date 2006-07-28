PlayerPool switch between players

superclass: PlayerSocket

This is a PlayerSocket with a supplied pool of players that it can switch between.

See PlayerSocket regarding Envelopes and .release


(
 Instr([\oscillOrc, \pmosc],{ arg freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0,gate=1.0;
 PMOsc.ar(freq,freq2,pmindex,phasemod,amp)
 * EnvGen.kr(Env.adsr,gate)
 });
 
 p = Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(240.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 KrNumberEditor(1.0,\gate)
 ]);
 
 q = Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(90,\freq), 
 27.7707, 
 Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317
 ]), 
 0, 
 Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317
 ]),
 KrNumberEditor(1.0,\gate)
 ]);
 
 r = Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(40,\freq), 
 nil, 
 Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317
 ]), 
 0, 
 Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317
 ]),
 KrNumberEditor(1.0,\gate)
 ]);
 
 PlayerPool([ p,q,r ],round:1.0).gui
)
Since we don't know how big the gui is going to be, it assumes to hog all the space.
When you know, you can explictly gui it to that size:

 PlayerPool([p,q,r],round: 1.0).gui(nil, 500@300)
 


Easiest to use with lists of paths to saved players. 
 
 eg. PlayerPool( paths )

If the patches had been loaded from disk, they would display their filenames in the select buttons.

//PlayerPool([p,q,r],round:1.0).smallGui


Without gui
(
o = PlayerPool([p,q,r],
 env: Env.asr(1.0,release: 8.0),
 round: 0.0);

o.play
)


o.choose;

o.select(1);

o.release;

o.free;





// getPaths is broken and only gets one path :()
(
 CocoaDialog.getPaths({ arg paths; 
 PlayerPool(
 paths.collect({ arg path;
 SFP(path)
 })
 ).gui
 })
)


Sending the PlayerPool through an effect patch

the gate inputs on p, q, and r are left high. when the PlayerPool switches, it sends a release by dropping the gate, then calling .stop

since PlayerPool is a subclass of PlayerSocket, it already envelopes the audio output of the players.
this example shows:
 1. putting the entire thing through another Patch effect process
 2. that all the \gate args in a synth will be released when .release is called

still a bug with EnvelopedPlayer.

first time a patch plays, its in the wrong group
(
 Instr([\oscillOrc, \pmosc],{ arg freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0,gate=1.0;
 PMOsc.ar(freq,freq2,pmindex,phasemod,amp) * EnvGen.kr(Env.adsr,gate: gate)
 });
 
 p = Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(240.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 KrNumberEditor(1,\gate)
 ]);
 
 q = Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(90,\freq), 
 27.7707, 
 Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 KrNumberEditor(1,\gate)
 ]), 
 0, 
 Patch.new([ 'oscillOrc', 'pmosc' ],
 [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 KrNumberEditor(1,\gate)
 ]),
 KrNumberEditor(1,\gate)
 ]);
 
 r = Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(40,\freq), 
 nil, 
 Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 BeatClockPlayer(10)
 ]), 
 0, 
 Patch.new([ 'oscillOrc', 'pmosc' ], [
 KrNumberEditor(150.06,\freq), 
 27.7707, 
 1.3, 
 0, 
 0.616317,
 BeatClockPlayer(12)
 ]),
 BeatClockPlayer(16)
 ]);

Patch({ arg audio,delayTime=0.3,feedback=0.2,buffer;
 PingPong.ar(buffer.bufnumIr, [audio,audio],delayTime,feedback)
},[
 PlayerPool([p,q,r],
 env: Env.adsr(1.0,releaseTime: 8.0),
 round: 0.0),
 0.3,
 0.5,
 BufferProxy.new(44100,2)
]).gui

)


/* stress testing
 players aren't designed to be played this fast. for fast iterations,
 use InstrGateSpawner etc.
 but this test shows where the weakness is.
 (releases are overlapping next starts)
 being worked on.
*/
(
var a,pool;

Instr([\klankperc,\k2a],{ arg trig=0.0,sfreqScale=1.0,sfreqOffset=0.0,stimeScale=1.0,foldAt=0.1;
 Klank.ar(
 `[
 FloatArray[ rrand(40,1000), rrand(40,1000) ],
 nil,
 FloatArray[ 0.165394, 0.15595 ]
 ],
 K2A.ar(trig),
 sfreqScale,sfreqOffset,stimeScale
 ).squared.fold2(foldAt) 
},[
 nil,
 [0.01,100],
 [0,10000],
 [0.01,100]
]);

a = Array.fill(5,{ arg i;
 Patch.new([\klankperc,\k2a],
 [
 BeatClockPlayer(16),
 i * (3.midiratio),
 i * (3.midiratio),
 1.0,
 0.1
 ]);
 });

 pool = PlayerPool( a,
 env: Env.asr(0.01,releaseTime: 0.001),
 round: 0.25);
 
 pool.play;
 
 Routine({
 loop {
 0.05.wait;
 pool.select(a.size.rand.debug("selecting:"));
 }
 }).play(AppClock);
 
)

