
Pattern

superclass: AbstractFunction

Patterns versus Streams

	Pattern is an abstract class that is the base for the Patterns library. These classes form a 
rich and concise score language for music. The series of help files entitled Streams-Patterns-Events
gives a detailed introduction. This attemps a briefer characterization.

	A Stream is an object that responds to next, reset, and embedInStream. Streams
represent sequences of values that are obtained one at a time by with message next. A reset
message will cause the stream to restart (many but not all streams actually repeat themselves.)
If a stream runs out of values it returns nil in response to next. The message embedInStream
allows a stream definition to allow another stream to "take over control" of the stream.
All objects respond to next and reset,most by returning themselves in response to next. 
Thus, the number 7 defines a Stream that produces an infinite sequence of 7's. Most objects
respond to embedInStream with a singleton Stream that returns the object once.

	A Pattern is an object that responds to asStream and embedInStream. A Pattern
defines the behavior of a Stream and creates such streams in response to the messages asStream.
The difference between a Pattern and a Stream is similar to the difference between a score and a
performance of that score or a class and an instance of that class. All objects respond to this interface,
most by returning themselves. So most objects are patterns that define streams that are an infinite
sequence of the object and embed as singleton streams of that object returned once.

	Patterns are defined in terms of other Patterns rather than in terms of specific
values. This allows a Pattern of arbitrary complexity to be substituted for a
single value anywhere within a Pattern definition. A comparison between a Stream
definition and a Pattern will help illustrate the usefulness of Patterns.

example 1 - Pseq vs. Routine

The Pattern class Pseq(array, repetitions) defines a Pattern that will create a Stream that iterates
an array. The class Routine(func, stackSize) defines a single Stream, the function that runs within
that stream is defined to perform the array iteration.

Below a stream is created with Pseq and an asStream message and an identical stream is
created directly using Routine.

// a Routine vs a Pattern
(

	a = [-100,00,300,400];					// the array to iterate

	p = Pseq(a);							// make the Pattern
	q = p.asStream;						// have the Pattern make a Stream
	r = Routine({ a.do({ arg v; v.yield}) }) ;		// make the Stream directly

	5.do({ Post << Char.tab << r.next << " " << q.next << Char.nl; });
)

example 2 - Nesting patterns

	In example 1, there is little difference between using Pseq and Routine. But Pseq actually
iterates its array as a collection of patterns to be embedded, allowing another Pseq to replace any
of the values in the array. The Routine, on the other hand, needs to be completely
redefined.

(
	var routinesA;
	a = [3, Pseq([-100,00,300,400]), Pseq([-100,00,300,400].reverse) ];
	routinesA = [[3], [-100,00,300,400], [-100,00,300,400].reverse];
	p = Pseq(a);
	q = p.asStream;

	r = Routine({
		routinesA.do({ arg v;
			v.do({ arg i; i.yield})
		}) ;
	});
	10.do({ Post << Char.tab << r.next << " " << q.next << Char.nl; });
)	

example 3 - Stream-embedInStream

The message embedInStream is what allows Patterns to do this kind of nesting. Most objects
(such as the number 3 below) respond to embedInStream by yielding themselves once and returning.
Streams respond to embedInStream by iterating themselves to completion, effectively "taking over" the
calling stream for that time. 

A Routine can perform a pattern simply by replacing calls to yield with calls to embedInStream.
(
	a = [3, Pseq([-100,00,300,400]), Pseq([-100,00,300,400].reverse) ];

	r = Routine({ a.do({ arg v; v.embedInStream}) }) ;
	p = Pseq(a);
	q = p.asStream;
	10.do({ Post << Char.tab << r.next << " " << q.next << Char.nl; });
)	

Of course, there is no concise way to define this stream without using Pseq.

note: For reasons of efficiency, the implementation of embedInStream assumes that it is called from
within a Routine. Consequently, embedInStream should never be called from within the function that
defines a FuncStream or a Pfunc (the pattern that creates FuncStreams).

Event Patterns

	An Event is a Environment with a 'play' method. Typically, an Event consists of
a collection of key/value pairs that determine what the play method actually does.
The values may be any object including functions defined in terms of other named attributes. 
Changing those values can generate a succession of sounds sometimes called 'music'...
The pattern Pbind connects specific patterns with specific names. Consult its help page for
details.

..................

	
A Summary of Pattern classes

	Below are brief examples for most of the classes derived from Pattern. These examples
all rely on the patterns assigned to the Interpreter variable p, q, and r in the first block of code.


(
SynthDef(\cfstring1.postln, { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
	var out, eg, fc, osc, a, b, w;
	fc = LinExp.kr(LFNoise1.kr(Rand(0.25,0.4)), -1,1,500,2000);
	osc = Mix.fill(8, {LFSaw.ar(freq * [Rand(0.99,1.01),Rand(0.99,1.01)], 0, amp) }).distort * 0.2;
	eg = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	out = eg * RLPF.ar(osc, fc, 0.1);
	#a, b = out;
	Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).store;

SynthDef("sinegrain2",
	{ arg out=0, freq=440, sustain=0.05, pan;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.3), doneAction:2);
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).store;

p = Pbind(
	[\degree, \dur], Pseq([[0,0.1],[2,0.1],[3,0.1],[4,0.1],[5,0.8]],1),
	\amp, 0.05, \octave, 6, \instrument, \cfstring1, \mtranspose, 0);

q = Pbindf(p, \instrument, \default );

r = Pset(\freq, Pseq([500, 600, 700], 2), q);

)

// EVENT PATTERNS - patterns that generate or require event streams

	// Pbind( ArrayOfPatternPairs )
	
	p = Pbind(
		[\degree, \dur], Pseq([[0,0.1],[2,0.1],[3,0.1],[4,0.1],[5,0.8]],1),
		\amp, 0.05, \octave, 6, \instrument, \cfstring1, \mtranspose, 0);
		
	p.play;
	
	//Ppar(arrayOfPatterns, repeats) - play in parallel
	
	Ppar([Pseq([p],4),Pseq([Pbindf(q,\ctranspose, -24)],5)]).play
	
	//Ptpar(arrayOfTimePatternPairs, repeats) - play in parallel at different times
	
	Ptpar([1,Pseq([p],4),0, Pseq([Pbindf(q,\ctranspose, -24)],5)]).play
	
	// Pbindf( pattern, ArrayOfNamePatternPairs )
	
	q = Pbindf(p, \instrument, \default );
	q.play;
	
	//Pfset(function, pattern) 
	// function constructs an event that is passed to the pattern.asStream
	
	Pfset({ ~freq = Pseq([500, 600, 700], 2).asStream }, q).play;
	
	//Pset(name, valPattern, pattern) 
	// set one field of the event on an event by event basis (Pmul, Padd are similar)
	
	Pset(\freq, Pseq([500, 600, 700], 2), q).play;
	
	//Psetp(name, valPattern, pattern)
	// set once for each iteration of the pattern (Pmulp, Paddp are similar)
	
	r = Pset(\freq, Pseq([500, 600, 700], 2), q);
	
	Psetp(\legato, Pseq([0.01, 1.1],inf), r).play;
	
	//Psetpre(name, valPattern, pattern)
	// set before passing the event to the pattern (Pmulpre, Paddpre are similar)
	
	r = Psetpre(\freq, Pseq([500, 600, 700], 2), q);
	
	Psetp(\legato, Pseq([0.01, 1.1],inf), r).play;
	
	//Pstretch(valPattern, pattern)
	// stretches durations after
	
	r = Psetpre(\freq, Pseq([500, 600, 700], 2), q);
	
	Pstretch(Pn(Env([0.5,2,0.5], [10,10])), Pn(r)).play;
	
	Pset(\stretch, Pn(Env([0.5,2,0.5], [10,10]) ), Pn(r)).play
	
	//Pstretchp(valPattern, pattern)
	// stretches durations after
	
	r = Psetpre(\freq, Pseq([500, 600, 700], 2), q);
	
	Pstretchp(Pn(Env([0.5,2,0.5], [10,10])), r).play;
	
	// Pfindur( duration, pattern ) - play pattern for duration
	
	Pfindur(2,Pn(q,inf)).play;
	
	// PfadeIn( pattern, fadeTime, holdTime, tolerance )
	PfadeIn(Pn(q), 3, 0).play(quant: 0);
	
	// PfadeOut( pattern, fadeTime, holdTime, tolerance )
	PfadeOut(Pn(q), 3, 0).play(quant: 0);
	
	// Psync( pattern, quantization, dur, tolerance )
	// pattern is played for dur seconds (within tolerance), then a rest is played so the next pattern
	
	Pn(Psync(
		Pbind(	\dur, Pwhite(0.2,0.5).round(0.2),
				\db, Pseq([-10,-15,-15,-15,-15,-15,-30])
		), 2,3
	)).play
	
	//Plag(duration, pattern)
	
	Ppar([Plag(1.2,Pn(p,4)),Pn(Pbindf(q,\ctranspose, -24),5)]).play
	
// GENERAL PATTERNS that work with both event and value streams

	//Ptrace(pattern, key, printStream) - print the contents of a pattern
	
	r = Psetpre(\freq, Pseq([500, 600, 700], 2), q);
	
	Ptrace(r).play;
	Ptrace(r, \freq).play;
	
	(
	{ var printStream;
		printStream = CollStream.new;
		Pseq([Ptrace(r, \freq, printStream), Pfunc({printStream.collection.dump; nil }) ]).play;
		
	}.value;
	)	
	
	//Pseed(seed, pattern) - set the seed of the random number generator
	// to force repetion of pseudo-random patterns
	
	Pn(Pseed(44, Pbindf(q,\ctranspose,Pbrown(-3.0,3.0, 10) ) ) ).play;

	//Proutine(function) - on exit, the function must return the last value returned by yield
	// (otherwise, the pattern cannot be reliably manipulated by other patterns)
	
	Proutine({ arg inval;
		inval = p.embedInStream(inval);
		inval = Event.silent(4).yield;
		inval = q.embedInStream(inval);
		inval = r.embedInStream(inval);
		inval;
	}).play

	//Pfunc(function) - the function should not have calls to embedInStream, use Proutine instead.
		
		Pn(Pbindf(q,\legato, Pfunc({ arg inval; if (inval.at(\degree)== 5) {4} {0.2}; })) ).play

	// the following patterns control the sequencing and repetition of other patterns
	
		//Pseq(arrayOfPatterns, repeats) - play as a sequence
		
		Pseq([Pseq([p],4),Pseq([Pbindf(q,\ctranspose, -24)],5)]).play
		
		//Pser(arrayOfPatterns, num) - play num patterns from the arrayOfPatterns
		
		Pser([p,q,r],5).play
		
		//Place(arrayOfPatterns, repeats) - similar to Pseq
		// but array elements that are themselves arrays are iterated
		// embedding the first element on the first repetition, second on the second, etc
		
		Place([[p,q,r],q,r],5).play
		
		
		// Pn( pattern, patternRepetitions ) - repeat the pattern n times
		
		Pn(p,2).play;
		
		// Pfin( eventcount, pattern ) - play n events from the pattern
		
		Pfin(12,Pn(p,inf)).play;
		
		// Pstutter( eventRepetitions, pattern ) - repeat each event from the pattern n times
		
		Pstutter(4,q).play
		
		//Pwhile(function, pattern)
		
		Pwhile({coin(0.5).postln;}, q).play
		
		// Pswitch( patternList, selectPattern ) - when a pattern ends, switch according to select
		
		Pswitch([p,q,r], Pwhite(0,100)).play
		
		// Pswitch1( patternList, selectPattern ) - on each event switch according to select
		
		Pn(Pswitch1([p,q,r], Pwhite(0,2))).play
		
		// Prand( patternList, repeats ) - random selection from list		
		Prand([p,q,r], inf).play

		// Pxrand( patternList, repeats ) - random selection from list without repeats		
		Pxrand([p,q,r], inf).play

		// Pwrand( patternList, weights, repeats ) - weighted random selection from list		
		Pwrand([p,q,r], #[1, 3, 5].normalizeSum, inf).play

		// Pwalk( patternList, stepPattern, directionPattern ) - walk through a list of patterns
		
		Pwalk([p,q,r], 1, Pseq([-1,1], inf)).play

		// Pslide(list, repeats, length, step, start)

		 Pbind(\degree, Pslide(#[1, 2, 3, 4, 5], inf, 3, 1, 0), \dur,0.2).play

		// Pshuf( patternList, repeats ) - random selection from list		
		Pn(Pshuf([p,q,r,r,p])).play

		// Ptuple(list, repeats)

		 Pbind(\degree,Ptuple([Pwhite(1,-6), Pbrown(8,15,2)]),
		 	\dur, Pfunc({ arg ev; ev.at(\degree).last/80 round: 0.1}),
		 	\db, Pfunc({ if (coin(0.8)) {-25} {-20} })
		 ).play


	// the following patterns can alter the values returned by other patterns
	
		//Pcollect(function, pattern)
		
		Pcollect({ arg inval; inval.use({ ~freq = 1000.rand }); inval}, q).play
		
		//Pselect(function, pattern)
		
		Pselect({ arg inval; inval.at(\degree) != 0 }, q).play(quant: 0)
		
		//Preject(function, pattern)
		
		Preject({ arg inval; inval.at(\degree) != 0 }, q).play(quant: 0)
		
	//Ppatmod(pattern, function, repeats) -
	// function receives the current pattern as an argument and returns the next pattern to be played
	
	Ppatmod(p, { arg oldPat; [p,q,r].choose }, inf).play

// VALUE PATTERNS: these patterns define or act on streams of numbers

	// Env as a pattern
	
	Pbindf(Pn(q,inf),\ctranspose, Pn(Env.linen(3,0,0.3,20),inf) ).play;
	
	// Pwhite(lo, hi, length)
	
	Pbindf(Pn(q,inf),\ctranspose,Pwhite(-3.0,3.0) ).play;
	
	// Pbrown(lo, hi, step, length)
	
	Pbindf(Pn(q,inf),\ctranspose,Pbrown(-3.0,3.0, 2) ).play;
	
	// Pseries(start,step, length)
	
	Pbindf(Pn(q,inf),\ctranspose,Pseries(0,0.1,10) ).play;
	
	// Pgeom(start,step, length)
	
	Pbindf(Pn(q,inf),\ctranspose,Pgeom(1,1.2,20) ).play;
	
	// Pwrap(pattern,lo, hi)
	
	Pbind(\note, Pwrap(Pwhite(0, 128), 10, 20).round(2), \dur, 0.05).play;
	
	// PdegreeToKey(pattern, scale, stepsPerOctave)
	// this reimplements part of pitchEvent (see Event)
	
	Pbindf(Pn(q,inf),\note,PdegreeToKey(Pbrown(-8, 8, 2), [0,2,4,5,7,9,11]) ).play;
	
	// Prewrite(pattern, dict, levels) - see help page for details.
	// (notice use of Env to define a chord progression of sorts...
	
	Pbind(\degree,
		Prewrite(0,	(	0: #[2,0],
	 					1: #[0,0,1],
	 					2: #[1,0,1]
	 				), 4
	 	) + Pn(Env([4,0,1,4,3,4], [6.4,6.4,6.4,6.4,6.4],'step')),
	 	\dur, 0.2).play

	// PdurStutter( repetitionPattern, patternOfDurations ) -
	Pbindf(Pn(q), \dur, PdurStutter(
		Pseq(#[1,1,1,1,1,2,2,2,2,2,3,4,5,7,15],inf),
		Pseq(#[0.5],inf)
		)
	).play;
	

	// Pstep2add( pat1, pat2 ) 
	// Pstep3add( pat1, pat2, pat3 ) 
	// PstepNadd(pat1,pat2,...)
	// PstepNfunc(function, patternArray )
	// combine multiple patterns with depth first traversal

	Pbind(
		\octave, 4,
		\degree, PstepNadd(
					Pseq([1, 2, 3]),
					Pseq([0, -2, [1, 3], -5]),
					Pshuf([1, 0, 3, 0], 2)
				),
		\dur, PstepNadd(
					Pseq([1, 0, 0, 1], 2),
					Pshuf([1, 1, 2, 1], 2)
			).loop * (1/8),
		\legato, Pn(Pshuf([0.2, 0.2, 0.2, 0.5, 0.5, 1.6, 1.4], 4), inf),
		\scale, #[0, 1, 3, 4, 5, 7, 8]
	).play;
	



