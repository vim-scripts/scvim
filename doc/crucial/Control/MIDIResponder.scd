MIDIResponder

Register multiple functions to be evaluated when MIDI events occur.

MIDIResponder is an abstract class. These subclasses should be used for specific midi work.

CCResponder Respond to control messages
NoteOnResponder Respond to note-on messages
NoteOffResponder Respond to note-off messages
BendResponder Respond to pitch bend messages
TouchResponder Respond to aftertouch messages

Creation and initialization:

CCResponder(function, src, chan, num, value, install = true)
NoteOnResponder(function, src, chan, num, veloc, install = true)
NoteOffResponder(function, src, chan, num, veloc, install = true)
BendResponder(function, src, chan, value, install = true)
TouchResponder(function, src, chan, value, install = true)

function: The function to execute when the incoming MIDI event matches the responder. The function takes the arguments src, chan, A, B (or for Bend and Touch, src, chan, value).
src: If a number is given, the responder will fire only for messages coming in from this port. The number may be the system UID (obtained from MIDIClient.sources[index].uid) or the index itself. If nil, the responder will match any port.
chan: The MIDI channel(s) to match.
num: The control or note number(s) to match.
value: The value(s) to match.
veloc: The velocities to match.
install: If true, install the responder automatically. If false, return the responder but don't install it (it will be inactive).

Any of the matching values may be one of the following:

Nil: Match anything.
Integer: Match only this specific number.
Array: Match any item in the array. Any kind of Collection will work here.
Function: Evaluate the function with the incoming value as the argument. The function should return true or false.

For instance, this would respond to note on messages from any port, channels 2 and 7 only, even numbered note numbers only, and only velocity values greater than 50. 

NoteOnResponder({ |src, chan, num, vel| [src, chan, num, vel].postln }, 
 nil, 
 [2, 7], 
 (0, 2..126), // could also be { |num| num.even } or _.even
 { |vel| vel > 50 });

MIDIResponders automatically initialize the MIDIClient with 1 standard device. If you have more devices, simply initialize the MIDIClient yourself before using any MIDIResponders.

Removal:

Just call .remove on the responder.

c = CCResponder({ ... }, num: 1); // respond to any modwheel

c.remove; // stop this responder
