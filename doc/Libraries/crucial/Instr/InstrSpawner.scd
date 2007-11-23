
InstrSpawner

superclass: Patch

InstrSpawner( instr , args, delta )

	instr - as per Patch, may be a function or an Instr name.
	args - as per Patch, nil args will be auto-created.
		args that are Players will play continously in their own synths and be patched into
		each spawn event synth.
		args that are of rate \stream (all Patterns) will be streamed.
		args that are of rate \scalar (floats, Envs, samples) will be passed into the instr
		function and are subsequently fixed.
	delta - a float or pattern.
		in seconds
		see InstrGateSpawner for beats and for variable legato


// start and pchRatio are streamed
(
InstrSpawner({ arg sample,start=0,pchRatio=1.0,env;
	PlayBuf.ar(
		sample.numChannels,
		sample.bufnumIr,
		pchRatio,
		1,
		start * sample.bufFramesIr,
		1
	) * EnvGen.kr(env,doneAction: 2)
},[
	Sample("a11wlk01.wav"),
	Pbrown(0,1,0.1,inf),
	Prand(
		Array.fill(4,{
			Pseries(rrand(-20,30),[2,-2].choose,rrand(5,20))
		}),inf).midiratio,
	Env.sine(0.2,0.4)

],0.06).play

)


// pchRatio will not stream, is fixed at -1
(

InstrSpawner({ arg sample,start=0,pchRatio=1.0,env;
	PlayBuf.ar( sample.numChannels, sample.bufnumIr,pchRatio,1,start * sample.bufFramesIr,1 )
		 * EnvGen.kr(env,doneAction: 2)
},[
	Sample("a11wlk01.wav"),
	Pbrown(0,1,0.1,inf),
	-1,
	Env.sine(0.2,0.4)

],0.125).play

)

the Patch in the width input plays continuously and is patched into each spawn event
(
	InstrSpawner({ arg freq,rq,width,fenv,fenvmod,envperc;
		width.debug("width"); // an OutputProxy
		RLPF.ar(
			Pulse.ar(
				freq,
				width
			),
			EnvGen.kr(fenv,levelScale: fenvmod),
			rq)
	 		 * EnvGen.kr(envperc, 1.0,0.3,doneAction: 2)
	},[
		Pfunc({ 15.rand.degreeToKey([ 0, 2, 3, 5, 7, 8, 10 ]).midicps * 3 }),
		0.1,
		Patch({ FSinOsc.kr(0.05).range(0.01,0.99) }),
		Env.asr,
		6000,
		Env.perc(releaseTime: 0.8)
	],0.125).play
)
note: for beats see InstrGateSpawner


the stereo Patch in the width input causes the InstrSpawner to expand to stereo
(
	InstrSpawner({ arg freq,rq,width,fenv,fenvmod,envperc;
		width.debug("width"); // an OutputProxy
		RLPF.ar(
			Pulse.ar(
				freq,
				width
			),
			EnvGen.kr(fenv,levelScale: fenvmod),
			rq)
	 		 * EnvGen.kr(envperc, 1.0,0.3,doneAction: 2)
	},[
		Pfunc({ 15.rand.degreeToKey([ 0, 2, 3, 5, 7, 8, 10 ]).midicps * 3 }),
		0.1,
		Patch({
			[	FSinOsc.kr(0.05,0.0).range(0.01,0.99),
				FSinOsc.kr(0.05,0.5).range(0.01,0.99),
			]		
			 }),
		Env.asr,
		6000,
		Env.perc(releaseTime: 0.8)
	],0.125).play
)




(

Instr(\InstrSpawner,{ arg freq=1000,amp=0.1,env;
	
		SinOsc.ar(freq,mul: amp)
		* EnvGen.kr(env,doneAction: 2)
});

i = InstrSpawner(\InstrSpawner,[
				Pbrown(45,90,3,inf).midicps,
				0.1,
				Env.sine // does not get streamed
			],
			0.1
			);
	
i.play
			
)


sliders are polled on the gui
(

Instr(\InstrSpawner,{ arg freq=1000,amp=0.1,env;
	
		SinOsc.ar(freq,mul: amp)
		* EnvGen.kr(env,doneAction: 2)
});

InstrSpawner(\InstrSpawner,[
				nil, // accept a default KrNumberEditor
				nil, // accept a default KrNumberEditor
				Env.sine // does not get streamed
			],
			NumberEditor(0.1,[0.05,1.0]) // polled each time
	).gui		
)





// how to get eventCount like sc2 Spawn
(

	InstrSpawner({ arg eventCount=0, freq,rq,width,fenv,fenvmod,envperc;

		// do something with eventCount if you need it...

		RLPF.ar(
			Pulse.ar(
				freq,
				width
			),
			EnvGen.kr(fenv,levelScale: fenvmod),
			rq)
	 		 * EnvGen.kr(envperc, doneAction: 2)
	},[
		
		Pseries(0,1,inf), // infinite counting
		
		//aeolian
		Pfunc({ 15.rand.degreeToKey([ 0, 2, 3, 5, 7, 8, 10 ]).midicps * 3 }),
		0.1,
		Patch({ LFTri.kr(0.1,[0.0,0.5],0.5,0.5) }),
		Env.asr,
		6000,
		Env.perc(releaseTime: 0.1)
	],0.25).play
)
this is more flexible, is only on when you need it, and lets you do wrapping or scaling etc.
of the event count all in the pattern domain.








