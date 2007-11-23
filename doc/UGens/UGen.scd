
UGen			abstract superclass of all unit generators

Inherits from: Object : AbstractFunction

Unit generators are the basic building blocks of synths on the server, and are used to generate or process audio or control signals. The many subclasses of UGen are the client-side representations of unit generators, and are used to specify their parameters when constructing synth definitions (see SynthDef).

See also: UGens, Tour_of_UGens, and UGens-and-Synths.

Documentation of mul and add arguments

A great number of UGens take arguments for mul and add in their *ar and *kr methods. These simply refer to a constant or signal by which to multiply the output of the UGen, and a constant or signal to add to the output of the UGen. (mul happens before add.) They thus correspond in many cases to scaling the amplitude of the UGen in the case of mul, and adding a constant or DC offset in the case of add. In most cases the defaults for mul and add are 1 and 0 respectively, and they are commonly implemented using a automatically generated MulAdd UGen for efficiency. See also the range and madd methods below.

N.B. Because these arguments are so ubiquitous, they are not general documented in the individual help files.


Convenience Methods

scope(name, bufsize, zoom)

Displays the output of this UGen in an individual Stethoscope window. name is the name of the window.

Server.default = s = Server.internal.boot; // scope works only for internal server

{ Ringz.ar(PinkNoise.ar([0.1, 0.2]).scope(\pink), 2000, 1, 0.25) }.play; // multichannel works
s.scope; // can still separately scope the output of the server

Server.default = s = Server.local.boot; // switch back to local server.

poll(trig, label, trigid)

Polls the output of this UGen every interval seconds, and posts the result. The default trig is 10, which converts to 10 triggers per second (or every 0.1 seconds). See Poll for more info on polling.

{ SinOsc.ar(LFNoise0.ar(2).range(420, 460).poll(label: \LFNoise), 0, 0.2) }.play;

// Multichannel polling is supported
(
{
	var freqs = SinOsc.ar([0.2, 0.3]).range(420, 460);
	freqs.poll(label: [\freq1, \freq2]);
	SinOsc.ar(freqs, 0, 0.2);
}.play;
)

range(lo, hi)

Scales the output of this UGen to be within the range of lo and hi. N.B. 'range' expects the default output range, and thus should not be used in conjunction with mul and add arguments.

{ SinOsc.ar(SinOsc.ar(0.3).range(440, 660), 0, 0.5) * 0.1 }.play;

exprange(lo, hi)

Maps the output of this UGen exponentially to be within the range of lo and hi using a LinExp UGen. lo and hi should both be non-zero and have the same sign. N.B. 'exprange' expects the default output range, and thus should not be used in conjunction with mul and add arguments.

clip(lo, hi)

Wraps the receiver in a Clip UGen, clipping its output at lo and hi.

fold(lo, hi)

Wraps the receiver in a Fold UGen, folding its output at lo and hi.

wrap(lo, hi)

Wraps the receiver in a Wrap UGen, wrapping its output at lo and hi.

lag(lagTime)

Wraps the receiver in a Lag UGen, smoothing it's output by lagTime.

lag2(lagTime)

Wraps the receiver in a Lag2 UGen, smoothing it's output by lagTime.

lag3(lagTime)

Wraps the receiver in a Lag3 UGen, smoothing it's output by lagTime.

degreeToKey(scale, stepsPerOctave)

Wraps the receiver in a DegreeToKey UGen. The default stepsPerOctave is 12.

minNyquist

Wraps the receiver in a min UGen, such that the lesser of the receiver's output and the Nyquist frequency is output. This can be useful to prevent aliasing.

linlin(inMin, inMax, outMin, outMax, clip)

Wraps the receiver so that a linear inputrange is mapped to a linear output range.
The clip argument can be one of the four:
nil (do not clip at outMin or outMax),
\minmax (clip at outMin or outMax),
\min (clip at outMin),
\max (clip at outMax)

linexp(inMin, inMax, outMin, outMax, clip)

Wraps the receiver so that a linear inputrange is mapped to an exponential output range.
outMin and outMax must be nonzero and of the same sign. For clip argument, see linlin.

explin(inMin, inMax, outMin, outMax, clip)

Wraps the receiver so that an exponential inputrange is mapped to a linear output range.
inMin and inMax must be nonzero and of the same sign. For clip argument, see linlin.

expexp(inMin, inMax, outMin, outMax, clip)

Wraps the receiver so that an exponential inputrange is mapped to an exponential output range.
outMin, outMax, inMin and inMax must be nonzero and of the same sign. For clip argument, see linlin.

prune(min, max, clip)

Limits the receiver range to one of the four clip modes (see linlin)

checkBadValues(id, post)

Wraps the receiver in a CheckBadValues UGen with the corresponding id and post flag.

if(trueUGen, falseUGen)

Outputs trueUGen when the receiver outputs 1, falseUGen when the receiver outputs 0. If the receiver outputs a value between 0 and 1, a mixture of both will be played. (This is implemented as: ^(this * (trueUGen - falseUGen)) + falseUGen) Note that both trueUGen and falseUGen will be calculated regardless of whether they are output, so this may not be the most efficient approach.

// note different syntax in these two examples
{ if( LFNoise1.kr(1.0, 0.5, 0.5) , SinOsc.ar, Saw.ar ) * 0.1 }.play;

{ Trig1.ar(Dust.ar(3), 0.2).lag(0.1).if(FSinOsc.ar(440), FSinOsc.ar(880)) * 0.1 }.play;

@ y

Dynamic geometry support. Returns Point(this, y).

asComplex

Complex math support. Returns Complex(this, 0.0).

dumpArgs
   
Posts a list of the arguments for this UGen and their values.


Other Instance Methods

The following methods and instance variables are largely used in the construction of synth definitions, synth descriptions (see SynthDesc), UGen class definitions, etc., and are usually not needed for general use. Users should not attempt to set any of these values in general code.

synthDef

The SynthDef which contains the UGen.

inputs

The array of inputs to the UGen.

rate

The output rate of the UGen which is one of the Symbols 'audio', or 'control'.

signalRange

Returns a symbol indicating the signal range of the receiver. Either\bipolar or\unipolar.

numChannels

Returns the number of output Channels. For a UGen, this will always be 1, but Array also implements this method, so multichannel expansion is supported. See MultiChannel.

numInputs

Returns the number of inputs for this UGen.

numOutputs

Returns the number of outputs for this UGen.

name

Returns the Class name of the receiver as a String.

madd(mul, add)

Wraps the receiver in a MulAdd UGen. This is for the most part only used in UGen class definitions in order to allow efficient implementation of mul and add arguments.

isValidUGenInput

Returns true.
	
asUGenInput

Returns the receiver. This method is implemented in a number of classes in order to allow objects like Nodes, Busses, and Buffers to be passed directly as UGen inputs and Synth args.	

copy

Returns the receiver. Thus UGen-dup effectively returns a reference to the original and is a convenient way to copy a mono signal to multiple channels.

{ SinOsc.ar(Rand(200, 4000), 0, 0.2).dup }.plot // this is the same UGen
 
Function-dup evaluates that function multiple times, thus potentially returning distinct UGens.

{ {SinOsc.ar(Rand(200, 4000), 0, 0.2)}.dup }.plot // these are different UGens


