KeyCodeResponder


Handles multiple registrations for keycode and modifier combinations. 
This object should be used as the keydown or keyup action for a view in place of a function.

KeyCodes are hardware dependant, and change from machine to machine.  
Its a simple way to hook up keys to respond, but it won't transfer to other people's computers.

see also [UnicodeResponder] which matches based on the unicode, though the physical location
of the key may still vary according zee nationality ov der keyboard.


see [SCView]

Use this to post the keycodes
(

KeyCodeResponder.tester

)
it prints

// shift :
k.register( 41 , true, false, false, false, {

});



(

k = KeyCodeResponder.new;

// match single modifiers exclusively
k.normal( 36 -> { "return".postln });
k.option( 36 -> { "option return".postln });
k.shift( 36 -> { "shift return".postln });
// overwrites previous registration
k.shift( 36 -> { "SHIFT RETURN only".postln; });



// match multiple modifier combinations
 // shift caps opt control
k.register( 36, true, nil, true, false, {
 // yes either yes no
 "return: shift-option regardless of CAPS".postln;
});


k.registerKeycode(KeyCodeResponder.normalModifier, 52 , { "enter".postln; });

// arrow keys are considered function keys and must be bit ORd with function key modifier
k.registerKeycode(KeyCodeResponder.normalModifier | KeyCodeResponder.functionKeyModifier , 123 , { "<-".postln; 
});

k.registerKeycode(KeyCodeResponder.controlModifier | KeyCodeResponder.functionKeyModifier , 123 , {
 "control <-".postln; 
});

w = SCWindow.new.front;
v = SCSlider.new(w,Rect(10,10,100,100));
v.keyDownAction = k;
v.focus;

)




register(keycode, shift, caps, opt, cntl, function)

 for shift, caps,opt,cntl
true indicates a required modifier
false indicates an excluded modifier
nil expresses that you really don't care one way or the other
 

normal(keycode -> function)
normal(keycode -> fuction, keycode2 -> function2 , ... keycodeN -> functionN )

 note the association ( key -> value )
 
shift(keycode -> function)
shift(keycode -> fuction, keycode2 -> function2 , ... keycodeN -> functionN )

option(keycode -> function)
option(keycode -> fuction, keycode2 -> function2 , ... keycodeN -> functionN )

control(keycode -> function)
control(keycode -> fuction, keycode2 -> function2 , ... keycodeN -> functionN )







Any player's gui can have its keyDownAction set

(

p = Patch({ arg freq=440; SinOsc.ar(freq,mul: 0.1) });
g = p.gui;
g.keyDownAction = {
 "you touched me".postln;
};

)
focus on the slider. notice that every key stroke is passed,
the slider does not swallow them.


or you can use KeyCodeResponder

kcr = KeyCodeResponder.new;
kcr.option( 36 -> { "option 36".postln });
kcr.shift( 36 -> { "shift 36".postln });
aPatchGui = aPatch.gui;
aPatchGui.keyDownAction = kcr;

This means that when ever the player is focused (any of its controls is in focus), these keys will be active providing that the view that is actually in focus doesn't handle the key event (it should have a nil keyDownAction function or pass nil).



You can concatenate KeyCodeResponders using ++




global keydowns not yet tested....
(
KeyCodeResponder.clear;
/*
this will fire on shift-'r'
 shift must be held down
 caps must NOT be down
 cntl or opt status is irrelevant
*/
KeyCodeResponder.register(15,true,false,nil,nil,{ "shift, no caps".postcln });

/*
this will fire on shift-'r'
 shift must be held down
 caps may or may not be down
 cntl or opt status is irrelevant
*/
KeyCodeResponder.register(15,true,nil,nil,nil,{ "shift, yes/no caps".postcln });
Sheet({ arg f; ActionButton(f).focus });


)



 
This is very useful when using CAPS-LOCK to switch interface modes etc.

Only one function per deny/require mask combination is possible per keycode:
(
// hit shift - r
KeyCodeResponder.register(15,true,nil,nil,nil,{ "shift r".postcln });
KeyCodeResponder.register(15,true,nil,nil,nil,{ "overwrote the previous one".postcln });
Sheet({ arg f; ActionButton(f).focus });

)



The simpler, older method is :

KeyCodeResponder.registerKeycode(2,28,{ });// *

whereby that modifier and only that modifier will fire the funtion.
see SCView for modifier values or use this :

(

 KeyCodeResponder.tester

)



// using characters 
KeyCodeResponder.registerChar(0,$q,{ }); // q no modifier



Gotcha: it is easy to forget that you registered a function with KeyCodeResponder
that holds a reference to a large object. Garbage Collection will not remove the object until
you have released your reference.

solution:
 // place this at the top of your performance code to start with a clean slate
 KeyCodeResponder.clear;


 
 
