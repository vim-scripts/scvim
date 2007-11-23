
Spec			specification of an input datatype

This is an abstract class.  Specs specify what kind of input is required or permissible, and what the range of those parameters are.

common subclasses:
	AudioSpec
	ControlSpec
	ScalarSpec


Spec has subclasses which depict different kinds of possible inputs.
This is of interest to functions, to gui interface objects (sliders etc.) and others.

The class Spec itself holds a master Dictionary of common specifications.

*add(name, args)		add a spec to the global spec dictionary under the name
					the args is an object which is called .asSpec internally.
					
// example:

// create a spec from the parameters
ControlSpec.add(\helpLin, [0, 1, \lin, 0.011, 0.01]);
// use the existing \freq spec for \helpLin2
Spec.add(\helpLin2, \freq);
// existing spec:
Spec.add(\helpLin, ControlSpec(0.ampdb, 1.ampdb, \db, units: " dB"));


