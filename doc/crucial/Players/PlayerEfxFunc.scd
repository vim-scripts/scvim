PlayerEfxFunc

a Player and an effect

 PlayerEfxFunc(player,aHasPatchIns,inputIndex)
player - any player
aHasPatchIns - subclass of HasPatchIns, most commonly Patch
inputIndex - which PatchIn to plug the player into.
 its easiest to write effect Patches with an 'audio' input
 in the first slot, and the Patch can be saved with a PlayerInputProxy
 as the input.
 this is a deepIndex, a depth first traversal going down any subpatches.


(
Instr([\metal,\cowboy],{ arg trig,decay=0.04,noise=0.03,freqScale=1.0,timeScale=1.0;
 var z;
 // cowboy horse
 z = [ `(#[ [ 1529.7, 1483.76, 1535.99, 1484.43, 1505.93, 1489.52, 1520.41, 
 1488.2, 1485.2, 1484.89, 1531.32, 1523.36, 1499.86, 1515.78 ], 
 nil, [ 0.113974, 0.0999759, 0.240025, 0.0511734, 0.22413, 0.0680363,
 0.228308, 0.0525205, 0.0169197, 0.131742, 
 0.18775, 0.0991267, 0.119733, 0.0575907 ] ]), 
 `(#[ [ 1530.7, 1498.63, 1501.59, 1526.8, 1513.55, 1502.9, 1524.68, 
 1515.48, 1523.02, 1513.11, 1484.01, 1535.29, 1496.4, 1513.86 ], 
 nil, 
 [ 0.212696, 0.0171297, 0.0768345, 0.0789025, 0.323539, 0.0921697, 
 0.0149089, 0.102342, 0.117676, 0.058209, 0.0735961, 0.0207109, 0.385993, 0.04467 ] 
 ]) ];

 Klank.ar(z, 
 Decay.ar(Impulsar.ar(trig), decay, WhiteNoise.ar(noise)),
 freqScale,
 0.0,
 timeScale);
});

p = Patch([\metal,\cowboy],[
 Stream2Trig(Pseq(#[ 0, 0, 0, 0.305556, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0 ],inf))
 ]);

e = Patch({ arg audio,decay=1,maxDelay=0.3,qnty=4,chanDiff=0.1;
 
 (qnty.asInteger).do({
 var x; 
 audio = 
 AllpassL.ar(audio, maxDelay, 
 [rrand(0.01,maxDelay),rrand(0.01,maxDelay)],
 decay)
 });
 audio
 },[
 PlayerInputProxy.new
 ]);

PlayerEfxFunc( p, e ).gui 

)

e.patchIns.insp

p.bus.insp
e.bus.insp


look for first patchIn of same rate

p.synth.insp
e.synth.insp


player input proxy
 in bus 6 2
 out bus 5 1
 
 spec and channels right




p.rate
 
 
 