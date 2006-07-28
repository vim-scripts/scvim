Environment

superclass: IdentityDictionary

An Environment is an IdentityDictionary mapping Symbols to values. There is always one current Environment which is stored in the currentEnvironment class variable of class Object.

Symbol and value pairs may be put into the current Environment as follows:

currentEnvironment.put(\myvariable, 999);

and retrieved from the current Environment as follows:

currentEnvironment.at(\myvariable).postln;

The compiler provides a shorthand for the two constructs above .

~myvariable = 888;

is equivalent to:

currentEnvironment.put(\myvariable, 888);

and:

~myvariable.postln;

is equivalent to:
 
currentEnvironment.at(\myvariable).postln;

Making an Environment

Environment has a class method make which can be used to create an Environment and fill it with values. What make does is temporarily replace the current Environment with a new one, call your function where you fill the Environment with values, then it replaces the previous current Environment and returns you the new one.

(
var a;
a = Environment.make({
 ~a = 100;
 ~b = 200;
 ~c = 300;
});
a.postln;
)

Using an Environment

The instance method use lets you temporarily replace the current Environment with one you have made. The use method returns the result of your function instead of the Environment like make does.

(
var a;
a = Environment.make({
 ~a = 10;
 ~b = 200;
 ~c = 3000;
});
a.use({
 ~a + ~b + ~c
}).postln;
)

There is also a use class method for when you want to make and use the result from an Environment directly.

(
var a;
a = Environment.use({
 ~a = 10;
 ~b = 200;
 ~c = 3000;
 ~a + ~b + ~c
}).postln;
)

Calling Functions with arguments from the current Environment

It is possible to call a Function and have it look up any unspecified argument values from the current Environment. This is done with the valueEnvir and valueArrayEnvir methods. These methods will, for any unspecified argument value, look in the current Environment for a symbol with the same name as the argument. If the argument is not found then whatever the function defines as the default value for that argument is used.

(
var f;

// define a function
f = { arg x, y, z; [x, y, z].postln; };

Environment.use({
 ~x = 7;
 ~y = 8;
 ~z = 9;
 
 f.valueEnvir(1, 2, 3); // all values supplied
 f.valueEnvir(1, 2); // z is looked up in the current Environment
 f.valueEnvir(1); // y and z are looked up in the current Environment 
 f.valueEnvir; // all arguments are looked up in the current Environment
 f.valueEnvir(z: 1); // x and y are looked up in the current Environment
});
)

Now here is how this can be used with an instrument function. Environments allow you to define instruments without having to worry about argument ordering conflicts. Even though the three functions below have the freq, amp and pan args declared in different orders it does not matter, because valueEnvir looks them up in the
environment. 

s.boot;

(
var a, b, c, orc;

a = { arg freq, amp, pan;
 Pan2.ar(SinOsc.ar(freq), pan, amp);
};
b = { arg amp, pan, freq;
 Pan2.ar(RLPF.ar(Saw.ar(freq), freq * 6, 0.1), pan, amp);
};
c = { arg pan, freq, amp;
 Pan2.ar(Resonz.ar(GrayNoise.ar, freq * 2, 0.1), pan, amp * 2);
};
orc = [a, b, c];
// 'reverb'
{ var in; in = In.ar(0, 2); CombN.ar(in, 0.2, 0.2, 3, 1, in); }.play(addAction: \addToTail);

{ loop({
Environment.use({
 // set values in the environment
~freq = exprand(80, 600);
~amp = 0.1;
~pan = 1.0.rand2;

 // call a randomly chosen instrument function 
 // with values from the environment

 x = { orc.choose.valueEnvir; }.play(fadeTime: 0.2, addAction: \addToHead); 
 0.2.wait; 
 x.release(0.2); 
});
}) }.fork;
 
)
