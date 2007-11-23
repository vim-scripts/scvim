
Notes on MIDI support in SuperCollider

Contents

Introduction
Receiving MIDI input: MIDIIn
dewdrop_lib MIDI framework
Playing notes on your MIDI keyboard
Sending MIDI out
MIDI synchronization
Third party libraries

Introduction

SuperCollider's out of the box MIDI support is fairly thorough (although not as complete as you'll find in commercial sequencers). All MIDI devices accessible to CoreMIDI are accessible to SuperCollider.

Note: This document is written from an OSX perspective. The essential behavior of the MIDI interface classes should be the same on other platforms, despite my continual reference to CoreMIDI here.

SuperCollider does not impose much higher-level structure on MIDI functionality. The core classes are little more than hardware abstractions (see also the [MIDI] helpfile):

MIDIClient: represents SuperCollider's communications with CoreMIDI
MIDIIn: receives MIDI messages and executes functions in response to those messages
MIDIOut: sends MIDI messages out to a specific port and channel
MIDIEndPoint: a client-side representation of a CoreMIDI device, containing three variables (name, device and uid, which is a unique identifier assigned by the system)

In most cases, each physical MIDI connection (pair of in/out jacks on the MIDI interface) has one MIDIEndPoint object to represent it in the client.

Receiving MIDI input: MIDIIn

The MIDIIn class provides two ways to receive MIDI input: MIDI response functions, and routines that wait for MIDI events.

1. MIDI response functions

MIDIIn has a number of class variables that are evaluated when a MIDI event comes in. Technical details on each function can be found in the MIDIIn help file.

noteOn
noteOff
control
bend
touch
polyTouch
program
sysex
sysrt
smpte

To assign a response to a particular kind of MIDI message, assign a function to the class variable:

MIDIIn.connect;
MIDIIn.noteOn = { |port, chan, note, vel| [port, chan, note, vel].postln };
MIDIIn.noteOn = nil; // stop responding

MIDIIn provides the responding functions with all the information coming in from CoreMIDI:

source (src): corresponds to the uid of the MIDIEndPont from which the message is coming.
channel (chan): integer 0-15 representing the channel bits of the MIDI status byte

... with subsequent arguments representing the data bytes. The MIDIIn help file details all the supported messages along with the arguments of the responding function for the message.

Because these are class variables, you can have only one function assigned at one time. A common usage is to assign a function that looks up responses in a collection. For example, you could have a separate set of response functions for each channel.

~noteOn = Array.fill(16, IdentityDictionary.new);
MIDIIn.noteOn = { |port, chan, num, vel| ~noteOn[chan].do(_.value(port, chan, num, vel)) };

 // this function will respond only on channel 0
~noteOn[0].put(\postNoteOn, { |port, chan, num, vel| [port, chan, note, vel].postln });
~noteOn[0].removeAt(\postNoteOn); // stop responding

The advantage of this approach over using "if" or "case" statements in the response function is that you can add and remove responses without having to change the MIDIIn function. The MIDIIn function can serve as a "hook" into another structure that distributes the MIDI events to the real responders.

Third-party frameworks exist to handle this bookkeeping automatically. See the "Third party libraries" section at the bottom of this file.

2. Routines that wait for MIDI events

As of December 2004, there is an alternate technique to supply multiple responses for the same MIDI event type. This routine waits for a MIDI event, then posts information about the event. After your routine receives the MIDI event, it can take any other action you desire.

r = Routine({
	var	event;
	loop {
		event = MIDIIn.waitNoteOn;
		[event.status, event.b, event.c].postln;
	}
}).play;

r.stop;		// stop responding

Supported MIDI event waiting methods are:

waitNoteOn
waitNoteOff
waitControl
waitBend
waitTouch
waitPoly

You can have multiple routines assigned to the same MIDI event type. The MIDI wait method lets you specify conditions for the routine to fire based on the arguments of the corresponding MIDI responder function:

event = MIDIIn.waitNoteOn(nil, [2, 7], (0, 2..126), { |vel| vel > 50 });

This would respond to note on messages from any port, channels 2 and 7 only, even numbered note numbers only, and only velocity values greater than 50.

Use caution when creating a large number of MIDI response routines with very specific conditions. For each incoming MIDI event, SuperCollider will iterate over the entire list for that event type, which incurs a CPU cost. If you have 500 MIDI controller routines, and an incoming event should trigger only 2, all 500 sets of conditions have to be evaluated.

In that case it may be more efficient to create a smaller number of routines and evaluate some of the conditions inside routines, either using branching statements or by looking up functions inside collections.

Playing notes on your MIDI keyboard

The technical problem is that every note on needs to save its synth object so that the note off message can end the right server-side node.

s.boot;

(
var notes, on, off;

MIDIIn.connect;

notes = Array.newClear(128); // array has one slot per possible MIDI note

on = Routine({
	var event, newNode;
	loop {
		event = MIDIIn.waitNoteOn;	// all note-on events
			// play the note
		newNode = Synth(\default, [\freq, event.b.midicps,
			\amp, event.c * 0.00315]); // 0.00315 approx. == 1 / 127 * 0.4
		notes.put(event.b, newNode);	// save it to free later
	}
}).play;

off = Routine({
	var event;
	loop {
		event = MIDIIn.waitNoteOff;
			// look up the node currently playing on this slot, and release it
		notes[event.b].set(\gate, 0);
	}
}).play;

q = { on.stop; off.stop; };
)

// when done:
q.value;

The MIDIIn help file contains a more elaborate example.

SuperCollider does not have a built-in class to handle this automatically. However, dewdrop_lib, one of the third party libraries mentioned below, includes a small suite of classes designed for exactly this purpose. Users interested in this functionality may wish to examine that library.

Sending MIDI out

See the [MIDIOut] helpfile. Unlike MIDIIn, with MIDIOut you create an instance of the MIDIOut class with a port and uid. You can have multiple MIDIOut objects to send MIDI to different physical devices.

Many users have reported timing issues with MIDIOut. When the CPU is busy, especially during graphics updates, outgoing MIDI messages may be delayed. Use with caution in a performance situation.

MIDI synchronization

MIDI synchronization may be performed using MIDIIn's sysrt or smpte response functions. It's up to the user to implement the desired kind of synchronization.

For sysrt, external MIDI clocks output 24 pulses per quarter note. The responder should count the incoming pulses and multiply the rhythmic value into 24 to determine how many pulses to wait:

0.25		wait 6 pulses (16th note)
0.5		wait 12 pulses (8th note)
2		wait 48 pulses (half note)

dewdrop_lib (third party library) includes a class, MIDISyncClock, that receives MIDI clock messages and allows events to be scheduled to keep time with an external MIDI device. See the [MIDISyncClock] helpfile for details.

There are significant limitations, discussed in the helpfile. This is not really a fully supported class, but it's there for users who are desperate for the functionality.

Third party libraries

The crucial library (included in the main distribution) includes a couple of classes (NoteOnResponder, NoteOffResponder, CCResponder) that simplify the use of multiple responders when all ports and channels should respond identically. Multichannel MIDI applications are not possible using these classes.

dewdrop_lib is a third party library providing a number of useful performance features, available from <http://www.dewdrop-world.net>. The library provides a user-extensible framework of MIDI responder classes designed for multiport, multichannel applications.

Among its features:

- user-extensible: simple functions may be used, and frequently-needed responses can be written into classes that inherit from the framework (see [BasicMIDISocket] and [BasicMIDIControl])

- easy to use classes for playing MIDI notes and assigning MIDI controllers to synthesis parameters

- a user-configurable array of MIDI controller numbers, to simplify assignment of events to hardware controllers

The framework is not part of the main distribution. Interested users need to download the tarball from the website above and follow the installation instructions.


