
SCSlider			 gui slider

Inherits from: Object : SCView : SCControlView : SCSliderBase


	*new(parent, bounds)	
		
	action_				specify a function to be called upon slider movement

	step_				set the step size of the slider
		
	value_				set the value of the slider
	
	thumbsize_			set the width of the slider knob
	
	
	see also EZSlider, SCRangeSlider



Examples

// map a Spec to the value of the slider, post in a SCNumberBox

(
w = SCWindow.new.front;
b = [10, 80].asSpec;
c = SCNumberBox(w, Rect(20, 20, 60, 40));
a = SCSlider(w, Rect(20, 80, 100, 40))
	.action_({
		c.value_(b.map(a.value).round(0.01))
// round the float so it will fit in the SCNumberBox
		});
)



// change the stepsize of the slider, selected via a SCPopUpMenu
(
w = SCWindow.new.front;
a = ["0", "0.0625", "0.125", "0.25", "0.5", "1"];
b = SCSlider(w, Rect(20, 80, 100, 20))
	.action_({
		b.value.postln;
	});
c = SCPopUpMenu(w, Rect(20, 40, 100, 20))
	.items_(a)
	.action_({
		b.step_((a.at(c.value)).asFloat);
		});
)


// change the background color of SCWIndow by moving the sliders
(
w = SCWindow("RGB fader", Rect(100, 500, 400, 400))
	.front;
f = { w.view.background_(Color.new(r.value, g.value, b.value, 1)) };
r = SCSlider(w, Rect(150, 140, 100, 20))
	.value_(0.5)
	.action_({ f.value });
g = SCSlider(w, Rect(150, 170, 100, 20))
	.value_(0.5)
	.action_({ f.value });
b = SCSlider(w, Rect(150, 200, 100, 20))
	.value_(0.5)
	.action_({ f.value });
f.value;
);


