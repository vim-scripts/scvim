UGen abstract superclass of all unit generators

superclass: AbstractFunction

Unit generators are the basic building blocks of synths on the server, and are used to generate or process audio or control signals. The many subclasses of UGen are the client-side representations of unit generators, and are used to specify their parameters when constructing synth definitions (see [SynthDef]). 

See also [UGens], [Tour_of_UGens], and [UGens-and-Synths].


Convenience Methods

scope(name, bufsize, zoom)

Displays the output of this UGen in an individual [Stethoscope] window. name is the name of the window.

Server.default = s = Server.internal.boot;
{ Ringz.ar(PinkNoise.ar([0.1, 0.2]).scope(\pink), 2000, 1, 0.25) }.play; // multichannel works
s.scope; // can still separately scope the output of the server

poll(interval, label)

Polls the output of this UGen every interval seconds, and posts the result. The default interval is 0.1 seconds.

{ SinOsc.ar(LFNoise0.ar(2).range(420, 460).poll(label: \LFNoise), 0, 0.2) }.play;

// Multichannel is supported
{ SinOsc.ar(SinOsc.ar([0.2, 0.3]).range(420, 460).poll(label: \SinOscs), 0, 0.2) }.play;

range(lo, hi)

Scales the output of this UGen to be within the range of lo and hi. N.B. 'range' expects the default output range, and thus should not be used in conjunction with mul and add arguments.

{ SinOsc.ar(SinOsc.ar(0.3).range(440, 660), 0, 0.5) * 0.1 }.play;

exprange(lo, hi)

Maps the output of this UGen exponentially to be within the range of lo and hi using a [LinExp] UGen. lo and hi should both be non-zero and have the same sign. N.B. 'exprange' expects the default output range, and thus should not be used in conjunction with mul and add arguments.

clip(lo, hi)

Wraps the receiver in a [Clip] UGen, clipping its output at lo and hi.

fold(lo, hi)

Wraps the receiver in a [Fold] UGen, folding its output at lo and hi.

wrap(lo, hi)

Wraps the receiver in a [Wrap] UGen, wrapping its output at lo and hi.

lag(lagTime)

Wraps the receiver in a [Lag] UGen, smoothing it's output by lagTime.

lag2(lagTime)

Wraps the receiver in a [Lag2] UGen, smoothing it's output by lagTime.

lag3(lagTime)

Wraps the receiver in a [Lag3] UGen, smoothing it's output by lagTime.

degreeToKey(scale, stepsPerOctave)

Wraps the receiver in a [DegreeToKey] UGen. The default stepsPerOctave is 12.

minNyquist

Wraps the receiver in a [min] UGen, such that the lesser of the receiver's output and the Nyquist frequency is output. This can be useful to prevent aliasing.

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
? ? ?? ?
Posts a list of the arguments for this UGen and their values.


Other Instance Methods

The following methods and instance variables are largely used in the construction of synth definitions, synth descriptions (see [SynthDesc]), UGen class definitions, etc., and are usually not needed for general use. Users should not attempt to set any of these values in general code.

synthDef

The SynthDef which contains the UGen.

inputs

The array of inputs to the UGen. 

rate

The output rate of the UGen which is one of the Symbols 'audio', or 'control'.

signalRange

Returns a symbol indicating the signal range of the receiver. Either?\bipolar or?\unipolar.

numChannels?

Returns the number of output Channels. For a UGen, this will always be 1, but [Array] also implements this method, so multichannel expansion is supported. See [MultiChannel].

numInputs

Returns the number of inputs for this UGen.

numOutputs

Returns the number of outputs for this UGen.

name

Returns the [Class] name of the receiver as a [String].

madd(mul, add)

Wraps the receiver in a MulAdd UGen. This is only used in UGen class definitions in order to allow efficient implementation of mul and add arguments.

isValidUGenInput

Returns true.
 
asUGenInput

Returns the receiver. 
?? ?
