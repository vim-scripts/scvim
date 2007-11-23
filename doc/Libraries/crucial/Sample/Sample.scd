
Sample

superclass: AbstractSample

This class can be used as an argument to a Patch. It will take care of all the troubles of loading, allocating, measuring, and even beat synchronizing of a small sound file. It will not clear the copyright.

	Sample.new(soundFilePath,tempo)

It will not play by itself, but it holds all the intelligence to allow other things to play it very easily.


(

p = Patch({ arg sample;

	PlayBuf.ar(sample.numChannels,
			sample.bufnumIr,
			sample.bufRateScaleKr,
			1.0,
			0.0,
			1.0)

},[
	Sample("a11wlk01.wav")
]);

p.gui;

)

Notice that the path to the sample is relative to the sounds/ directory, not to SuperCollider's own directory. You can set the Sample.soundsDir to the directory of your choice (eg, ~/Library/Sounds/ or ~/Sounds/ ). Copy a11wlk01.wav to your own sounds directory so you can still play examples.


Within the Instr function you use these methods on your Sample object

	bufnumIr
		at the start of the synth, this will get the dynamic bufferID of your Sample object.
		this Instr will reuse SynthDefs where possible. Multiple synths may use the same
		basic sample synthDef for many voices with no need to compile new SynthDefs
		and send to the server.
		
	sampleRate
		a float of the current sample's sample rate, embedded into the SynthDef as a constant.
		the def will be resuable for all samples of that sample rate, and will be slightly more efficient.
	sampleRateKr
		a kr rate signal that will change if you load a different sample into the buffer,even
		while playing.
	sampleRateIr
		a ir rate signal that will NOT change if you load a different sample into the buffer.
		use when you know the sample will not change, or if you know that all samples are the
		same sampleRate anyway.

	bufRateScaleKr
		the nominal pitchRatio value needed to play at the original pitch
	bufRateScaleIr
		the nominal pitchRatio value needed to play at the original pitch.
		will NOT change if you load a different sample into the buffer.
		
	bufFramesKr
		a kr rate signal with the number of frames of the current sample
	bufFramesIr
		an ir rate signal with the number of frames of the sample

	bufSamplesKr
		a kr rate signal with the number of samples of the current sample
	bufSamplesIr
		an ir rate signal with the number of samples of the current sample

	duration
		duration in seconds of current sample, embedded into SynthDef as a constant.
	bufDurKr
		duration in seconds
	bufDurIr
		duration in seconds

		
	numChannels
		integer, number of channels of the current sample. this will be embedded
		into the SynthDef as a constant. the SynthDef will still be reusable for
		all samples of the same numChannels.
	bufChannelsKr
		number of channels of the current sample. you cannot use this to modulate
		a PlayBuf.
	bufChannelsIr
		number of channels of the sample. you cannot use this to modulate
		a PlayBuf.
		


You can swap the samples while playing. Click on the name of the sample (in black font) and browse for a stereo sample. Then start play, and you can browse for more and change it while playing.
(

Instr("help-Sample",{ arg sample,pchRatio=0.50;
	PlayBuf.ar(sample.numChannels,
				sample.bufnumIr, // finds the buffer number when the synth starts
				sample.bufRateScaleKr * pchRatio,
				1.0,0.0,1.0);
});

p = Patch("help-Sample",[
	Sample("pick a stereo sample...")
]);

p.gui

)

The def name was : help-SampleO8NEut


You can build up a library of Instr functions and exploit them with Patch.

(
Instr([\help,\Sample],{ arg sample,pchRatio=1.0,start=0.0;
	PlayBuf.ar(sample.numChannels,
				sample.bufnumIr, // finds the buffer number when the synth starts
				sample.sampleRateKr / 44100 * pchRatio,
				1.0,
				start * sample.bufFramesKr,
				1.0); // loop
});
)

Patch object:

(
	p = Patch([\help,\Sample],
	[
		Sample("a11wlk01.wav")
	]);
	
	// edit controls on the gui
	p.gui
)


save it, and this will fully restore the complete sound.

(
	Patch.new(
		[ 'help', 'Sample' ], [ Sample.new("a11wlk01.wav", 1.6347258775994),
			0.46511627906977, 0.17441860465116 ]
	).play
)	



BeatLock

This will embed the sample's tempo into the SynthDef as a constant. Tempo's tempo can vary, but
what the monkey thinks the music in the sample is will remain fixed in the SynthDef.
	
(
	
	//beatlock
	Instr([\help,\Sample],{ arg sample;
		PlayBuf.ar(
			sample.numChannels,
			sample.bufnumIr,
			sample.pchRatioKr,
			1.0,0.0,1.0);
	},[
		\sample,
		\tempo
	]);
	
	p = Patch([\help,\Sample],
	[
		Sample("a11wlk01.wav")
	]);
	
	// move the tempo slider
	p.gui
	
)

This is roughly equivalent to this:
	(
	//beatlock
	Instr([\help,\Sample],{ arg sample,tempo;
		PlayBuf.ar(
			sample.numChannels,
			sample.bufnumIr,
			sample.sampleRateIr / 44100 * tempo * sample.tempo.reciprocal,
			1.0,0.0,1.0);
	},[
		\sample,
		\tempo
	]);
	
	
	p = Patch([\help,\Sample],
	[
		Sample("a11wlk01.wav"),
		TempoPlayer.new
	]);
	
	// move the tempo slider
	p.gui
	
	)






soundFilePath
end
	signal.size - 1
	the last indexable position in the signal
duration
totalMemory
	numFrames * numChannels




The following methods are relevant if the sample is some kind of loop.


tempo
	beats per second the original recording is regarded to have.
beats
	number of beats
beatsize
	the number of samples per beat





/***

(
// hit load and select a rhythm
// will stay beat locked and the beat will flow despite the cutting
q = rrand(8,32);

Patch({arg gate,env,sample,pchRatio;
	var pchRatioKr,start;
	pchRatioKr = sample.pchRatioKr * pchRatio;
	start = LFSaw.kr(GetTempo.kr * sample.beats.reciprocal, sample.end * 0.5, sample.end * 0.5);
	
	ReTrigger2.ar({
		PlayBuf.ar(sample.signal,sample.sampleRate,pchRatioKr,start.poll,0,sample.end);
	},gate,env,sample.numChannels)
},
[
	Stream2Trig(
		1.0,
		Pseq(Array.geom(8.rand,2 ** -5, 2.0).scramble,inf)
	),
	Env.asr(release:0.1),
	Sample(":Sounds:floating_1"),
	StreamKrDur(
		Pslide(Array.series(q,0.0,4.0 / q),inf,rrand(3,5),rrand(1,6)),
		rrand(0.125,0.5)
	)
]).topGui

)


( // will stay beat locked and the beat will flow despite the cutting
q = rrand(8,32);

Patch({arg gate,env,sample,pchRatio;
	var pchRatioKr,start;
	pchRatioKr = sample.pchRatioKr * pchRatio;
	start = LFSaw.kr(GetTempo.kr * sample.beats.reciprocal, sample.end * 0.5, sample.end * 0.5);
	
	ReTrigger2.ar({
		PlayBuf.ar(sample.signal,sample.sampleRate,pchRatioKr,start.poll,0,sample.end);
	},gate,env,sample.numChannels)
},
[
	Stream2Trig(
		1.0,
		Pseq(Array.geom(8.rand,2 ** -5, 2.0).scramble,inf)
	),
	Env.asr(release:0.1),
	Sample(":Sounds:floating_1"),
	StreamKrDur(
		Pslide(Array.series(q,-2.0,2.0 / q).scramble,inf,rrand(3,5),rrand(2,5)),
		rrand(0.125,1.0)
	)
]).topGui

)


(
Patch({arg gate,env,sample;
	var p;
	p = PlayBuf.ar(sample.signal,sample.sampleRate,sample.pchRatioKr,0,0,sample.end);
	Enveloper2.ar(p,gate,env,sample.numChannels)
},
[
	Stream2Trig(`([1,0,1,0,0,1,0,1]),`(Array.fill(8,{ 2 ** rrand(-5,-1) }))),
	Env.perc(release:0.2),
	Sample(":Sounds:floating_1")
]).topGui

)

(
Patch({arg gate,env,sample,startBeat;
	var p,s,e;
	p = sample.pchRatioKr;
	s = startBeat * sample.beatsize;
	e = s + LFNoise1.kr(0.2,9000.0,5000.0);
	Enveloper.ar({ PlayBuf.ar(sample.signal,sample.sampleRate,p,s,s,e); },gate,env,4,sample.numChannels)
},
[
	Stream2Trig(`(Array.fill(128.rand,{[1,0.125,0,0].choose})),`(Array.fill(128.rand,{ 2 ** rrand(-7,-1) }))),
	Env.perc(release:3.0),
	s = Sample(":Sounds:floating_1"),
	StreamKrDur( Pfunc({ s.beats.rand.round(0.25) }),Pfunc({ 2 ** rrand(-4,2)}))
]).topGui

)


***/



