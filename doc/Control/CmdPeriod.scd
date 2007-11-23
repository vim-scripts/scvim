
CmdPeriod			register objects to be cleared when Cmd-. is pressed

Superclass: Object

CmdPeriod allows you to register objects to perform an action when the user presses Cmd-. These objects must implement a method called -cmdPeriod which performs the necessary tasks. (You can add such a method in your custom classes.) Note that since Function implements -cmdPeriod as a synonym for -value, it is possible to register any function (and thus any arbitrary code) for evaluation when Cmd-. is pressed.

N.B. Cmd-. uses an IdentitySet to store its registered objects. For this reason you cannot rely on the order in which the objects will be cleared. If you need -cmdPeriod to be called on a set of objects in a given order then it is best to wrap those within a Function and register that. (See example below.)

Class Methods

*add(object)

Registers an object to be cleared when Cmd-. is pressed. This object will stay registered until it is explicitly removed, and will thus respond to additional presses of Cmd-.

*remove(object)

Removes an object that was previously registered.

*doOnce(object)

Registers an Object o be evaluated once, and then unregistered.

*objects		return the list of objects that are called when CmdPeriod is evaluated.

*objects_(array)	set the list of objects that are called when CmdPeriod is evaluated.

*era			number of times CmdPeriod has been called since startup.



Examples

(
f = {"foo".postln };
g = {"bar".postln };
CmdPeriod.add(f);
CmdPeriod.add(g);
)

// Now press Cmd-.

CmdPeriod.remove(g);

// Now press Cmd-. Only f executes

CmdPeriod.remove(f); // must explicitly cleanup

//// Controlling order of execution
(
f = {"first".postln };
g = {"second".postln };

// order is arbitrary, so wrap in a function

h = { f.cmdPeriod; g.cmdPeriod;};

CmdPeriod.add(h);
)

// Now press Cmd-.

CmdPeriod.remove(h);


// note that often you want to automatically remove the function once it is evaluated
// instead of

f = { "foo".postln; CmdPeriod.remove(f) };
CmdPeriod.add(f);

// you can write:

CmdPeriod.doOnce { "foo".postln }

// a typical example:
(
w = SCWindow.new("close on cmd-.").front;
CmdPeriod.doOnce {w.close };
)



