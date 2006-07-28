OSCSched 

A scheduler for sending OSC bundles to servers. 

The bundle is kept on the client until the last possible moment, and then actually sent to the server in a time stamped bundle, just before it is due to be executed.

Bundles can be scheduled for precise execution using relative seconds, relative beats, absolute seconds or absolute beats. Bundles can be scheduled on multiple servers, with exact simultaneous execution times.

Bundles can be easily cancelled up until the time they are sent to the server. They are sent to the server just before execution.

The Tempo class is used to specify what the tempo is, and is used for all beat <-> second calculations. A default global Tempo object is used, or you can create a specific Tempo instance if y'all got your own separate grooves.

There is a default global OSCSched that can be addressed through class methods. It uses the SystemClock and the default global Tempo. You may also create individual instances that maintain their own scheduling queues, tempii, and time epochs.

The default clock used is the SystemClock, but you may also specify to use the AppClock.

An optional clientSideFunction can also be supplied that will be evaluated on the client at the exact time as the OSC bundle is scheduled to happen. This could be used to show a change in the gui or to update some setting on a client side object.

All of these methods exist as both 
 class (the default global scheduler) 
 OSCSched.tsched(seconds,server,bundle,clientSideFunction)
 and instance methods (a specific scheduler). 
 oscSched = OSCSched.new;
 oscSched.tsched(seconds,server,bundle,clientSideFunction)



tsched(seconds,server,bundle,clientSideFunction)
 time based scheduling
 delta specified in seconds
xtsched( seconds,server,bundle,clientSideFunction)
 exclusive time based schedule
 any previous bundles scheduled using xtsched, xsched or xqsched will 
 be cancelled. this is incredibly useful in situations where several bundles 
 might be sent and you only want the last one to be used as the final answer.
 example: a monkey is hitting many buttons, changing his mind about which 
 sound to play next. this would result in many bundles being stacked up all 
 at the same time, and the server would choke trying to execute them all. 
 so this forces a kind of monophony of bundles.
 another example: a sequence plays successive notes, scheduling each one
 when it plays the previous one.
 you then switch to a different sequence. you don't want the note that was 
 scheduled from the previous sequence to happen. using one of the 
 x-methods, you don't have to worry about it, it will just be cancelled.
 
sched(beats,server,bundle,clientSideFunction)
 delta specified in beats
xsched(beats,server,bundle,clientSideFunction)
 exclusive beat based scheduling
 
qsched(quantize,server,bundle,clientSideFunction)
 will happen at the next even division ( 4.0 means on the downbeat of a 4/4 bar ),
 or immediately if you happen to be exactly on a division.
xqsched(quantize,server,bundle,clientSideFunction)
 exclusive quantized beat based scheduling
 
tschedAbs(time,server,bundle,clientSideFunction)
 will happen at the time specified in seconds
schedAbs(beat,server,bundle,clientSideFunction)
 will happen at the beat specified. this uses TempoClock for scheduling

xblock
 blocks any and all pending x-scheduled bundles.
 
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
 This value is only correct so long as you don't change the tempo.
 For scheduling, use the beat based scheduling methods.

 
clear
 clear all scheduled events. 
 
 
All of the x-methods establish a block such that a subsequent schedule using another x-method will cause the previous one to be cancelled. This is particularily useful when you are controlling something from a gui or process, and change your mind before the event you have triggered comes due. Another example is a pattern that returns delta beat values, repeatedly scheduling its next note at the time of playing the current one. To switch the pattern with another or abruptly start it over, simply do so: if you used xsched, then the previously scheduled event will be cancelled.
In most cases, you will wish to create a private instance of OSCSched when using this technique.


warning: older examples, not tested recently
 
load all of these for use in all following examples
s = Server.local;
s.boot;
(
SynthDef("bubbles", {
 var f, zout;
 f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps;
 zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4);
 Out.ar(0, zout);
}).send(s);

i = [ '/s_new', "bubbles", 1002, 1, 0 ];
o = [ '/n_free', 1002 ];

c = OSCSched.new;
)



// unitialised, the scheduler's time is number of seconds 
// since SC itself started up
c.time.postln;

// defaults to 1.0 beats per second
Tempo.tempo.postln;

// number of beats since SC itself started up
c.beat.postln;

// set the default global Tempo
Tempo.bpm = 96;

// how many of those beats since time started
c.beat.postln;

// tell the scheduler what beat we think it is
c.beat = 0.0;

// how beats since time started
c.beat.postln;


// start in 2.0 beats
c.sched(2.0,s,i,{
 "starting".postln;
});


// free the synth on the next even bar
c.qsched(4.0,s,o,{
 c.beat.postln; // note the floating point imprecision
});


// start in 4.0 seconds
c.tsched(4.0,s,i,{
 "starting".postln;
});


Absolute Beat / Time scheduling

c.clear;


(
c.beat = 32.0; // we are starting at beat 32
c.schedAbs(36.0,s,i); // in
c.schedAbs(39.0,s,o); // out
c.schedAbs(41.0,s,o); // out
c.schedAbs(40.0,s,i); // but first in
c.schedAbs(43.0,s,i,{
 c.schedAbs(42.0,s,o,{
 "this will never happen, its in the past".postln;
 });
 c.schedAbs(46.0,s,o);
});
)



Exclusive 

(
c.xsched(4.0,s,i,{
 "4.0".postln; 
});
c.sched(8.0,s,o); // not affected
// changed my mind...
c.xsched(3.0,s,i,{ // the x-methods are exclusive
 "3.0".postln; 
});
)



