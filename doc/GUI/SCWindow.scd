SCWindow user interface window

 
 
 *new(name, bounds, resizable, border);
 
 
 bounds: a Rect(
 distance from left,
 distance from bottom,
 width,
 height
 )
*closeAll closes all windows
*allWindows a list of all windows
 
fullScreen fullscreeen mode, no way to close it then. so don't forget the button
endFullScreen end the fullscreen mode
 
userCanClose_ if set to false, window is uncloseable
close close the window
frontdisplay the window, bring it to the front.
 
refresh sometimes this has to becalled so the views are updated
alpha_ tranparency channel value (0...1)
bounds_ set the bounds to a Rect
 
onClose_ can be set to a function


//examples


//how to add views
(

var w;
w = SCWindow("my name is... panel", Rect(128, 64, 340, 360));

32.do({ arg i;
 b = SCButton(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
 b.states = [["Start "++i, Color.black, Color.rand],
 ["Stop "++i, Color.white, Color.red]];
});

w.front; 

)


view
 every window has an SCTopView instance, which contains all the other views.
 
(

var w;
w = SCWindow("my name is... panel", Rect(128, 64, 340, 360));

w.view.decorator = FlowLayout(w.view.bounds);
w.view.background = Color(0.6,0.8,0.8);
w.front;

32.do({ arg i;
 b = SCButton(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
 b.states = [["Start "++i, Color.black, Color.rand],
 ["Stop "++i, Color.white, Color.red]];
});

w.front; 

)

bounds_(aRect)
 set the bounds of the window
(

x = SCWindow.new;
x.front;

x.bounds_(Rect(10,10,100,30));

)

Note that the setting of the bounds doesn't happen until the application finishes its current application event cycle. Thus, if you check the bounds in the same chunk of code, the SCWindow will not yet have it updated.

 // execute this all at once
 w = SCWindow.new("test");
 w.front;
 w.bounds = Rect(50, 50, 50, 50);
 w.bounds.postln;
 { w.bounds.postln; nil }.defer(0.1); // next application event cycle


setInnerExtent(width,height)

Changes the size of the window while keeping the top left corner fixed. This is the usual desired behavior, but quick draw and Rect have flipped coordinate systems.


userCanClose_(boolean)

Set this to true to prevent command-w from closing the window. window.close will still close it, and it will still close on recompiling the library.


border argument

 SCWindow.new(border:false).front; //can't be closed, as it has no buttons, also cmd-w not.
 SCWindow.closeAll;




onClose

 get the current onClose function.


onClose_
set a function that will be evaluated when the window is closed.

//close the window and the synth plays
(
 x = SCWindow.new.front;
 x.alpha = 0.8;
 x.onClose_({ Synth.new(\default) });
)

 


