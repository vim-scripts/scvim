
SCTextField			

Inherits from: Object : SCView : SCStaticTextBase : SCNumberBox

An editable text field.

See also: SCStaticText, SCTextView

Creation / Class Methods

	*new(parent, bounds)
	
Instance Methods
	
	action_(func)
	action
		
		Set or return a function to be called upon enter/return key.
	
	string_(str)
	string
	value_(str)
	value
		
		Set or return the text string.
	

Examples

(
w = SCWindow.new.front;
a = SCTextField(w, Rect(10, 10, 100, 20));
a.string = "hi there";
a.action = {arg field; field.value.postln; };
)

// does not do the action
a.value = "yo";
a.string = "oy";

a.boxColor_(Color.grey)
a.stringColor_(Color.white)
a.align_(\center)

//Does not handle composed character sequences (   etc. )

//option-e appears to freeze it ?


