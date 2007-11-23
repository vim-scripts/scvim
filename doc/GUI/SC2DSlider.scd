
SC2DSlider		a two-dimensional gui slider

Inherits from: Object : SCView: SCControlView

	drag and drop returns and accepts Points.
	hold command key to initiate a drag.


Example

(
w = SCWindow("SC2DSlider", Rect(100,100, 140 ,140));
t = SC2DSlider(w, Rect(20, 20,80, 80))
		.x_(0.5)	// initial location of x
		.y_(1)	// initial location of y
		.action_({|sl|
			[\sliderX, sl.x, \sliderY, sl.y].postln;
		});
w.front;
)

t.x 			// get the x loc
t.x_(0.25) 	// set the x loc




