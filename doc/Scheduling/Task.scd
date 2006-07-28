Task a pauseable process

superclass: PauseStream 

Task is a pauseable process. It is implemented by wrapping a PauseStream around a Routine. Most of it's methods (start, stop, reset) are inherited from PauseStream.

Task.new(func, clock)
func - A Function to be evaluated. 
clock - A Clock in which to play the Routine. If you do not provide a Clock the default is an instance of TempoClock. Remember that methods which call Cocoa primitives (i.e. GUI functions) must be played in AppClock.


t = Task({ 
 50.do({ arg i;
 i.squared.postln; 
 0.5.wait 
 }); 
 });

t.start;
t.stop;
t.start;
t.reset;
t.stop;
