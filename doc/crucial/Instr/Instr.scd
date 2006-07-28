Instr - Instrument

An Instrument is a named sound function that is stored in the Library.

Storing:
 
Instr(\sin, { arg freq,amp;
 SinOsc.ar(freq,0.0, amp)
 });

Retreiving:

 Instr.at(\sin)

 or:

 Instr(\sin)


If the Instr is not found in the Library it will search in the Instr directory and load it from a file.

By default the directory Instr.dir is "build/Instr" or you may set Instr.dir in your startup.

 Instr.dir = "~/Documents/SuperCollider/Instr";

Specify by dot notation to look for a file named 'oscillators' :

 Instr( "oscillators.sin")
 Instr( "folder.subfolder.oscillators.sin")

It will look for the files oscillators.rtf, oscillators.txt, oscillators.sc or oscillators

it expects to find in one of those files an Instr named "oscillators.sin"

The older form array notation also works:

 Instr([\oscillators,\sin])


Instr(name,function,inputSpecs.outputSpec);

name - \sin
 "oscillators.sin"
 in file oscillators
 "folder.subfolder.oscillators.sin"
 in folder/subfolder/oscillators
 [\oscillators, \sin]
 
function - the Instr's ugenFunc
 
 When using your Instrument with Patch THERE IS NO NEED TO USE Out.ar
 though you may explicitly use it if you wish.
 It will be appended to your ugen graph func if needed.

inputSpecs
 Specify what kind of input is required, and the working range of values.
 somewhat optional - these can be guessed from the argnames.

 see [Spec] and [ControlSpec]

 if no spec is supplied, Instr will use the function's argument name to
 lookup a spec in Spec.specs. eg arg freq -> looks for Spec.specs.at(\freq)
 If nothing is found there, it will default to a ControlSpec with a range of 0 .. 1

 These specs are used by Patch to determine the suitable type of input.
 They may be used in many other situations, and you will find many uses
 where you will wish to query the specs.

 The default/initial value for the Spec is taken from the functiondefaults.
 

 different lazy ways to specify the spec...
 
(
 Instr("minimoog.one",{ arg freq=440,int1=5,int2 = -5,
 width1=0.1,width2=0.1,width3=0.1,
 ffreqInterval=0,rq=0.4;
 var p;
 p=Pulse.ar([ freq * int1.midiratio, freq, freq * int2.midiratio],
 [ width1,width2,width3],0.3);
 RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
 },#[ 
 nil, // nil, so use function's arg name (\freq) 
 // to look up in Spec.specs
 [-48,48,\linear,1], // as(Spec,[-48,48,\linear,1]) 
 // => ControlSpec.new(-48,48,\linear,1)
 [-48,48,\linear,1],
 \unipolar, // try Spec.specs.at(\unipolar)
 nil, // try the argname width2, that fails,
 // so the default is ControlSpec(0,1,\linear)
 \unipolar,
 [-48,48,\linear,1]
 ]);
)

outSpec
 optional - InstrSynthDef can determine the outputSpec by evaluating the ugenGraph
 and finding what the spec of the result is.
 An Instr can be .ar, .kr or can even return an object, a player, or a pattern.


Playing


(
Instr.new("minimoog.two",{ arg freq=440,int1=5,int2 = -5,
 width1=0.1,width2=0.1,width3=0.1,
 ffreqInterval=0,rq=0.4;
 var p;
 
 p=Pulse.ar([ freq * int1.midiratio, freq, freq * int2.midiratio],
 [ width1,width2,width3],0.3);
 
 RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
 
},#[ // specs
 \freq,
 [-48,48,\linear,1],
 [-48,48,\linear,1],
 \unipolar,
 \unipolar,
 \unipolar,
 [-48,48,\linear,1]
]);

)

(
 Instr.at("minimoog.two").play
)

(
 {
 "minimoog.two".ar( LFNoise1.kr(0.1,300,700) )
 }.play
)

(
 {
 Instr.at("minimoog.two")
 .ar( LFNoise1.kr(0.1,300,700) );
 }.play
)

(
 {
 Instr.ar(
 "minimoog.two",
 [ LFNoise1.kr(0.1,300,700) ]
 ); 
 }.play
)


but by far the best way is to use Patch :

Patch("minimoog.two",[1000]).play

Patch("minimoog.two").gui


Patterns

(
 Instr([\minimoog,\two],{ arg freq=440,int1=5,int2 = -5,width1=0.1,width2=0.1,width3=0.1,
 ffreqInterval=0,rq=0.4;
 var p;
 
 p=Pulse.ar([ freq * int1.midiratio, freq, freq * int2.midiratio],
 [ width1,width2,width3],0.3);
 
 RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
 * EnvGen.kr(Env.perc,doneAction: 2)
 
 });

 p = Patch([\minimoog,\two]); // no args, Patch automagically creates KrNumberEditors

SynthDescLib.global.read;
 d = p.asSynthDef.store;

 Pbind(
 \instrument, d.name,
 // note is converted to freq by things in NotePlayer
 \note,Prand([10,20,30],inf),
 // args are passed into the function
 \int1, Prand([-3,0,7,11,13],inf)
 ).play
)

see also InstrGateSpawner and InstrSpawner


An Instr is not a SynthDef

An Instr creates an InstrSynthDef (a subclass of SynthDef)

Each argument in the function for a SynthDef creates a Control input to the Synth that will eventually play on the server. 

An Instr can also include extra arguments that will be used in building the synth def, but will not be Control inputs in the final synth.

For instance an Integer may be passed in:

// caution: mind the feedback. AudioIn
(
Instr(\qAllpassA,{ arg audio,decay=1,maxDelay=0.3,quantity=4,chanDiff=0.1;

 (quantity.asInteger).do({
 var x; 
 audio = 
 AllpassL.ar(audio, maxDelay, 
 [rrand(0.01,maxDelay),rrand(0.01,maxDelay)],
 decay)
 });
 audio
});

Patch(\qAllpassA,[
 { AudioIn.ar([1,2]) },
 1,
 0.3,
 8
]).play

)

The first input to the synth is a stereo audio rate input, the others were fixed floats that did not require synth inputs.

Envelopes, fixed floats, fixed integers, Samples etc. can be passed into Instr functions.

When Patch is used to specify the inputs to the function some of these inputs will be reduced to fixed values (integers, floats, Envelopes etc.), and the resulting SynthDef will contain those inputs hard-coded. Using different Patches, it is possible to write many SynthDefs from the same Instr.

 Instr(\rlpf,{ arg input,ffreq=400,rq=0.1;
 RLPF.ar( input, ffreq, rq )
 });

 If the input supplied is stereo, the synthDef produced will be stereo. 
(
 Patch(\rlpf,[
 Patch({ Saw.ar([400,440],0.1) }) // in stereo
 ]).play
)
 
It is possible to play another Instr inside of your Instr:

(
 Instr(\sawfilter,{ arg freq,ffreq,rq;
 Instr.ar(\rlpf, [ Saw.ar(freq,0.1) , ffreq, rq ])
 })
)
 
and thus get further reuse out of your library of functions. Here the \rlpf that is used inside doesn't produce a synth def, but is used as a simple function in the ugenGraph of the \sawfilter Instr which does make a synthDef.

It is not generally possible to use the .ar method on a player inside of an Instrument function. This was possible in sc2. You cannot use a sound file player in this way:

 sfp = SFP("path/to/soundfile");
 Instr('no-can-do',{ arg sfp,amp=1.0;
 sfp.ar * amp
 });

Because an SFP (soundfile player) will require a buffer, a bus, and various stages of preparation. It is a complex process that cannot be compiled into a SynthDef.

the better approach is :

 Instr("can-do",{ arg input,amp=1.0;
 input * amp
 });
 
 Patch("can-do",[
 SFP("path/to/soundfile")
 ])



.gui

The gui for Instr is a simple display of the arguments and specs.


 // default gui display for Instr
 Instr.at("minimoog.one").gui



see [Patch] [InstrGateSpawner]


 
 
