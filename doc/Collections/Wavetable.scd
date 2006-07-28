Wavetable

Superclass: FloatArray

A Wavetable is a FloatArray in a special format used by SuperCollider's interpolating
oscillators. Wavetables cannot be created by new.

Creation

*sineFill(size, amplitudes, phases)

Fill a Wavetable of the given size with a sum of sines at the given amplitudes and phases.
The Wavetable will be normalized.
size - must be a power of 2.
amplitudes - an Array of amplitudes for each harmonic beginning with the fundamental.
phases - an Array of phases in radians for each harmonic beginning with the fundamental.

Wavetable.sineFill(512, 1.0/[1,2,3,4,5,6]).plot;


*chebyFill(size, amplitudes, phases)

Fill a Wavetable of the given size with a sum of Chebyshev polynomials at the given amplitudes
for use in waveshaping by the Shaper ugen.
The Wavetable will be normalized.
size - must be a power of 2.
amplitudes - an Array of amplitudes for each Chebyshev polynomial beginning with order 1.

Wavetable.chebyFill(512, [1]).plot;

Wavetable.chebyFill(512, [0, 1]).plot;

Wavetable.chebyFill(512, [0, 0, 1]).plot;

Wavetable.chebyFill(512, [0.3, -0.8, 1.1]).plot;

Instance Methods

plot(name, bounds)

Plot the Wavetable in a window. The arguments are not required and if not given defaults will be used.
name - a String, the name of the window.
bounds - a Rect giving the bounds of the window.

Wavetable.sineFill(512, [1]).plot;

Wavetable.sineFill(512, [1]).plot("Table 1", Rect.newBy(50, 50, 150, 450));


play(name)

Plays the Wavetable in a Mixer channel.
name - a Symbol or String giving the name of the mixer channel.

Wavetable.sineFill(512, [1]).play;

Wavetable.sineFill(512, [1]).play("Table 1");


asSignal

Convert the Wavetable into a Signal.

Wavetable.sineFill(512, [1]).asSignal.plot;

