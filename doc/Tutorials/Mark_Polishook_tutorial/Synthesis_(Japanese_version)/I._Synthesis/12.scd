
12.



SynthDefSynthDef

(
// 
b = Buffer.read(s, "sounds/a11wlk01.wav");

//  ... 
SynthDef("aMonoSamplePlayer", { arg bus = 0, bufnum = 0, rateScale = 1;
	Out.ar(
		bus,
		PlayBuf.ar(
			1,
			bufnum,
			BufRateScale.kr(bufnum) * rateScale
		)
		*
		EnvGen.kr(Env.sine(BufDur.kr(bufnum)))
	)
}).load(s);
)

(
// SynthDef ... 
Synth("aMonoSamplePlayer", [\bus, 0, \bufNum, b.bufnum]);
)


(
//  ...
// \busSynthDef
// 12
// 
Synth("aMonoSamplePlayer", [\bus, 0, \bufNum, b.bufnum, \rateScale, 0.99]);
Synth("aMonoSamplePlayer", [\bus, 1, \bufNum, b.bufnum, \rateScale, 1.01])
)

////////////////////////////////////////////////////////////////////////////////////////////////////



BufRateScaleBufDurUGenPlayBufPlayBuf

BufRateScaleBufDurInfoUGenbaseBufInfoUGenBaseUGen

UGen

InfoUGenBase.dumpClassSubtree



InfoUGenBase
[
 NumRunningSynths
 NumBuffers
 NumControlBuses
 NumAudioBuses
 NumInputBuses
 NumOutputBuses
 ControlRate
 RadiansPerSample
 SampleDur
 SampleRate
]
InfoUGenBase


BufInfoUGenBase.dumpClassSubtree



BufInfoUGenBase
[
 BufChannels
 BufDur
 BufSamples
 BufFrames
 BufRateScale
 BufSampleRate
]
BufInfoUGenBase


////////////////////////////////////////////////////////////////////////////////////////////////////





(
// 
SynthDef("soundFileFilter", { arg bus = 0, freq = 440, rq = 0.05;
	ReplaceOut.ar(
		bus,
		BPF.ar(					// a bandpass filter
			In.ar(0, 2),
			[freq * 0.99, freq * 1.5],
			rq
		)
	)
}).load(s);
)

// 
(
~source = Group.head(s);
~effect = Group.tail(s);
)

// 
// 
(
Synth.head(~effect, "soundFileFilter", [\out, 0, \freq, 500.rrand(1000), \rq, 0.04.rrand(0.1)]);
Synth.head(~source, "aMonoSamplePlayer", [\bus, 0, \bufNum, b.bufnum]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////



PlayBufloop

PlayBufloop


////////////////////////////////////////////////////////////////////////////////////////////////////

SynthDef1SynthDef2SynthDef3SynthDef

123

2

(
// 
b = Buffer.read(s, "sounds/a11wlk01.wav");

// 
SynthDef("aLoopingSamplePlayer", { arg outBus = 0, bufnum = 0, rateScale = 1, mul = 1;
	Out.ar(
		outBus,
		PlayBuf.ar(
			1,
			bufnum,
			BufRateScale.kr(bufnum) * rateScale + LFNoise1.kr(2.reciprocal, 0.05),
			loop: 1				// 
		)
		*
		mul
	)
}).load(s);

// 
SynthDef("ampMod", { arg inBus = 0, outBus = 0, modFreq = 1;
	Out.ar(
		outBus,
		[In.ar(inBus, 1) * SinOsc.kr(modFreq), In.ar(inBus, 1) * SinOsc.kr(modFreq - 0.02)]
	)
}).load(s);

// 
SynthDef("aLowPassFilter", { arg inBus = 0, outBus = 0, freq = 300, freqDev = 50, boost = 1;
	Out.ar(
		outBus,
		RLPF.ar(
			In.ar(inBus, 2),
			Lag.kr(LFNoise0.kr(1, freqDev, freq), 1),
			0.1
		)
		*
		boost
	)
}).load(s);
)

// 
(
~source = Group.head(s);
~effect = Group.tail(~s);
)

(
// 
Synth.head(
	~source,
	"aLoopingSamplePlayer", [\outBus, 3, \bufNum, b.bufnum, \rateScale, 1, \mul, 0.051]);
// 
Synth.head(
	~effect,
	"ampMod", [\inBus, 3, \outBus, 5, \modFreq, 1]);
// 
Synth.tail(
	~effect,
	"aLowPassFilter", [\inBus, 5, \outBus, 0, \boost, 5])
)



Group (RootNode, ID 0)
   /\
  / \
~source ~effects				// ~source~effects
|    |   \
|    |    \
synth  synth  synth	


////////////////////////////////////////////////////////////////////////////////////////////////////



(
~source = Group.head(s);
~effect = Group.tail(~s);
)

(
Synth.head(
	~source,
	"aLoopingSamplePlayer", [\outBus, 3, \bufNum, b.bufnum, \rateScale, 1, \mul, 0.051]);
Synth.head(
	~effect,
	"ampMod", [\inBus, 3, \outBus, 5, \modFreq, 1000]);
Synth.tail(
	~effect,
	"aLowPassFilter", [\inBus, 5, \outBus, 0, \freq, 500, \freqDev, 200, \boost, 7])
)

////////////////////////////////////////////////////////////////////////////////////////////////////


