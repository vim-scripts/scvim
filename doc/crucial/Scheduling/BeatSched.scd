BeatSched

A beat capable function scheduler 

Functions can be scheduled for precise execution using relative seconds, relative beats, absolute seconds or absolute beats. This class uses TempoClock for scheduling, and has some overlap of capabilities with that.

The TempoClock class is used to specify what the tempo is, and is used for all beat <-> second calculations. The default global TempoClock object is used, or you can use a specific TempoClock instance.

There is a default global BeatSched that can be addressed through class methods. It uses the SystemClock and the default global TempoClock. You may also create individual instances that maintain their own scheduling queues, tempii, and time epochs.

If using BeatSched instances you can clear the queue, only affecting your own events. If using the global BeatSched class, clearing the queue will affect everybody. 

All of these methods exist as both 
 class (the default global scheduler) 
 BeatSched.tsched(seconds,function)
 and instance methods (a specific scheduler). 
 beatSched = BeatSched.new;
 beatSched.tsched(seconds,function)

The default clock used is the SystemClock, but you may also specify to use the AppClock.



tsched(seconds,function)
 time based scheduling
 delta specified in seconds
xtsched( seconds,function)
 exclusive time based schedule
 any previous messages scheduling using xtsched, xsched or xqsched will 
 be cancelled. this is incredibly useful in situations where several messages 
 might be sent and you only want the last one to be used as the final answer.
 example: a monkey is hitting many buttons, changing his mind about which 
 sound to play next. this would result in many messages being stacked up all 
 at the same time, and the server would choke trying to execute them all. 
 this is a kind of enforced monophony.
 another example: a sequence plays successive notes, all using xsched, 
 you then switch to a different sequence. you don't want the note that was 
 scheduled from the previous sequence to happen. using one of the x-methods, 
 you don't have to worry about it, the old notes will be cleared when new ones
 are scheduled.
 
sched(beats,function)
 delta specified in beats
xsched(beats,function)
 exclusive beat based scheduling
 
qsched(quantize,function)
 will happen at the next even division ( 4.0 means on the downbeat of a 4/4 bar ),
 or immediately if you happen to be exactly on a division.
xqsched(quantize,function)
 exclusive quantized beat based scheduling
 
tschedAbs(time,function)
 will happen at the time specified in seconds
schedAbs(beat,function)
 will happen at the beat specified.
 
xblock
 blocks any and all pending x-scheduled messages.
 
time
 get the scheduler's time
time_(seconds)
 set the scheduler's time 
beat
 get the scheduler's current beat
beat_(beat)
 set the scheduler's current beat.
 this is also used to start a "song": zero the beat, and all absolute times
 previously scheduled events will be unpredictable
deltaTillNext(quantizeDivision)
 returns the number of seconds untiil the next quantizeDivision.
 4.0 means the next even bar
 16.0 means the next 4 bar cycle
 0.25 means the next 16th note

 
clear
 clear all scheduled events. 
 
 
 
In the examples, remember to execute groups of code lines together.
 
b = BeatSched.new;
 
 b.qsched(4.0,{ "hello".postln; });
 
 b.qsched(4.0,{ "hello".postln; });


 b.time; // since the app started

 b.time = 0.0; // reset the time

 b.time;
 
 b.beat;

 TempoClock.default.tempo = 2;
 b.beat.postln;
 TempoClock.default.tempo = 1;
 b.beat.postln;


 b.time = 0.0;
 b.tschedAbs(4.0,{ "4 seconds absolute time".postln; });
 b.tschedAbs(2.0,{ "2 seconds absolute time".postln; });


 b.xsched(4.0, { "4 beats later".postln });
 // cancels previous xsched
 b.xsched(2.0, { "2 beats later".postln });

 
 
A little rounding error
(
TempoClock.default.tempo = 120 / 60.0;
d = Routine({
 20.do({
 var t;
 t = BeatSched.global.tdeltaTillNext(4.0);
 t.postln;
 t.wait;
 });
 });
 SystemClock.play(d);
)


at 5206.432346276 we ask for deltaTillNext 4
[ 5204, 4, 5206.432346276 ]
1.5676537239997

that would be
5206.432346276 + 1.5676537239997
// at 5208
5208


// but when the scheded event comes due:
[ 5204, 4, 5207.999072862 ]
0.00092713799949706

its appears to be slightly ahead of schedule, due
to rounding errors in the several math ops that have happened.

so the right answer is 0.00092713799949706
as far as BeatSched is concerned.

but if you try to loop like this, you will suffer from rounding errors.

mostly you would never set up a loop like this, mostly
you just want to know when the next even beat is so you can get your groove on.




Tempo.bpm_(120);
d = Routine({
 "wait for the downbeat...".postln; 
 OSCSched.global.tdeltaTillNext(4.0).wait;

 32.do({ arg i;
 [i,BeatSched.beat].postln; 
 Tempo.beats2secs(1.0).wait;
 });
 });
SystemClock.play(d);

 