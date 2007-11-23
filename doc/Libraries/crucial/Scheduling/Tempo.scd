
Tempo			 tempo calculations

This class represents the concept of tempo. It can be used for translations between seconds, beats and bars. It holds an instance of TempoClock which it sets to its own tempo whenever that is changed.

A TempoBus can be started on the server, and it will keep the Tempo object's tempo as a float value on a Bus on the server. UGens can use this for scaling their frequencies for beat based rhythms etc.

It can be used to convert beats <-> seconds, but this value is only accurate at the time you make the computation. If the tempo is changed the value is of course no longer valid. TempoBus adds itself as a dependant to the Tempo object, so when the tempo changes, it is informed, and it updates the value on the bus accordingly.

Tempo.bpm = 170;
Tempo.tempo = 2.3; // in beats per second

Tempo.gui; // there is a gui class

Tempo.bpm = 170;
Tempo.beats2secs(4.0).postln;

Tempo.bpm = 10;
Tempo.beats2secs(4.0).postln;


All class methods refer to the default global tempo.
You can create an instance of Tempo if you need individual, separate tempii. 

t = Tempo.new;
u = Tempo.new;

t.bpm = 170;
u.tempo = 1.3; // in beats per second
t.gui;

All of the following methods exist as class methods (the default tempo)
and as instance methods.

bpm
bpm_(beatsPerMinute)
	Tempo.bpm = 96;
	or
	Tempo.bpm_(96);
tempo
	in beats per second
tempo_(beatsPerSecond)
	Tempo.tempo = 2.0;
	or
	Tempo.tempo_(2.0);
	
beats2secs(beats)
secs2beats(seconds)
bars2secs(bars)
	you can change the beats per bar:
		Tempo.beatsPerBar = 7.0;
secs2bars(seconds)

sched(delta,function)
	Schedule a function to be evaluated delta beats from now.

	If you change the tempo after scheduling, your function will still
	be evaluated at the time originally calculated. A more sophisticated
	solution will be presented later.

schedAbs(beat,function)
	Schedule a function to be evaluated at an absolute beat, as measured
	from the time SuperCollider first booted up. Use OSCsched for more
	sophisticated control (able to reset the beat).

	If you change the tempo after scheduling, your function will still
	be evaluated at the time originally calculated. A more sophisticated
	solution will be presented later.

	





