
ControlPrototypes		automatically create inputs for Patches

This is a registery of controls, cataloged by the Spec of their output. It was used by Patch to procure suitable control objects to satisfy an argument to a function.

In other words: you give it a Spec, it gives you some suitable Player object to use as an input.


In this distribution, no special controls are registered for specific specs. You could use this
to customise your "auto input creation" in any number of ways.

In your Main-startUp method:

		ControlPrototypes.define(
				
			\trig -> {[
						StreamKrDur(Pseq(Array.fill(
					]},
//			\freq -> {[
//					ModalFreq(StreamKrDur(Pseq(Array.fill(16,{ rrand(0,11).round }),0.25)
//							.. etc...
//				]},
			EnvSpec -> {[
						EnvEditor.new(Env.adsr)
					]}
		);
		
*define( associations...)

Keys are either symbols or classes, the values are functions that return arrays of prototypes. Patch simply selects the first in the list. Other methods of ControlPrototypes use the full list.

The function is valued each time so that the control is a unique instance.

You may freely change or redefine control protypes while working/composing without recompiling.

This class also serves to decouple Spec from knowing of the various controls, gadgets and widgets.



