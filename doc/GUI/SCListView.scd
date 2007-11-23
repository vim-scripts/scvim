
SCListView			a list view

Inherits from: Object : SCView: SCControlView



(

	w = SCWindow.new.front;

	v = SCListView(w,Rect(10,10,120,70))
		.items_([ "SinOsc", "Saw", "LFSaw", "WhiteNoise", "PinkNoise", "BrownNoise", "Osc" ])
		.background_(Color.clear)
		.hiliteColor_(Color.green(alpha:0.6))
		.action_({ arg sbs;
			[sbs.value, v.items[sbs.value]].postln;	// .value returns the integer
		});

)

You can set the value of the list view

v.value = 7.rand;

but if you want to set the value AND perform the actiion, you use valueAction:

v.valueAction = 7.rand;


