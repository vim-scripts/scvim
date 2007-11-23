
ObjectSpec : Spec

Allows any kind of object to be specified as a default for an Instr argument.

The object should be a kind of object that does not have an Editor in the Patch system... e.g., for Env, the spec should be an EnvSpec. The object will not be editable after patch creation.

Suitable objects for ObjectSpec are static Arrays, other data structures used to build parallel or serial structures, or even Functions that provide additional UGens to the Patch.

*new(obj)

obj is the object that will be used as the default when the Patch is built.

defaultControl
defaultControl_

Access or change the object.

Example:

In this patch, the Instr defines a filter structure, but leaves the choice of exciter up to the user. If the user doesn't provide an exciter, a default will be used.

Since the Formlet filter's impulse response is a sine wave, formHarmRatios and formHarmAmps accept arrays that create an additive array of Formlets. Formlet is a very efficient UGen, so the Patch is still CPU cheap!

The result resembles CHANT (IRCA/M, 1979).


(
// define the Instr
Instr([\analog, \voxlet], { |freq, gate, exciterFunc, detune, formfreq, ffreq, env, formfreqenv, attacktime, decaytime, vsens, fenvsens, formHarmRatios, formHarmAmps|
	var amp, sig;
	formfreq = formfreq * ((EnvGen.kr(formfreqenv, gate) * fenvsens) + 1);
	amp = (Latch.kr(gate, gate)-1) * vsens + 1;
	sig = exciterFunc.value(freq, detune);	// this func is user supplied
	sig = Formlet.ar(sig,
		formHarmRatios.notNil.if({ formfreq * formHarmRatios }, { formfreq }),
		attacktime, decaytime, mul: formHarmAmps ?? { 1 });
	// formlet is a bit volatile, so limit its amplitude
	(Limiter.ar(LPF.ar(Mix.ar(sig), ffreq), 0.9, 0.06)
		* EnvGen.kr(env, gate, doneAction:2)) ! 2
}, [
	\freq,
	\amp,
		// default func is an audio-rate impulse to provide the base frequency
		// override this with a func for a different exciter
		// your func may have a frequency and detune argument
		// it should output 1 channel only
	ObjectSpec({ |fr| Impulse.ar(fr) }),
	\mydetune,
	\freq,
	#[20, 20000, \exp, 0, 1200],
	EnvSpec(Env.adsr(0.07, 0.2, 0.8, 0.11)),
	EnvSpec(Env(#[0, 0], [1])),
	#[0.0001, 1, \exp, 0, 0.01],
	#[0.0001, 1, \exp, 0, 0.1],
	\amp,
	\amp,
	ObjectSpec(nil),	// arrays by default are nil -- ugenfunc fills in the true default here
	ObjectSpec(nil)
]);
)

// use the default exciter
p = Patch([\analog, \voxlet], [Patch({ MouseX.kr(20, 20000, 1, 0.1) }), 0.5, nil, nil, Patch({ MouseY.kr(20, 20000, 1, 0.1) }), nil, nil, nil, nil, nil, 1, 0]);
p.play;
// move the mouse to control base freq and formant freq
// watch the volume--amplitude can spike at times in this patch

// when done:
p.free;


// free the patch ("free" button) and try this to change the exciter
p = Patch([\analog, \voxlet], [Patch({ MouseX.kr(20, 20000, 1, 0.1) }), 0.25, { |fr, detune| Mix.ar(Saw.ar([fr, fr*detune])) }, nil, Patch({ MouseY.kr(20, 20000, 1, 0.1) }), nil, nil, nil, nil, nil, 1, 0]);
p.play;

p.free;

// now let's add some additiveness to the filters
p = Patch([\analog, \voxlet], [Patch({ MouseX.kr(20, 20000, 1, 0.1) }), 0.25, { |fr, detune| Mix.ar(Saw.ar([fr, fr*detune])) }, nil, Patch({ MouseY.kr(20, 20000, 1, 0.1) }), nil, nil, nil, nil, nil, 1, 0, (1..6), (1..6).reciprocal]);
p.play;

p.free;


