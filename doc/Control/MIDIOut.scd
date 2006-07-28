MIDIOut

MIDIout objects interface MIDI output ports defined by the operating system to the language.
 from the operating system to a set of user defined functions.
 
methods
 noteOn ( chan, note, veloc )
 noteOff ( chan, note, veloc )
 polyTouch ( chan, note, val )
 control ( chan, ctlNum, val )
 program ( chan, num )
 touch ( chan, val )
 bend ( chan, val )
 allNotesOff ( chan )
 smpte ( frames, seconds, minutes, hours, frameRate )
 songPtr ( songPtr )
 songSelect ( song )
 midiClock ( )
 startClock ( )
 continueClock ( )
 stopClock ( )
 reset ( )
 sysex ( uid, Int8Array )
 send ( outport, uid, len, hiStatus, loStatus, a, b, latency )


MIDIClient.init;

m = MIDIOut(0, MIDIClient.destinations.at(0).uid);
m.noteOn(16, 60, 60);

MIDIIn.connect;
MIDIIn.sysex = { arg uid, packet; [uid,packet].postln };
MIDIIn.sysrt = { arg src, chan, val; [src, chan, val].postln; };
MIDIIn.smpte = { arg src, chan, val; [src, chan, val].postln; };

m.sysex(MIDIClient.destinations.at(0).uid, Int8Array[ 16rf0, 0, 0, 27, 11, 0,16rf7])

 m.smpte (24,16) 
 m.midiClock 
 m.start 
 m.continue 
 m.stop 
 