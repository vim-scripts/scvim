TempoClock tempo based scheduler


TempoClock is a scheduler like SystemClock, but it schedules relative to a tempo in beats per second.

*new(tempo, beats, seconds)
 Create a new TempoClock scheduler with the given tempo and starting times.
 
If not given, tempo defaults to one, beats defaults to zero and seconds defaults to the current elapsed time.

stop
 destroy the scheduler. releases the OS thread running the scheduler.

 
tempo
 get the current tempo in beats per second.
 
tempo_(beatsPerSecond)
 set the current tempo.
 t.tempo = 2.0;
 or
 t.tempo_(2.0);

beatDur
 get the current beat duration in seconds.
 

elapsedBeats
 get the current elapsed time in beats.
 This is equivalent to: tempoClock.secs2beats(Main.elapsedTime).
 It is often preferrable to use beats instead of elapsedBeats because beats uses a thread's logical time.

beats
 Returns the appropriate beat time of the clock from any thread. If the receiver is the clock of the current thread, this returns the current logical time: thisThread.beats. If the receiver is not the current thread's clock then this translates the current thread's logical time in seconds to this clock's logical time in beats. 
 
schedAbs(beat,function)
 Schedule a function to be evaluated at a particular beat.

sched(delta,function)
 Schedule a function to be evaluated delta beats from the current logical time in this clock. If the receiver is the clock of the current thread, the delta is applied to the current logical time. If the receiver is not the current thread's clock then the delta is applied to the clock's elapsed time.

clear
 remove all tasks from the scheduling queue.

permanent_(bool)
 if false (default) the clock is stopped (and thus removed) on cmd-period. 
 If set to true it persists, just like TempoClock.default does.


beats2secs(beats)
 convert absolute beats to absolute seconds. Only works for times in the current tempo. If the tempo changes any computed time in future will be wrong.
 
secs2beats(seconds)
 convert absolute seconds to absolute beats. Only works for times in the current tempo. If the tempo changes any computed time in future will be wrong.


Example:

////////////////////////

t = TempoClock(1); // create a TempoClock

// schedule an event at next whole beat
t.schedAbs(t.beats.ceil, { arg beat, sec; [beat, sec].postln; 1 });

t.tempo = 2;
t.tempo = 4;
t.tempo = 0.5;
t.tempo = 1;

t.clear;

t.schedAbs(t.beats.ceil, { arg beat, sec; [beat, sec].postln; 1 });

t.stop;

////////////////////////

(
// get elapsed time, round up to next second
v = Main.elapsedTime.ceil;

// create two clocks in a 5:2 relation, starting at time v. 
t = TempoClock(1, 0, v);
u = TempoClock(0.4, 0, v);

// start two functions at beat zero in each clock.
t.schedAbs(0, { arg beat, sec; [\t, beat, sec].postln; 1 });
u.schedAbs(0, { arg beat, sec; [\u, beat, sec].postln; 1 });
)


(
u.tempo = u.tempo * 3;
t.tempo = t.tempo * 3;
)

(
u.tempo = u.tempo * 1/4;
t.tempo = t.tempo * 1/4;
)


(
t.stop;
u.stop;
)

////////////////////////

(
// get elapsed time, round up to next second
v = Main.elapsedTime.ceil;

// create two clocks, starting at time v. 
t = TempoClock(1, 0, v);
u = TempoClock(1, 0, v);

// start two functions at beat zero in each clock.
// t controls u's tempo. They should stay in sync.
t.schedAbs(0, { arg beat, sec; u.tempo = t.tempo * [1,2,3,4,5].choose; [\t, beat, sec].postln; 1 });
u.schedAbs(0, { arg beat, sec; [\u, beat, sec].postln; 1 });
)


(
u.tempo = u.tempo * 3;
t.tempo = t.tempo * 3;
)

(
u.tempo = u.tempo * 1/4;
t.tempo = t.tempo * 1/4;
)


(
t.stop;
u.stop;
)
