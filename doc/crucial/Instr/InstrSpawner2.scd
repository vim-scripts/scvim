InstrSpawner2


InstrSpawner2.new(name,args,noteOn, beatsPerStep,tempo)

name
 the instr name
args
 each argument is taken .asStream and the stream is iterated during play
 
noteOn is a stream of values meaning:
 1 noteOn
 arg streams are iterated and sent to a new synth
 0 rest
 -1 legato 
 arg streams are interated and sent to the last synth

beatsPerStep (default 0.25)
 how many beats to wait between each step
tempo (default is global Tempo)
 the Tempo object used for conversions

 
(

Instr(\InstrSpawner,{ arg freq=1000,amp=1.0,env;
 
 Saw.ar(freq,mul: amp)
 * EnvGen.kr(env,doneAction: 2)
});

z = InstrSpawner2(\InstrSpawner,[
 Pbrown(40,90,3,inf).midicps,
 0.2,
 Env.sine // does not get streamed
 ],
 Pseq([1,-1,-1,0,0,0,0,0,0,1,0,0,0],inf),
 0.25 // 16th notes
 );
 
z.play;

)

z.stop;


z.gui

