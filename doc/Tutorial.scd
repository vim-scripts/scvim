SuperCollider 3 Server Tutorial

To follow this tutorial you should read 

Server-Architecture
and
Server-Command-Reference

This tutorial also assumes that you are familiar with SuperCollider version 2 since the creating a SynthDef in SC3 is very similar to creating a Synth in SC2.

There are two parts to SuperCollider. One part is the language application and another is a synthesis server that can run either inside the language application, or as a separate program on the same machine, or run on a different computer across a network connection. The language application sends command messages to the server using a subset of the Open Sound Control protocol.

Booting a Server

In order to run sound we need to start a server running. The easiest way to start a server is to click on one of the "Start Server" buttons in the server windows. Sometimes though it is useful to start a server programmatically. To do this we need to get or create a server object and tell it to "boot". Two servers, internal and local, are predefined.

The internal server runs in the same process as the SuperCollider application. It is internal to the program itself.

// set the interpreter variable s to the internal server object.
s = Server.internal;

VERY IMPORTANT: This line must be executed for the variable 's' to be set. The mechanics are different depending on your platform. The MacOSX standard is to place the cursor anywhere on this line and press the "Enter" key on the numeric keypad. Pressing the main return key does not execute code! This allows you to write code fragments of multiple lines. To execute a multi-line block of code, select the block and press "Enter." For convenience, a code block can be enclosed in parentheses, and the entire block selected by double-clicking just inside either parenthesis. (For linux or Windows instructions, consult the documentation specific to that platform.)

The local server runs on the same machine as the SuperCollider application, but is a separate program, 'scsynth'. Note: By default the interpreter variable s is set to the local server at startup. For further information see the Server helpfile.

// set the interpreter variable s to the local server object.
s = Server.local;

To boot the server you send it the boot message.

s.boot;

To quit the server send it the quit message.

s.quit;

We can also create a server to run. To create a server object we need to provide the IP address or the server and a port number. Port numbers are somewhat arbitrary but they should not conflict with common protocols like telnet, ftp http, etc. The IP address 127.0.0.1 is defined to mean the local host. This is the IP address to use for running a server on your own machine.

// create a server object that will run on the local host using port #58009
s = Server(\myServer, NetAddr("127.0.0.1", 58009)); 

s.boot; //start the server

s.quit; // quit the server

It is not possible to boot a server on a remote machine, but if you have one running already or you know of one running, you can send messages to it. You create the server object using the IP address of the machine running the server and the port it is using.

// create a server object for talking to the server running on a machine having 
// IP address 192.168.0.47 using port #57110
s = Server(\myServer, NetAddr("192.168.0.47", 57110)); 

Making Sound

(note: This tutorial uses raw OSC commands as described in Server-Command-Reference, rather than the classes Synth and Group. See those helpfiles also for some simpler ways of working with Synths. This tutorial explains the basic underlying design of Synths and SynthDefs).

Now lets make some audio. 

s = Server.local; // assign it to interpreter variable 's' 

Boot it.

s.boot;

Create a SynthDef. A SynthDef is a description of a processing module that you want to run on the server. It can read audio from the server's audio buses, read control from the control buses and write control or audio back to buses. Here we will create a sine oscillator and send it to audio bus zero.

(
SynthDef("sine", { arg freq=800;
 var osc;
 osc = SinOsc.ar(freq, 0, 0.1); // 800 Hz sine oscillator
 Out.ar(0, osc); // send output to audio bus zero.
}).writeDefFile; // write the def to disk in the default directory synthdefs/
)

Send the SynthDef to the server. 

s.sendSynthDef("sine");

Start the sound. The /s_new command creates a new Synth which is an instance of the "sine" SynthDef. Each synth running on the server needs to have a unique ID. The simplest and safest way to do this is to get an ID from the server's NodeIDAllocator. This will automatically allow IDs to be reused, and will prevent conflicts both with your own nodes, and with nodes created automatically for purposes such as visual scoping and recording. Each synth needs to be installed in a Group. We install it in group one which is the default group. There is a group zero, called the RootNode, which contains the default group, but it is generally best not to use it as doing so can result in order of execution issues with automatically created nodes such as those mentioned above. (For more detail see the default_group, RootNode, and Order-of-execution helpfiles.)

s.sendMsg("/s_new", "sine", x = s.nextNodeID, 1, 1);

Stop the sound.

s.sendMsg("/n_free", x);

Stop the server.

s.quit;

SynthDef has two methods which send the def automatically, load which writes it to disk, and send which sends it without writing it to disk. The latter can be useful to avoid clutter on your drive.

(
SynthDef("sine", { arg freq=800;
 var osc;
 osc = SinOsc.ar(freq, 0, 0.1); // 800 Hz sine oscillator
 Out.ar(0, osc); // send output to audio bus zero.
}).load(s); // write to disk and send
)

(
SynthDef("sine", { arg freq=800;
 var osc;
 osc = SinOsc.ar(freq, 0, 0.1); // 800 Hz sine oscillator
 Out.ar(0, osc); // send output to audio bus zero.
}).send(s); // send without writing
)

Using Arguments

It is useful to be able to specify parameters of a synth when it is created. Here a frequency argument is added to the sine SynthDef so that we can create it 

s = Server.local; // assign it to interpreter variable 's' 

s.boot;

(
SynthDef("sine", { arg freq;
 var osc;
 osc = SinOsc.ar(freq, 0, 0.1); // 800 Hz sine oscillator
 Out.ar(0, osc); // send output to audio bus zero.
}).send(s);
)



Play a 900 Hz sine wave.

s.sendMsg("/s_new", "sine", x = s.nextNodeID, 1, 1, "freq", 900);

s.sendMsg("/n_free", x);


Play a 1000 Hz sine wave.

s.sendMsg("/s_new", "sine", y = s.nextNodeID, 1, 1, "freq", 1000);

s.sendMsg("/n_free", y);


Playing three voices at once

(
s.sendMsg("/s_new", "sine", x = s.nextNodeID, 1, 1, "freq", 800);
s.sendMsg("/s_new", "sine", y = s.nextNodeID, 1, 1, "freq", 1001);
s.sendMsg("/s_new", "sine", z = s.nextNodeID, 1, 1, "freq", 1202);
)

(
s.sendMsg("/n_free", x);
s.sendMsg("/n_free", y);
s.sendMsg("/n_free", z);
)

Playing three voices at once using bundles. Bundles allow you to send multiple messages with a time stamp. The messages in the bundle will be scheduled to be performed together. The time argument to sendBundle is an offset into the future from the current thread's logical time.

(
s.sendBundle(0.2, 
 ["/s_new", "sine", x = s.nextNodeID, 1, 1, "freq", 800],
 ["/s_new", "sine", y = s.nextNodeID, 1, 1, "freq", 1001],
 ["/s_new", "sine", z = s.nextNodeID, 1, 1, "freq", 1202]);
s.sendBundle(1.2, ["/n_free", x],["/n_free", y],["/n_free", z]);
)

Controlling a Synth

You can send messages to update the values of a Synth's arguments.

Play a 900 Hz sine wave.

s.sendMsg("/s_new", "sine", x = s.nextNodeID, 1, 1, "freq", 900);

Change the frequency using the /n_set command. You send the node ID, the parameter name and the value.

s.sendMsg("/n_set", x, "freq", 800);

s.sendMsg("/n_set", x, "freq", 700);

s.sendMsg("/n_free", x);

Adding an Effect Dynamically

You can dynamically add and remove an effect to process another synth. In order to do this, the effect has to be added after the node to be processed.

(
// define a noise pulse
SynthDef("tish", { arg freq = 1200, rate = 2;
 var osc, trg;
 trg = Decay2.ar(Impulse.ar(rate,0,0.3), 0.01, 0.3);
 osc = {WhiteNoise.ar(trg)}.dup;
 Out.ar(0, osc); // send output to audio bus zero.
}).send(s);
)

(
// define an echo effect
SynthDef("echo", { arg delay = 0.2, decay = 4;
 var in;
 in = In.ar(0,2);
 // use ReplaceOut to overwrite the previous contents of the bus.
 ReplaceOut.ar(0, CombN.ar(in, 0.5, delay, decay, 1, in));
}).send(s);
)

// start the pulse
s.sendMsg("/s_new", "tish", x = s.nextNodeID, 1, 1, \freq, 200, \rate, 1.2);

// add an effect
s.sendMsg("/s_new", "echo", y = s.nextNodeID, 1, 1);

// stop the effect
s.sendMsg("/n_free", y);

// add an effect (time has come today.. hey!)
s.sendMsg("/s_new", "echo", z = s.nextNodeID, 1, 1, \delay, 0.1, \decay, 4);

// stop the effect
s.sendMsg("/n_free", z);

// stop the pulse
s.sendMsg("/n_free", x);

This works because we added the effect after the other node. Sometimes you will need to use groups or /n_after to insure that an effect gets added after what it is supposed to process.


Chaining Effects

Using Control Buses

Mapping an Argument to a Control Bus

(
// define a control
SynthDef("line", { arg i_bus=10, i_start=1000, i_end=500, i_time=1;
 ReplaceOut.kr(i_bus, Line.kr(i_start, i_end, i_time, doneAction: 2));
}).send(s)
)

Play a 900 Hz sine wave.

s.sendMsg("/s_new", "sine", x = s.nextNodeID, 1, 1, "freq", 900);

Put a frequency value on the control bus.

s.sendMsg("/c_set", 10, x);

Map the node's freq argument to read from control bus #10.

s.sendMsg("/n_map", x, \freq, 10);

Change the value on the control bus.

s.sendMsg("/c_set", 10, 1200);

Start a control process that writes to bus #10. 
The EnvGen doneAction will free this node automatically when it finishes.

s.sendMsg("/s_new", "line", s.nextNodeID, 0, 1);

Free the node.

s.sendMsg("/n_free", x);


Gating Envelopes

Adding a GUI

Using Buffers

Filling Wavetables

Frequency Domain Processing

Sequencing with Routines

(
var space,offset,timer, saw, envsaw, sampler, delay;

SynthDef("saw",{ arg out=100, pan=0, trig=0.0, freq=500, amp=1, cutoff=10000, rezz=1;
 freq = Lag.kr(freq,0.1);
 Out.ar(out,Pan2.ar(RLPF.ar(Saw.ar([freq,freq*2],amp),cutoff,rezz),
 pan));
 }).load(s); 

SynthDef("envsaw",{ arg out=100, pan=0, dur=0.5, freq=500, amp=1, cutoff=10000, rezz=1;
 var env;
 env = EnvGen.kr(Env.perc(0.01, dur, 0.2), doneAction:0, gate:amp);
 Out.ar(out,Pan2.ar(RLPF.ar(Saw.ar(Lag.kr(freq,0.1),env),cutoff,rezz)*amp,
 pan));
 }).load(s); 

SynthDef("delay", { arg out=0, delay = 0.4, decay = 14;
 var in;
 in = In.ar(out,2);
 Out.ar(out, CombN.ar(in, 0.5, delay, decay, 1, in));
}).load(s);

SynthDef("sampler",{ arg sample, trig=1,rate=1.0,out=0,bufnum=0,pan=0,amp=1, dur=0.25;
 var env;
 env = EnvGen.kr(Env.perc(0.001, dur, 0.001), doneAction:2);
 Out.ar(out,
 Pan2.ar(
 PlayBuf.ar(1,bufnum,rate,InTrig.kr(trig),0,0)*amp,
 pan);
 )
}).load(s);

Tempo.bpm = 120;
timer=BeatSched.new;
offset = Tempo.tempo.reciprocal;

space = Buffer.read(s,"sounds/a11wlk01.wav");

saw=Synth("saw");
delay=Synth.after(saw,"delay", [\decay, 20]);

timer.sched(0,{
 var r;
 r=Routine({ var wait, freq, cutoff,rezz;
 wait = Pseq([2],inf).asStream;
 freq = Pseq([30,40,42,40],inf).asStream;
 cutoff = Pfunc({500.rand2+1000}).asStream;
 rezz = 0.5;
 inf.do({saw.set("freq", freq.next.midicps, "cutoff", cutoff.next, "rezz", rezz, "amp", 0.1, "out", 0);
 (wait.next*offset).wait});});
 timer.sched(0,r); 
});

timer.sched(0,{
 var r;
 r=Routine({ var wait, rate;
 wait = Pseq([0.25],inf).asStream;
 rate = Pfunc({0.5.rand}).asStream;
 inf.do({Synth.before(delay, "sampler", [\bufnum, space.bufnum, \trig, 1, \amp,0.1, \rate, rate.next, \dur, wait.next]); 
 (wait.next*offset).wait});});
 timer.sched(0,r); 
});

)


Sequencing with Patterns
(
//sappy emo electronica example... 
Tempo.bpm = 120;
SynthDef("patternefx_Ex", { arg out, in; 
 var audio, efx;
 audio = In.ar([20,21],2);
 efx=CombN.ar(audio, 0.5, [0.24,0.4], 2, 1); 
 Out.ar([0,1], audio+efx);
 }).load(s);

Synth.new("patternefx_Ex");

SynthDef("pattern_Ex", { arg out, freq = 1000, gate = 1, pan = 0, cut = 4000, rez = 0.8, amp = 1;
 Out.ar(out,
 Pan2.ar(
 RLPF.ar(
 Pulse.ar(freq,0.05),
 cut, rez),
 pan) * EnvGen.kr(Env.linen(0.01, 1, 0.3), gate, amp, doneAction:2);
 ) 
 }).load(s);

SynthDef("bass_Ex", { arg out, freq = 1000, gate = 1, pan = 0, cut = 4000, rez = 0.8, amp = 1;
 Out.ar(out,
 Pan2.ar(
 RLPF.ar(
 SinOsc.ar(freq,0.05),
 cut, rez),
 pan) * EnvGen.kr(Env.linen(0.01, 1, 0.3), gate, amp, doneAction:2);
 ) 
 }).load(s);

SynthDescLib.global.read;


Pseq([

Ptpar([
0,Pbind(\instrument,\pattern_Ex, \out, 20, \dur,Pseq([2],16), \root,[-24,-17], \degree,Pseq([0,3,5,7,9,11,5,1],2), \pan,1,\cut,Pxrand([1000,500,2000,300],16), \rez,Pfunc({0.7.rand +0.3}), \amp,0.12),

0.5,Pbind(\instrument,\pattern_Ex, \out, 20, \dur,Pseq([Pseq([2],15),1.5],1), \root,-12, \degree,Pseq([0,3,5,7,9,11,5,1],2), \pan,-1,\cut,2000, \rez,0.6, \amp,0.1);
]),

Ptpar([
0,Pbind(\instrument,\pattern_Ex, \out, 20, \dur,2, \root,[-24,-17], \degree,Pseq([0,3,5,7,9,11,5,1],inf), \pan,1,\cut,Pxrand([1000,500,2000,300],inf), \rez,Pfunc({0.7.rand +0.3}), \amp,0.12),

0,Pbind(\instrument,\bass_Ex, \dur,1, \root,-24, \degree,Pseq([0],inf), \pan,0, \cut,128, \rez,0.1, \amp,0.3),

0.5,Pbind(\instrument,\pattern_Ex, \out, 20, \dur,2, \root,-12, \degree,Pseq([0,3,5,7,9,11,5,1],inf), \pan,-1,\cut,2000, \rez,0.6, \amp,0.1);
]);


]).play;

)
