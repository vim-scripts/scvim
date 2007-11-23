
SCRangeSlider			 double-ended gui slider

Inherits from: Object : SCView : SCControlView : SCSliderBase

Creation / Class Methods

	*new(parent, bounds)	
		
	action_				specify a function to be called upon slider movement

	step_				set the step size of the slider
		
	lo_					set the lower end value of the slider

	hi_					set the higher end value of the slider
	
	range_				set the initial range of the slider
	
	
	see also SCSlider, EZSlider

	
	modifier keys:
	
	command 	begin drag
	control		move whole range
	shift			move lo point
	alt			move hi point
	normal		set value
	


Examples

(
w = SCWindow.new.front;
a = SCRangeSlider(w, Rect(20, 80, 120, 30))
	.lo_(0.2)
	.range_(0.4)
	.action_({ |slider|
		[\sliderLOW, slider.lo, \sliderHI, slider.hi].postln;
	});
)

// ---------

(
w = SCWindow.new.front;
a = SCRangeSlider(w, Rect(20, 80, 120, 30))
	.lo_(0.2)
	.hi_(0.8)
	.action_({ |slider|
		b.activeLo_(slider.lo); // this will trigger the action of b (and set it's value)
		b.hi_(slider.hi);
	});
b = SCRangeSlider(w, Rect(220, 80, 20, 130))
	.lo_(0.2)
	.hi_(0.8)
	.knobColor_(HiliteGradient(Color.red, Color.white, Color.red))
	.action_({ |slider|
		[\sliderLOW, slider.lo, \sliderHI, slider.hi].postln;
	});

)


