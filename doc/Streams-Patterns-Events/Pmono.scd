
Pmono

superclass: Pattern


Pmono(synthDefName, patternPairs)

Plays one instance of a synth. The pattern pairs define changes in that one synth's controls.
If event[\id] is not nil, Pmono simply directs its pattern changes to that node and does not create an extra synth.

examples:

p = Pmono("default", \dur, 0.2, \freq, Pwhite(1,8) * 100 ).play

p.stop

// multi channel expansion is supported:

p = Pmono("default", \dur, 0.2, \freq, Pwhite(1,8) * 100, \detune, [0,2,5,1]).play

p.stop


// the following example will end after 5 seconds
// or you can stop it sooner with a stop message

(
	p = Pfindur(5,
		Pset(\detune,Pwhite(0,1.0) * [0,1,3,7],
			Ppar([
				Pmono("default", \dur, 0.2, \freq, Pwhite(1,8) * 100 ),
				Pmono("default", \dur, 0.1, \freq, Pwhite(1,8) * 300)
			])
		)
	).play;
)
p.stop;




