
StreamSpec

superclass: HasItemSpec

StreamSpec( specOfItemsReturnedInTheStream)

	
a StreamSpec specifies an input that will be used in a stream or pattern.
The default control is an IrNumberControl, though usually you will be more
intereseted in using Patterns as inputs. 

The most common use is for InstrSpawner and InstrGateSpawner. An IrNumberControl
or a Pattern (any object that returns a rate of \stream) will result in the creation
of an .ir rate input to the synth function. Then on each spawning, the synth
is created and on that .ir rate input is passed in the next value of the stream.


StreamSpec( [ 0.01, 8.0,\exp ] )
	a stream of values between 0.01 and 8.0
	any control should use an exponential fader
StreamSpec( EnvSpec(Env.linen) )
	a stream of envelopes.
	the default envelope is an Env.linen, though
	the stream may return any kind of envelope.



