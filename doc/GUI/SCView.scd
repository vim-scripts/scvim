SCView

superclass: Object

SCView is the abstract superclass for all SC GUI widgets. Currently this system is OSX only. On Linux there is another GUI implementation, SCUM, which has its own documentation. Several key methods and variables are defined in SCView and inherited in its subclasses.

resize_(int)

This setting controls how the widget will behave when it's window or enclosing view is resized. This is illustrated graphically below:

 1 2 3
 4 5 6
 7 8 9
 
 1 - fixed to left, fixed to top
 2 - horizontally elastic, fixed to top
 3 - fixed to right, fixed to top
 
 4 - fixed to left, vertically elastic
 5 - horizontally elastic, vertically elastic
 6 - fixed to right, vertically elastic
 
 7 - fixed to left, fixed to bottom
 8 - horizontally elastic, fixed to bottom
 9 - fixed to right, fixed to bottom

resize

Return an Integer corresponding to the current resize behaviour (see above).

keyDownAction_(aFunction)

Register a Function to be evaluated when a keystroke is received and this view is in focus.

(
// select the slider, type something and watch the post window
 w = SCWindow.new;
 c = SCSlider(w,Rect(0,0,100,30));
 c.keyDownAction = { arg view,char,modifiers,unicode,keycode;
 [char,modifiers,unicode,keycode].postln;
 };
 w.front;
)

If you return nil from your function, or you have no function registered, the event will bubble up to the parent view which may then respond. It will continue to bubble up unless something responds or it hits the topView of the window. You may register a function in the window's topView to respond to all unhandled events for the window.

There are default keyDownActions for some views, which will be overridden when you set a keydown action.

When called, the function will be passed the following arguments:

view - The receiving instance of SCView.

char - The character pressed, possibly unprintable. Character sequences (for example ?) get passed as two characters, the first one blank ( ), the second one is the unmodified character (e). This will also vary depending on the nationality the keyboard is set to.

modifiers - An integer bit field indicating the modifier keys in effect. You can examine individual flag settings using the C bitwise AND operator.
 
 65536 NSAlphaShiftKeyMask 
 Set if Caps Lock key is pressed. 
 
 131072 NSShiftKeyMask 
 Set if Shift key is pressed. 
 
 262144 NSControlKeyMask 
 Set if Control key is pressed. 
 
 524288 NSAlternateKeyMask 
 Set if Option or Alternate key is pressed. 
 
 1048576 NSCommandKeyMask 
 Set if Command key is pressed. 
 
 2097152 NSNumericPadKeyMask 
 Set if any key in the numeric keypad is pressed. The numeric keypad is generally on the right side of the keyboard. 
 
 4194304 NSHelpKeyMask 
 Set if the Help key is pressed. 
 
 8388608 NSFunctionKeyMask 
 Set if any function key is pressed. The function keys include the F keys at the top of most keyboards (F1, F2, and so on) and the navigation keys in the center of most keyboards (Help, Forward Delete, Home, End, Page Up, Page Down, and the arrow keys). 
 
 arrow keys have an extra modifier value of 10485760
 so for a shift arrow key do a bitwise 'or' with the shift mask:
 10485760 | 131072
 = 10616832 // this is the mask for shift arrow key
 
unicode - The unicode integer, identical to the char.
 
keycode - The hardware dependent keycode indicating the physical key. This will vary from machine to machine, but is useful for building musical interfaces using the computer keyboard. In order to play little melodies, this code will identify which key you consider to be special.

N.B.: Function key modifier may change the keycode.

For various reasons these don't make it through cocoa:
 most command modifiers
 cntl-tab
 cntl-escape
 tab and shift tab are currently trapped by SC itself for cycling the focus through the views.
 (we could change this)

keyDownAction

Return the current keyDownAction function for this view if there is one, otherwise return nil.

*globalKeyDownAction_(func)

A function that is evaluated for every keyDown event on every SCView. See keyDownAction_ for details.

focus

Brings this view into focus.

(
 w = SCWindow.new;
 c = SCSlider(w,Rect(0,0,100,30));
 d = SCSlider(w,Rect(0,30,100,30));
 w.front;
)

 c.focus;
 d.focus;
 w.close;

refresh

Under certain circumstances a view will not automatically update its appearance. This forces a redraw.

(
 w = SCWindow.new;
 c = SCButton(w,Rect(0,0,100,30));
 c.states = [["a",Color.black,Color.red]];
 d = SCButton(w,Rect(0,30,100,30));
 d.states = [["a",Color.black,Color.red]];
 w.front;
)

 // won't display change...
 c.states = [["b",Color.red,Color.black]];
 d.states = [["b",Color.red,Color.black]];
 
 //until
 c.refresh;
 
 //needs separate refresh
 d.refresh;
 
 // in some cases might be better to refresh the whole window
 // which does refresh on all damaged areas (it keeps track, doesn't redraw whole thing)
 
 c.states = [["a",Color.black,Color.red]];
 w.refresh;
 w.close;
 
 
drag and drop

Each view subclass has a default object that it exports when dragged from. For sliders its the value of the slider, for lists it is the currently selected numeric index etc. 

By setting the beginDragAction handler you can return a different object based on the context and your application.

beginDragAction(theView) - return the object you wish your view to export by dragging
 aView.beginDragAction = { arg theView; someList[ theView.value ] }
 
The current dragged thing can be found in the classvar SCView.currentDrag. Objects dragged from within 
SuperCollider are also in SCView.currentDragString as a compile string. Text dragged
from other applications is in SCView.currentDragString and the results of attempting to
compile that as sc code is in SCView.currentDrag

Each view subclass has a defaultCanReceiveDrag method that determines if the current object being dragged is possible for this view to accept, and a defaultReceiveDrag method for actually receiving the drag. Sliders accept numbers, simple text labels do not accept drags etc. After receiving the drag, the SCView.currentDrag is set to nil.

By setting the canReceiveDragHandler and receiveDragHandler you can make any view accept and receive objects based on the context and your application. (Note: currently not possible for SCStaticText)

canReceiveDrag(theView) - return true/false if you are willing to accept the current drag.
 aView.canReceiveDrag = false; // no, leave me alone
 aView.canReceiveDrag = { SCView.currentDrag.isString };
 
receiveDrag(theView) - accept the drag.
 aView.receiveDrag = { 
 SCView.currentDrag.postln;
 }


The default drag object from a list view is the currently selected integer index.
Here a list view is made to export a string.
(
 f = SCWindow.new.front;
 a = SCListView(f,100@100);
 a.items = ["eh?","bee!","sea."];
 a.beginDragAction = { arg listView;
 listView.items[ listView.value ].debug("begun dragging");
 };
 
 c = nil;
 b = SCButton(f,Rect(0,200,200,20));
 b.states = [["Drop stuff on me"]];
 b.canReceiveDragHandler = { SCView.currentDrag.isString };
 b.receiveDragHandler = { 
 b.states = [[SCView.currentDrag]];
 c = SCView.currentDrag;
 };
 b.action = {
 c.postln
 };
 
)

