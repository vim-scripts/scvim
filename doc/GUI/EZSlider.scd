
EZSlider				wrapper class for label, slider, number box

EZSlider(window, dimensions, label, controlSpec, action, initVal, initAction, labelWidth, numberWidth)

EZSlider is a wrapper class for managing a label, slider and number box.

	window - the SCWindow containing the views.
	dimensions - a Point giving the width and height of the combined views.
	label - a String
	controlSpec - the ControlSpec for the value.
	action - a function called when the value changes. The function is passed the EZSlider instance as its argument.
	initVal - the value to initialize the slider and number box with. If nil, then it uses the ControlSpec's default value.
	initAction - a Boolean indicating whether the action function should be called when setting the initial value. The default is false.
	labelWidth - number of pixels width for the label. default is 80.
	numberWidth - number of pixels width for the number box. default is 80.
	
The contained views can be accessed via the EZSlider instance variables:
	labelView, sliderView, numberView

Another useful instance variable is round, the rounding precision for the number box display. The default value for round is 0.001 .

Example:

(
var w, ez;

w = SCWindow("EZSlider", Rect(20, 400, 440, 180));
w.front;
w.view.decorator = FlowLayout(w.view.bounds);

ez = EZSlider(w, // window
				400 @ 24, // dimensions
				"Cutoff", // label
				ControlSpec(200, 5000, \exp), // control spec
				{|ez| ez.value.postln },// action
				1000 // initVal
				)
)


Another example

(
// start server
s = Server.internal;
Server.default = s;
s.boot;
)

(
// define a synth
SynthDef("window-test", { arg note = 36, fc = 1000, rq = 0.25, bal=0, amp=0.4, gate = 1;
		var x;
		x = Mix.fill(4, {
			LFSaw.ar((note + {0.1.rand2}.dup).midicps, 0, 0.02)
		});
		x = RLPF.ar(x, fc, rq).softclip;
		x = RLPF.ar(x, fc, rq, amp).softclip;
		x = Balance2.ar(x[0], x[1], bal);
		x = x * EnvGen.kr(Env.cutoff, gate, doneAction: 2);
		Out.ar(0, x);
	}, [0.1, 0.1, 0.1, 0.1, 0.1, 0]
).load(s);
)

(
var w, startButton, noteControl, cutoffControl, resonControl;
var balanceControl, ampControl;
var id, cmdPeriodFunc;

id = s.nextNodeID; // generate a note id.

// make the window
w = SCWindow("another control panel", Rect(20, 400, 440, 180));
w.front; // make window visible and front window.
w.view.decorator = FlowLayout(w.view.bounds);

w.view.background = HiliteGradient(Color.rand(0.0,1.0),Color.rand(0.0,1.0),
					[\h,\v].choose, 100, rrand(0.1,0.9));

// add a button to start and stop the sound.
startButton = SCButton(w, 75 @ 24);
startButton.states = [
	["Start", Color.black, Color.green],
	["Stop", Color.white, Color.red]
];
startButton.action = {|view|
		if (view.value == 1) {
			// start sound
			s.sendMsg("/s_new", "window-test", id, 0, 0,
				"note", noteControl.value,
				"fc", cutoffControl.value,
				"rq", resonControl.value,
				"bal", balanceControl.value,
				"amp", ampControl.value.dbamp);
		};
		if (view.value == 0) {
			// set gate to zero to cause envelope to release
			s.sendMsg("/n_set", id, "gate", 0);
		};
};

// create controls for all parameters
w.view.decorator.nextLine;
noteControl = EZSlider(w, 400 @ 24, "Note", ControlSpec(24, 60, \lin, 1),
	{|ez| s.sendMsg("/n_set", id, "note", ez.value); }, 36);
	
w.view.decorator.nextLine;
cutoffControl = EZSlider(w, 400 @ 24, "Cutoff", ControlSpec(200, 5000, \exp),
	{|ez| s.sendMsg("/n_set", id, "fc", ez.value); }, 1000);
	
w.view.decorator.nextLine;
resonControl = EZSlider(w, 400 @ 24, "Resonance", ControlSpec(0.1, 0.7),
	{|ez| s.sendMsg("/n_set", id, "rq", ez.value); }, 0.2);
	
w.view.decorator.nextLine;
balanceControl = EZSlider(w, 400 @ 24, "Balance", \bipolar,
	{|ez| s.sendMsg("/n_set", id, "bal", ez.value); }, 0);
	
w.view.decorator.nextLine;
ampControl = EZSlider(w, 400 @ 24, "Amp", \db,
	{|ez| s.sendMsg("/n_set", id, "amp", ez.value.dbamp); }, -6);
	

// set start button to zero upon a cmd-period
cmdPeriodFunc = { startButton.value = 0; };
CmdPeriod.add(cmdPeriodFunc);

// stop the sound when window closes and remove cmdPeriodFunc.
w.onClose = {
	s.sendMsg("/n_free", id);
	CmdPeriod.remove(cmdPeriodFunc);
};

)


