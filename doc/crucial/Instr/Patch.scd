Patch

A Patch connects an Instr function with input arguments to that function.

 Patch(instr,args)

(
Instr(\bubbles, { arg amp=1.0;
 var f, zout;
 f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps;
 zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4);
 zout * amp
});

p = Patch(\bubbles);

// default server will be booted, def written and loaded
p.play;

)



p.stop;

// command-. will also stop all sounds

p.play;

p.run(false);

p.run(true);

p.insp; //inspect it

p.gui;

// close the window

// open it again
p.gui;



 
(
Instr(\bubbles, { arg amp=1.0;
 var f, zout;
 f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps;
 zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4);
 zout * amp
});

Instr(\rlpf,{ arg audio=0,freq=500,rq=0.1;
 RLPF.ar(audio, freq, rq)
});

p = Patch(\rlpf,[
 q = Patch(\bubbles)
]);

p.gui

)



Instr can be specified as 

an Instr 
(
 i = Instr("help-Patch",{ arg freq=100,amp=1.0;
 SinOsc.ar([freq,freq + 30],0,amp)
 });
 p = Patch(i,[ 500, 0.3 ]);
 p.gui
)
a Function
(
 p = Patch({ arg freq=100,amp=1.0;
 SinOsc.ar([freq,freq + 30],0,amp)
 },[
 500,
 0.3
 ]);
 p.gui
)
or by the Instr name

// the Instr stores itself when created
(
 Instr(\bubbles, { arg amp=1.0;
 var f, zout;
 f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps;
 zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4);
 zout * amp
 });
 
 // the patch retrieves it
 p = Patch(\bubbles,[0.4] );
 p.gui
)


Patch can be easily saved to disk, and can make use of a large library of Instr functions. An Instr can produce many different possible SynthDefs, expanding the number of output channels or , varying in output rate or number of channels or internal structure.



Automatic Input Creation

For any nil arguments, a default control will be created. The spec returns this from the defaultControl method.

ControlSpec : KrNumberEditor
StaticSpec : NumberEditor (for quantities or max delay times etc.)
EnvSpec : EnvEditor
SampleSpec : Sample

see the implementations of defaultControl

This gives the impression that Patch is "an automatic gui for an Instr / SynthDef". If you do not supply arguments, it will make default ones, simple ones, but the real power of Patch is to supply functions with complex and varied inputs. Sitting there with 5 sliders on a 1 dimensional Instrument isn't really the height of synthesis.

Most simple synth inputs (ControlSpec) will end up being KrNumberEditors. Setting their values will control the playing synth.

 aPatch.set( index, value)



I recommend experimenting with factory methods to create your patches, supplying them with inputs useful for what you are working on.
If you use a certain physical controller or wacom :

buildPatch = { arg instrName;
 var i;
 i = Instr.at(instrName);
 
 Patch(instrName,[
 { i.specAt(0).map( JoyAxis.kr(0,1,axis:5) ) },
 { i.specAt(1).map( JoyAxis.kr(0,1,axis:5) ) },
 ])
};

buildPatch.value( \boingboing );


you can even keep your factories themselves in Instrument libraries:

Instr(\joysticker,[ arg instrName;
 
 var i;
 i = Instr.at(instrName);
 
 Patch(instrName,[
 ??{ i.specAt(0).map( JoyAxis.kr(0,1,axis:5) ) },
 ??{ i.specAt(1).map( JoyAxis.kr(0,1,axis:5) ) },
 ])
});


patch = Instr(\joysticker).value( \simple );

this Instr is not used for audio, its just used to build and return a Patch

You could choose different controllers for different common inputs,
you can query the argument name and the spec.
Keep files in databases, load other Patches or soundfiles from disk.
You could flip coins and choose from soundfiles, audio in, other saved 
patches or randomly chosen net radio feeds.



Patch inside Patch

(
// lets collect the cast...
Instr(\bubbles, { arg amp=1.0;
 var f, zout;
 f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps;
 zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4);
 zout * amp
});


// note that the same function will work as stereo or mono
// depending on what gets put into it
Instr(\rlpf,{ arg audio=0,freq=500,rq=0.1;
 RLPF.ar(audio, freq, rq)
});

// put bubbles into the filter
p = Patch(\rlpf,[
 q = Patch(\bubbles)
]);

)


// watch the ugen count in the default server window
// and also the error window results

p.play;



// stops the parent and the child q
p.stop;


// allocates new everything
p.play;

// additional play
// does not start an additional process
p.play;



// stop q, but the filter p is still reading from its old bus
q.stop;

// should still have 9 ugens playing

// sent the play message, q defaults to play out of the main outputs
// not through the filter p
q.play;

// stopping p now still stops q because it is still a child of p
p.stop;

// replaying the whole structures
p.play;

// note the AudioPatchOut and the inputs: PatchIn classes
p.insp;
q.insp;






Fixed Arguments

Floats and other scalar values including Envelopes, are transparently dealt with by Patch. These items are passed to the Instr function, but not to the SynthDef or the Synth. They are not modulateable.

(
// fixing arguments

Instr([\jmcExamples,'moto-rev'],{ arg lfo=0.2,freq=1000,rq=0.1;
 RLPF.ar(LFPulse.ar(SinOsc.kr(lfo, 0, 10, 21), [0,0.1], 0.1), freq, rq).clip2(0.4);
});

q = Patch([\jmcExamples,'moto-rev'],[
 0.2
]);

q.gui;

)

Busses
(

s.boot;

a = Group.new;

b = Group.after(a);

c = Bus.audio(s,1);

p=Patch({ arg in,ffreq;
 // the Bus is passed in as In.ar(bus.index,bus.numChannels)
 LPF.ar(in,ffreq)
},[
 c,
 KrNumberEditor(3000,[200,8000,\exp])
]).play(group: b);

// play something onto this bus in a group before that of the filter
y = Patch({ Saw.ar(400) * 0.1 }).play(group: a, bus: c );


z = Patch({ Saw.ar(500) * 0.1 }).play(group: a, bus: c );
z.stop;

y.stop;

)

// you can make the bus play to a main audio output
c.play

//command-. to stop all


(
s.boot;

a = Group.new;

b = Group.after(a);

// no index, not yet allocated
c = Bus(\audio,nil,2);

y = Patch({ arg in,ffreq;
 LPF.ar(in,ffreq)
},[
 c, // a proxy, the bus is yet to be allocated
 KrNumberEditor(3000,[200,8000,\exp])
]).play(group: b);

// now that the patch has played, the bus allocated itself
c.insp

// play onto this bus in a group before that of the filter
z = Patch({ Saw.ar([400,401]) * 0.1 }).play(group: a, bus: c )


Mapping values

you can use a spec to map a signal :

(
var spec;
spec = [ 100,18000,\exp].asSpec;
{

SinOsc.ar(
 spec.map( SinOsc.kr(0.1).range(0,1) )
)

}.play

)


you can use that as an input to a patch:

(
var spec;
spec = [ 100,18000,\exp].asSpec;

Patch({ arg freq;
 SinOsc.ar(freq)
},[
 spec.map( { SinOsc.kr(0.1).range(0,1) } )
]).play
)

or map another player's output and then use that as an input to a patch :

(
var spec;
spec = [ 100,18000,\exp].asSpec;

Patch({ arg freq;
 SinOsc.ar(freq)
},[
 spec.map( Patch({ SinOsc.kr(0.1).range(0,1) }) ).debug("i am a")
]).play

)

so spec.map is taking the player (which is a kind of function :
a potential piece of music once it is valued )
and creating a BinaryOpFunction out of it.
that is to say if you do math on functions you get another function.




Spawning

still wrong. a should be playing already and b should just patch it in each time.
(//
//
//a = Patch({
// SinOsc.ar(800,0.0)
//});
//
//c = Bus.audio;
//a.play(bus: c);
//
//b = Patch({ arg tone;
// var gate;
// gate = Trig1.kr(1.0,0.25);
// tone = In.ar(tone,1);
// tone * EnvGen.kr(Env([0,1,0],[0.05,0.05],\welch,1),gate,doneAction: 2)
//}[
// c.index
//]);
//
//b.prepareForPlay(s);
//
//
//Routine({
// 1.0.wait;
// 100.do({
// b.spawn(atTime: 0.1);
// 0.25.wait
// })
//}).play(SystemClock)
//
)


