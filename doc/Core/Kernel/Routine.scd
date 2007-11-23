
Routine

Superclass: Thread

Routines are functions that can return in the middle and then resume where
they left off when called again. Routines can be used to implement co-routines
as found in Scheme and some other languages.
Routines are useful for writing things that behave like Streams.
Routines inherit behaviour for math operations and filtering from Stream.

*new(func, stackSize, seed)

Creates a Routine instance with the given function.
The stackSize and random seed may be overridden if desired.

(
a = Routine.new({ 1.yield; 2.yield; });
a.next.postln;
a.next.postln;
a.next.postln;
)


value(inval)
resume(inval)
next(inval)

These are all synonyms for the same method.

The Routine function is either started if it has not been called yet, or it is
resumed from where it left off. The argument inval is passed as the argument
to the Routine function if it is being started, or as the result of the yield
method if it is being resumed from a yield. The result of the method will be
what the Routine yields.

There are basically 2 conditions for a Routine: one is when the routine starts. The other case is
that the routine continues after it has yielded.

When the routine starts (by calling the above methods), you are passing in a first inval.
This inval is accessible as the routine function argument:

(
Routine { arg inval;
	inval.postln;
}.value("hello routine");
)

When there is a yield in the routine, the next time you call next (or synonym), the routine continues
from there, and you get a chance to pass in a value from the outside. To access that value within the
continuing routine, you have to assign the result of the yield call to a variable:

(
r = Routine { arg inval;
	var valuePassedInbyYield;
	inval.postln;
	valuePassedInbyYield = 123.yield;
	valuePassedInbyYield.postln;
	
}
)

r.value("hello routine");
r.value("goodbye world");


Typically the name inval (or inevent) is reused, instead of declaring a variable like "valuePassedInbyYield":

(
r = Routine { arg inval;
	inval.postln;
	inval = 123.yield;
	inval.postln;
}
)

r.value("hello routine");
r.value("goodbye world");


Typically a routine uses a multiple yield, in which the inval is reassigned repeatedly:

(
r = Routine { arg inval;
	inval.postln;
	5.do { arg i;
		inval = (i + 10).yield;
		inval.postln;
	}
}
)
(
5.do {
	r.value("hello routine").postln;
}
)



reset

Causes the Routine to start from the beginning next time it is called.
A Routine cannot reset itself except by calling the yieldAndReset method.

See also in class Object :
yield(outval)
yieldAndReset(outval)
alwaysYield(outval)

If a Routine's function returns then it will always yield nil until reset.




play(clock, quant)
		clock:		a Clock, TempoClock by default
		quant:		either a number n (quantize to n beats)
					or an array [n, m] (quantize to n beats, with offset m)

In the SuperCollider application, a Routine can be played using a Clock, as can any Stream.
every time the Routine yields, it should do so with a float, the clock will interpret that, usually
pausing for that many seconds, and then resume the routine, passing it it the clock's current time.



Accessible instance variables



Routine inherits from Thread, which allows access to some of its state:


beats
	return the elapsed beats (logical time) of the routine. The beats do not proceed when the routine is
	not playing.
	
seconds
	return the elapsed seconds (logical time) of the routine. The seconds do not proceed when the routine is
	not playing, it is the converted beat value.

clock
	return the thread's clock. If it hs not played, it is the SystemClock.
	


(
r = Routine { arg inval;
	loop {
		// thisThread refers to the routine.
		postf("beats: % seconds: % time: % \n",
			thisThread.beats, thisThread.seconds, Main.elapsedTime
		);
		1.0.yield;
		
	}
}.play;
)

r.stop;
r.beats;
r.seconds;
r.clock;




Routine Example:

(
var r, outval;
r = Routine.new({ arg inval;
	("->inval was " ++ inval).postln;
	inval = 1.yield;
	("->inval was " ++ inval).postln;
	inval = 2.yield;
	("->inval was " ++ inval).postln;
	inval = 99.yield;
});

outval = r.next('a');
("<-outval was " ++ outval).postln;
outval = r.next('b');
("<-outval was " ++ outval).postln;
r.reset; "reset".postln;
outval = r.next('c');
("<-outval was " ++ outval).postln;
outval = r.next('d');
("<-outval was " ++ outval).postln;
outval = r.next('e');
("<-outval was " ++ outval).postln;
outval = r.next('f');
("<-outval was " ++ outval).postln;
)



(
var r;
r = Routine.new({
	10.do({ arg a;
		a.postln;
		// Often you might see Wait being used to pause a routine
		// This waits for one second between each number
		1.wait;
	});
	// Wait half second before saying we're done
	0.5.wait;
	"done".postln;
});

SystemClock.play(r);
)






