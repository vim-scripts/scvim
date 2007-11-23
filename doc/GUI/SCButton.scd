
SCButton				a multi-state button

Inherits from: Object : SCView: SCControlView


	*new(parent, bounds)	
		
	states_				[ label, text color, background color ]
	
	action_				specify a function to be called upon button-up
	

(

w = SCWindow.new;

b = SCButton(w, Rect(20,20,340,30))
		.states_([
			["there is suffering", Color.black, Color.red],
			["the origin of suffering", Color.white, Color.black],
			["the cessation of suffering", Color.red, Color.white],
			["there is a path to cessation of suffering", Color.blue, Color.clear]
		])
		.action_({ arg butt;
			butt.value.postln;	
		});
w.front;
)

Failure to set any states at all results in an invisible button.

// does not do action
b.value = 2;

// does action if it results in a change of value
b.valueAction = 3;

// clips to size of states
b.valueAction = -1;

// floats no problem
b.valueAction = 3.3;


In a musical context, a button-down press is more meaningful than a button-up (release) as it's more
intuitive to press a button on the beat. For that you can use SCView's mouseDownAction
(a superclass of SCButton)

(
w = SCWindow.new;
b = SCButton(w, Rect(20,20,80,26))
		.states_([["play", Color.black, Color.clear]])
		.mouseDownAction_({
			a = 	{EnvGen.ar(Env.adsr)*SinOsc.ar(440)}.play;	
		})
		.action_({ arg butt;
			a.free;
		});
w.front;
)



