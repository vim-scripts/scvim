
StreamKrDur

superclass: StreamKr ... AbstractPlayer

StreamKrDur.new(pattern,durations,lagTime)

This plays a pattern in real time on the client, and sends those values as /c_set messages to its bus on the server.
Durations are specified in beats by a second pattern.

Its timing are exact, its messages are sent to the server with a small latency period before they should be played. That is to say when you start playing a StreamKrDur, it will run slightly and exactly ahead of time.
It is cancellable and stoppable within the value of Server-latency.

It is extremely efficient in CPU usage on the client, using less than it takes to switch from one text window to another.

	pattern
		a Pattern or Stream of floats	
	durations
		a float specifying the beat constant duration
		a stream or pattern of beat durations
		or a ref to an array of beat durations eg `[0.25,0.5,1]
	lag
		lag time for a Lag.kr that will be added to the output. 
		if 0.0 (default) no Lag will be used.


dalek mating season I
(
	var freq;
	
	freq = StreamKrDur(
			Prand(Array.fill(rrand(4,16),{ rrand(20,80).midicps }),inf),
			 0.25,// a float
			 0.1);

	Tempo.bpm = 100; // times are in beats
	
	Patch({ arg freq;
		Saw.ar(freq,0.2)
	},[
		freq
	]).play
)



(
	var freq;
	
	freq = StreamKrDur(
	 		Pbrown(40,100,100,inf),
	 		`[ 1,2, 0.25], // an array
	 		0.05);

	Tempo.bpm = 100; // times are in beats
	Patch({ arg freq=440;
		SinOsc.ar(freq,SinOsc.ar(600,0,0.3))
		//PMOsc.ar(freq,100,1.0,0,0.3)
	},[
		freq
	]).play
)

		
dalek mating season II
(
var freq,freq2,pmindex;
	
	freq = StreamKrDur(
			Prand(Array.fill(rrand(4,16),{ rrand(20,80).midicps }),inf),
			 0.25,// a float
			 0.1);
			
	freq2 =  StreamKrDur(
	 		Pbrown(40,100,100,inf),
	 		`[ 1,2, 0.25], // an array
	 		0.05);
	 		
	 pmindex = StreamKrDur(
		 		Pbrown(1.5,3.0,0.1,inf),
		 		Prand([0.25,0.125,1.0,3.0],inf), // a pattern
		 		0.1);

	Tempo.bpm = 100; // times are in beats
	Patch({ arg freq,freq2,pmindex;
			PMOsc.ar(freq,freq2,pmindex,0,0.3)
	},[
		freq,
		freq2,
		pmindex
	]).gui
)


same thing with a separated Instr
(
	Instr([\oscillOrc,\pmosc],{ arg freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0;
			PMOsc.ar(freq,freq2,pmindex,phasemod,amp)
	});

	p=Patch.new([ 'oscillOrc', 'pmosc' ],
	[
		StreamKrDur(
			Prand(Array.fill(rrand(4,16),{ rrand(20,80).midicps }),inf),
			 0.25,// a float
			 0.1),
	 	StreamKrDur(
	 		Pbrown(40,100,100,inf),
	 		`[ 1,2, 0.25], // an array
	 		0.05),
	 	StreamKrDur(
	 		Pbrown(1.5,3.0,0.1,inf),
	 		Prand([0.25,0.125,1.0,3.0],inf), // a pattern
	 		0.1),
	 	0,
	 	0.3	
	 ]);
		 
	 p.gui;
)

A metronome

(
var nome,layout;
nome = Patch({ arg beat,freq,amp;
		Decay2.ar(
			K2A.ar(beat), 0.01,0.11,
			SinOsc.ar( freq, 0, amp )
		)
	},[
		BeatClockPlayer.new(4.0),
		StreamKrDur(
			Pseq([ 750, 500, 300, 500, 750, 500, 400, 500, 750, 500, 400, 500, 750, 500, 400, 500 ],inf),
			1.0),
		StreamKrDur(
			Pseq([1,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25] * 0.01,inf),
			1.0)
	]);
layout = FlowView.new;

ToggleButton(layout,"Nome",{
	if(nome.isPlaying.not,{ nome.play(atTime: 4) })
},{
	if(nome.isPlaying,{ nome.stop })
},minWidth: 250);

)

In this case since the beat clock, and both stream kr durs are running all at the same tempo, you
could better use an InstrGateSpawner and do separate events. Only one scheduler then instead of 2.
See the example there.

But if you wanted them in different syncs, different streams and a continous running synth
(have fun with the Decay), then this would be a good starting point.


with a Pbind you are creating a new event for every note and creating new UGens and a new Synth each time. this is not so efficient. what I am doing here is like an analog synth: the oscillators play constantly and it is gated to create notes. its more fluid, liquid and uses significantly less cpu. this can even be done with samples.
(

	Tempo.bpm = 130;
	
	Instr([\oscillOrc,\trigged, \pmosc],{ arg trig=0.0,freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0;
			PMOsc.ar(
				freq,
				freq2,
				pmindex,
				phasemod,
				Decay2.kr(trig)
			)
	});

	p=Patch.new([\oscillOrc,\trigged, \pmosc],
	[
		BeatClockPlayer(16.0),
		
		StreamKrDur(
			Prand(Array.fill(rrand(4,16),{ rrand(20,80).midicps }),inf),
			 0.25,// a float
			 0.1),
	 	StreamKrDur(
	 		Pbrown(40,100,100,inf),
	 		`[ 1,2, 0.25], // an array
	 		0.05),
	 	StreamKrDur(
	 		Pbrown(1.5,3.0,0.1,inf),
	 		Prand([0.25,0.125,1.0,3.0],inf), // a pattern
	 		0.1),
	 	0,
	 	0.3	
	 ]);
		 
	 p.gui;
)

	
	
//durations will be multiples of trigger pulse
//
//stream kr dur has to find the lowest common multiple
//
//l = [0.125,0.25,1.0,1.5];
//
//l = [0.25,0.25 + 0.125, 1.0,1.5];
//
////fails
//l = Array.fill(8,{ rrand(0.1,0.5) });
//
//(l % (l.minItem)) every is 0
//or
//
//g = (l % (l.minItem)).reject({ arg t; t==0 }).minItem
//
//l / g should be all integers
//	or it fails
//


