SC2DSlider

superclass: SCSliderBase

(
var window;
var slider;

window = SCWindow("SC2DSlider", Rect(100,100, 140 ,140));
window.front;

 slider = SC2DSlider(window, Rect(20, 20,80, 80))
 .x_(0.5).y_(1);

)

<>x
<>y

drag and drop returns and accepts Points.
hold command key to initiate a drag.