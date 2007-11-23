
Function

superclass: AbstractFunction


A Function is a reference to a [FunctionDef] and its defining context [Frame]. When a FunctionDef is encountered in your code it is pushed on the stack as a Function. A Function can be evaluated by using the 'value' method. See the [Functions] help file for a basic introduction.

Because it inherits from [AbstractFunction], Functions can respond to math operations by creating a new Function. For example:

(
var a, b, c;
a = { [100, 200, 300].choose };	// a Function
b = { 10.rand + 1 };	// another Function
c = a + b; 	// c is a Function.
c.value.postln;	// evaluate c and print the result
)

See [AbstractFunction] for function composition examples.



Accessing


def

Get the FunctionDef definition of the Function.



Evaluation

value(...args)

Evaluates the FunctionDef referred to by the Function. The Function is passed the args given.

{ arg a, b; (a * b).postln }.value(3, 10);

valueArray(..args..)

Evaluates the FunctionDef referred to by the Function. If the last argument is an Array or List, then it is unpacked and appended to the other arguments (if any) to the Function. If the last argument is not an Array or List then this is the same as the 'value' method.

{ arg a, b, c; ((a * b) + c).postln }.valueArray([3, 10, 7]);

{ arg a, b, c, d; [a, b, c, d].postln }.valueArray([1, 2, 3]);

{ arg a, b, c, d; [a, b, c, d].postln }.valueArray(9, [1, 2, 3]);

{ arg a, b, c, d; [a, b, c, d].postln }.valueArray(9, 10, [1, 2, 3]);

valueEnvir(...args)

As value above. Unsupplied argument names are looked up in the current Environment.

(
Environment.use({
~a = 3;
~b = 10;
{ arg a, b; (a * b).postln }.valueEnvir;
});
)


valueArrayEnvir(..args..)

Evaluates the FunctionDef referred to by the Function. If the last argument is an Array or List, then it is unpacked and appended to the other arguments (if any) to the Function. If the last argument is not an Array or List then this is the same as the 'value' method. Unsupplied argument names are looked up in the current Environment.


loop

Repeat this function. Useful with Task and Clocks.

t = Task({ { "I'm loopy".postln; 1.wait;}.loop });
t.start;
t.stop;


defer(delta)

Delay the evaluation of this Function by delta in seconds. Uses AppClock.

{ "2 seconds have passed.".postln; }.defer(2);


dup(n)

Return an Array consisting of the results of n evaluations of this Function.

x = { 4.rand; }.dup(4);
x.postln;


! n

equivalent to dup(n)

x = { 4.rand } ! 4;
x.postln;


sum(n)

return the sum of n values produced.

{ 4.rand }.sum(8);


bench(print)

Returns the amount of time this function takes to evaluate. print is a boolean indicating whether the result is posted. The default is true.

{ 1000000.do({ 1.0.rand }); }.bench;


fork(clock, quant, stackSize)

Returns a Routine using the receiver as it's function, and plays it in a TempoClock.

{ 4.do({ "Threadin...".postln; 1.wait;}) }.fork;


block

Break from a loop. Calls the receiver with an argument which is a function that returns from the method block. To exit the loop, call .value on the function passed in. You can pass a value to this function and that value will be returned from the block method.

block {|break|
	100.do {|i|
		i.postln;
		if (i == 7) { break.value(999) }
	};
}

thunk

Return a Thunk, which is an unevaluated value that can be used in calculations

x = thunk { 4.rand };
x.value;
x.value;


flop

Return a function that, when evaluated with nested arguments, does multichannel expansion by evaluting the receiver function for each channel.

f = { |a, b| if(a > 0) { a + b } { -inf } }.flop;
f.value([-1, 2, 1, -3.0], [10, 1000]);
f.value(2, 3);



flopEnvir

like flop, but implements an environment argument passing (valueEnvir).
Less efficient in generation than flop, but not a big difference in evaluation.

f = { |a| if(a > 0) { a + 1 } { -inf } }.envirFlop;
e = (a: [20, 40]);
e.use { f.value }


case(cases)

Function implements a case method which allows for conditional evaluation with multiple cases. Since the receiver represents the first case this can be simply written as pairs of test functions and corresponding functions to be evaluated if true. Unlike Object-switch, this is inlined and is therefore just as efficient as nested if statements.

(
var i, x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
i = z.choose;
x = case
	{ i == 1 }  { \no }
	{ i == 1.1 } { \wrong }
	{ i == 1.3 } { \wrong }
	{ i == 1.5 } { \wrong }
	{ i == 2 }  { \wrong }
	{ i == 0 }  { \true };
x.postln;
)


Exception Handling


For the following two methods a return ^ inside of the receiver itself cannot be caught. Returns in methods called by the receiver are OK.


try(handler)

Executes the receiver. If an exception is thrown the catch function handler is executed with the error as an argument. handler itself can rethrow the error if desired.

protect(handler)

Executes the receiver. The cleanup function handler is executed with an error as an argument, or nil if there was no error. The error continues to be in effect.

Examples:

// no exception handler
value { 8.zorg; \didnt_continue.postln; }

try { 8.zorg } {|error| error.postln; \cleanup.postln; }; \continued.postln;

protect { 8.zorg } {|error| error.postln; }; \didnt_continue.postln;

try { 123.postln; 456.throw; 789.postln } {|error| [\catch, error].postln };

try { 123.postln; 789.postln } {|error| [\catch, error].postln };

try { 123.postln; nil.throw; 789.postln } {|error| [\catch, error].postln };


protect { 123.postln; 456.throw; 789.postln } {|error| [\onExit, error].postln };

protect { 123.postln; 789.postln } {|error| [\onExit, error].postln };

(
try {
	protect { 123.postln; 456.throw; 789.postln } {|error| [\onExit, error].postln };
} {|error| [\catch, error].postln };
)

value { 123.postln; 456.throw; 789.postln }

value { 123.postln; Error("what happened?").throw; 789.postln }

(
a = [\aaa, \bbb, \ccc, \ddd];
a[1].postln;
a[\x].postln;
a[2].postln;
)

(
try {
	a = [\aaa, \bbb, \ccc, \ddd];
	a[1].postln;
	a[\x].postln;
	a[2].postln;
} {|error| \caught.postln; error.dump }
)

(
try {
	a = [\aaa, \bbb, \ccc, \ddd];
	a[1].postln;
	a[\x].postln;
	a[2].postln;
} {|error| \caught.postln; error.dump; error.throw }
)

(
protect {
	a = [\aaa, \bbb, \ccc, \ddd];
	a[1].postln;
	a[\x].postln;
	a[2].postln;
} {|error| \caught.postln; error.dump }
)


Audio

play(target, outbus, fadetime, addAction)

	This is probably the simplest way to get audio in SC3. It wraps the Function in a SynthDef (adding an Out ugen if needed), creates and starts a new Synth with it, and returns the Synth object. A Linen is also added to avoid clicks, which is configured to allow the resulting Synth to have its \gate argument set, or to respond to a release message. Args in the function become args in the resulting def.

	target - a Node, Server, or Nil. A Server will be converted to the default group of that server. Nil will be converted to the default group of the default Server.
	outbus - the output bus to play the audio out on. This is equivalent to Out.ar(outbus, theoutput). The default is 0.
	fadeTime - a fadein time. The default is 0.02 seconds, which is just enough to avoid a click. This will also be the fadeout time for a release if you do not specify.
	addAction - see Synth for a list of valid addActions. The default is \addToHead.

	x = { arg freq = 440; SinOsc.ar(freq, 0, 0.3) }.play; // this returns a Synth object;
	x.set(\freq, 880); // note you can set the freq argument
	x.defName; // the name of the resulting SynthDef (derived from the Functions hash value)
	x.release(4); // fadeout over 4 seconds

	Many of the examples in SC3 make use of the Function.play syntax. Note that reusing such code in a SynthDef requires the addition of an Out ugen.

	// the following two lines produce equivalent results
	{ SinOsc.ar(440, 0, 0.3) }.play(fadeTime: 0.0);
	SynthDef("help-FuncPlay", { Out.ar(0, SinOsc.ar(440, 0, 0.3))}).play;

	Function.play is often more convienent than SynthDef.play, particularly for short examples and quick testing. The latter does have some additional options, such as lagtimes for controls, etc. Where reuse and maximum flexibility are of greater importance, SynthDef and its various methods are usually the better choice.
	

scope(numChannels, outbus, fadeTime, bufsize, zoom)

	As play above, but plays it on the internal Server, and calls Server-scope to open a scope window in which to view the output. Currently only works on OSX.
	
	numChannels - The number of channels to display in the scope window, starting from outbus. The default is 2.
	outbus - The output bus to play the audio out on. This is equivalent to Out.ar(outbus, theoutput). The default is 0.
	fadeTime - A fadein time. The default is 0.02 seconds, which is just enough to avoid a click.
	bufsize - The size of the buffer for the ScopeView. The default is 4096.
	zoom - A zoom value for the scope's X axis. Larger values show more. The default is 1.

	{ FSinOsc.ar(440, 0, 0.3) }.scope(1)



plot(duration, server, bounds, minval, maxval, parent)

	Calculates duration in seconds worth of the output of this function, and plots it in a GUI window. Unlike play and scope it will not work with explicit Out Ugens, so your function should return a UGen or an Array of them. The plot will be calculated in realtime.

	duration - The duration of the function to plot in seconds. The default is 0.01.
	server - The Server on which to calculate the plot. This must be running on your local machine, but does not need to be the internal server. If nil the default server will be used.
	bounds - An instance of Rect or Point indicating the bounds of the plot window.
	minval - the minimum value in the plot. Defaults to -1.0.
	maxval - the maximum value in the plot. Defaults to 1.0.
	parent - a window to place the plot in. If nil, one will be created for you.

	{ SinOsc.ar(440) }.plot(0.01, bounds: GUI.window.screenBounds);
	
	{ {|i| SinOsc.ar(1 + i)}.dup(7) }.plot(1);



Conversion



asSynthDef(rates, prependArgs, outClass, fadetime)

	Returns a SynthDef based on this Function, adding a Linen and an Out ugen if needed.

	rates - An Array of rates and lagtimes for the function's arguments (see SynthDef for more details).
	outClass - The class of the output ugen as a symbol. The default is \Out.
	fadeTime - a fadein time. The default is 0.



asDefName

Performs asSynthDef (see above), sends the resulting def to the local server and returns the SynthDefs name. This is asynchronous.

x = { SinOsc.ar(440, 0, 0.3) }.asDefName; // this must complete first
y = Synth.new(x);


asRoutine

Returns a Routine using this as its func argument.







