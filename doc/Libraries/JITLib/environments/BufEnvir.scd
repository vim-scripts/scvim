
BufEnvir					referentially transparent buffer environment

superclass: EnvironmentRedirect



see also: Buffer


	*new(server)		Return a new instance. The server should be running.
	
	put(key, obj)		put an object in the environment that can be converted to buffer values.
					the buffer on the server is updated immediately, the buffer number is kept.
					currently supported are Arrays and Nil (nil deallocating the buffer)
	
	at(key)			return the buffer at a certain key. If none exist, allocate a buffer number.
	
	bufnum(key)		return the buffer number at a certain key
	
	alloc(key, numFrames, numChannels)
					allocate a buffer at the given key. The old bufnum, if it exists is kept.
	
	read(key, path, startFrame, numFrames, completionMessage)	read a file to buffer
				
	zero(key)			overwrite the buffer with zeroes
	
	fft(key, size, numChannels)	create a buffer for FFT
	
	fftsize_			set the environments default size for fft (default is 2048)
	
	clear(removeReferences)			
					deallocate all buffers, free the memory on the server.
					if removeReferences is set to true, buffer objects and numbers are removed.
					(default: false)





// examples

q = q ? (); // a general storage place
q.b = BufEnvir(s.boot); // add a buf envir

q.b[\x]= [0, 2, 3.2, 5, 7, 8, 10];
q.b[\x].bufnum


// buffers are created transparently (wherever you look there are buffers..)
q.b[\y];
q.b[\y].bufnum;
q.b[\y].numChannels;
q.b[\z].bufnum;
q.b[\c] = [1, 2, 3];
q.b[\c].bufnum;
q.b[\y].numChannels;
q.b[\y] = nil; // deallocate
q.b[\c] = nil;
q.b[\z] = nil;
q.b[[\y, \c, \z]]; // equivalent
q.b[[\y, \c, \z]] = [nil];// equivalent



(
SynthDef("help_PlayBuf", { arg out=0, bufnum=0, sustain=1, amp=0.1, rate=1, offset=0;
	Out.ar(out,
		EnvGen.kr(Env.linen(0, sustain, 0.02), doneAction:2) *
		PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum),
			startPos: offset * BufFrames.kr(bufnum)
		) * (10 * amp)
	)
}).store
);
)

// start a process
(
q.rout = Routine {
	var dt;
	loop {
		dt = exprand(0.01, 1.2);
		Synth(\help_PlayBuf, [
			\bufnum, q.b[\apollo],
			\rate, 0.06 * [1, 2, 3, -1, -2, -3].choose + 1,
			\offset, 1.0.rand,
			\sustain, dt * rrand(1.0, 1.3);
		]);
		dt.wait;
	}
}.play;
)

// read a sample later
q.b.read(\apollo, "sounds/a11wlk01.wav");
q.b.zero(\apollo); // make empty.


// proxyspace examples:

p = ProxySpace.push(s);
~out.play;


q.b[\x]= [0, 2, 3.2, 5, 7, 8, 10];

//____
(
~out = {
	SinOsc.ar(
		DegreeToKey.kr(q.b[\x].bufnum, MouseX.kr(0, 15), 12, 1, 72).midicps
		*
		LFNoise1.kr([4,4], 0.01, 0.5)
) * 0.1 ! 2
};
)


//____
(
~out = {
	var index = Duty.kr(0.16, 0, Dbufrd(q.b[\z].bufnum, Dseries(0, 1, inf)));
	RLPF.ar(
		LFTri.ar(
			DegreeToKey.kr(q.b[\x].bufnum, index, 12, 1, 60).midicps
		),
		[1000, 9000]
	).sum
	* 0.1 ! 2
};
)

q.b[\z] = [0, 3, 2, 8, 2, 2];
q.b[\z] = [0, 3, 2, 8, 2, 2].curdle(0.5).scramble.flat;
q.b[\z] = [0, 3, 2, 7, 2, 2] ++ [0, 3, 2, 8, 2, 2].curdle(0.5).scramble.flat;

q.b[\x]= [0, 1, 4, 5, 7, 9, 10];
q.b[\z]= nil;
q.b[\z] = Pseq([Prand([3, 4, 5], 3), Pseq([1, 2, 5, 1, 3], 3)], inf).asStream.nextN(128);


//____
~out.fadeTime = 30;
(
~out = {
	var dt = 0.16;
	var index = Duty.kr(dt, 0, Dbufrd(q.b[\z].bufnum, Dseries(0, -1, inf)));
	RLPF.ar(
		LFTri.ar(
			DegreeToKey.kr(q.b[\x].bufnum, index, 12, 1, 42).midicps
		),
		[1000, 9000],
		0.1
	).sum * Decay.kr(Impulse.kr(1 / dt), 0.5)
	* 0.3 ! 2
};
)


// play an empty buffer
(
~out = {	
	var n = q.b[\y].bufnum;
	PlayBuf.ar(q.b[\y].numChannels ? 1, n, BufRateScale.kr(n), loop:1)
};

)

// read a sample later
q.b.read(\y, "sounds/a11wlk01.wav");

(
~out = {	
	var n = q.b[\y].bufnum;
	var rate = DegreeToKey.kr(q.b[\x].bufnum, MouseX.kr(0, 15), 12).midicps;
	PlayBuf.ar(1, n, BufRateScale.kr(n) * (rate * 0.1), loop:1) * 0.1 ! 2
};

)


// fft buffers
(
~out = { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	//in = WhiteNoise.ar(0.2);
	chain = FFT(q.b.fft(\fft1), in, in.numChannels);
	chain = PV_MagAbove(chain, 310);
	Out.ar(out, 0.5 * IFFT(chain));
};
)


// read all sounds in the sounds folder
(
var i = 0, path;
path = "sounds";
pathMatch(path ++ "/*").do {|p| protect { q.b.read(i, p) } { i = i + 1; i.postln } }
)


q.b.envir.collect(_.numChannels)
q.b.envir.do(_.updateInfo)

// play them
(
~out = {	
	var i = 2;
	var n = q.b[i].bufnum;
	PlayBuf.ar(q.b[i].numChannels ? 1, n, BufRateScale.kr(n), loop:1)
};
)

~out.play;

~out.stop;



// clear all, free memory.

q.b.clear;



