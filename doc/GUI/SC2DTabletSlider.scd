SC2DTabletSlider

superclass: SC2DSlider

a 2D slider with support for extended wacom data

(
var window;
var slider;

window = SCWindow("SC2DSlider", Rect(100,100, 140 ,140));
window.front;

 slider = SC2DTabletSlider(window, Rect(20, 20,80, 80))
 .x_(0.5).y_(1);
 slider.mouseDownAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
 ["down",view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
 }; 
 slider.action = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
 [view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
 };
 slider.mouseUpAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
 ["up",view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
 };
 slider.setProperty(\clipInBounds,0)
)

<>x 0..1 value
<>y 0..1 value


action
mouseDownAction
mouseUpAction

all actions are passed the following wacom tablet values:
view - the view
x - 0..1 value
y - 0..1 value
 pressure - 0..1
 tiltX - 0..1 where available
 tiltY - 0..1 where available
 deviceID - will be used to look up if the tip or the eraser is used
 buttonNumber - 0 left, 1 right, 2 middle wheel click
 clickCount - double click, triple click ...
 most relevant for the mouseDown, but still valid for the dragged and mouseUp
absoluteZ - the wheel on the side of some mice
rotation - in degrees, only on the 4d mice 


Properties
clipInBounds- 0 or 1
 by default the x/y values are clipped to 0..1
 by setting this to 0, the values will exceed this as you drag from 
 inside the view to outside. This is useful in that you can have a small view 
 in which to start your movement and then go all over as long as you don't lift the pen.



drag and drop returns and accepts Points.
hold command key to initiate a drag.


(
SynthDef("help-SC2DTabletSlider",{ arg freq=440,int1=5,int2 = -5,
 ffreqInterval=0,rq=0.4,gate=0.0;
 var p,c,d,f;
 c=LFNoise1.kr(0.1,0.45,0.55);
 d=LFNoise1.kr(0.1,0.45,0.55);
 f=LFNoise1.kr(0.1,2);
 p=Pulse.ar([ freq * int1.midiratio + f , freq, freq * int2.midiratio - f],
 [c,d,c],0.2);
 Out.ar(0,
 RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
 * EnvGen.kr(Env.adsr, gate, gate)
 )
},[0.1,0.1,0.1,0.1,0.1,nil]).send(s);
)

(
 var w, v,freq,int,synth;
 synth = Synth("help-SC2DTabletSlider");
 w = SCWindow.new.front;

 freq = ControlSpec(100,3000,\exp);
 int = ControlSpec(-48,48,\linear,1);
 
 v = SCTabletView(w,Rect(10,10,200,200));
 v.background = Color.white;
 v.action = { arg view,x,y,pressure,tiltx,tilty;
 synth.set( 
 \int1, int.map(x),
 \int2, int.map(y),
 \ffreqInterval, int.map(pressure),
 \gate, pressure.postln
 );
 };
 
 v.mouseDownAction = { arg view,x,y,pressure;
 synth.set( 
 \freq , rrand(30,80).midicps,
 \gate, pressure.postln
 )
 };
 v.mouseUpAction = { arg view,x,y,pressure;
 synth.set( \gate, 0.postln )
 };
)
