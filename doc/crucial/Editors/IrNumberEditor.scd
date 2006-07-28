IrNumberEditor

used with Patch or InstrSpawner to specify an .ir rate control

a float or integer will not create a synth arg input. the number will be passed
directly into the synth def.



(
InstrSpawner({ arg sample,pchRatio=1,start=0,dur=0.2;

 Pan2.ar(
 PlayBuf.ar(sample.numChannels,
 sample.bufnumIr,
 sample.bufRateScaleIr * pchRatio,
 startPos: start * sample.bufFramesIr,
 loop: 0
 ),Rand(0,1),0.3)
 * EnvGen.kr( Env.perc(0.01,1.0,1,3), timeScale: dur, doneAction: 2)
 
},[
 Sample("sounds/a11wlk01.wav"),
 IrNumberEditor(1,[-4,4]),
 IrNumberEditor(0,[0,1]),
 IrNumberEditor(0.2,[0.05,0.5])
],
 NumberEditor(0.1,[0.05,0.2])
).gui

)
