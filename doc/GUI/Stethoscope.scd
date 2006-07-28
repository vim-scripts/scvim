Stethoscopescope window

a graphical interface to navigate on buses

works only with internal server



the scope window can be controlled by the following keys:


 J one channel back
K switch rate (audio vs. control)
 L one channel forward

O jump to first hardware output channel and adjust numChannels to hardware
 I jump to first hardware input channel and adjust numChannels to hardware

space run, if not running anyway.
. (period) stop.
M toggle screen size
 
 + / - zoom horizontally
* / _  zoom vertically
S change style between parallel and overlay

shift S change style to lissajou (use only with fast computer and small buffer size)
shift A allocate buffer size so it fills the screen (to next power of two) (this can be dangerous, might crash)


instance creation:


*new(server, numChannels, index, bufsize, zoom, rate, view)
 returns a new instance of Stethoscope.
 
 by the message .scope:
 
aServer.scope(numChannels, index, bufsize, zoom, rate)
 opens a scope window for the server, stores it in the server instance var scopeWindow

aBus.scope(bufsize, zoom)
 displays buffer channels in scope
 
aFunction.scope(numChannels, outbus, fadeTime, bufsize, zoom)
 plays a function and shows output in scope, returns synth object, like { }.play



instance methods:


allocBuffer(size)
 (re)allocate the buffer to a given size
run
 start it if not playing anyway
free
 end it, free the buffer
 
numChannels_
 change the number of channels displayed
index_
 change the offset index
rate_
 change the rate (\audio or \control)
size_
 set the window size (default: 222)
zoom_
 set horizontal zoom

 setProperties( numChannels, index, bufsize, zoom, rate )
 any of these given will adjust the scope accordingly:
 e.g. x.setProperties(zoom:8) will only zoom.

// examples:

(
Server.default = Server.internal;
s = Server.default;
s.boot;
)
(
{ 
 SinOsc.ar([225, 450, 900], 0, 0.2) 
 + LPF.ar(
 LFPulse.ar(226 * [1, 2, 5],[0,0.1,0.1],0.2, 0.2), 
 MouseX.kr(20, 10000, 1)
 ) 
}.scope;
)

// server.scope only changes the properies explicitly given:

s.scope(numChannels:5);
s.scope(index:12);
s.scope(zoom:4);
s.scope(index:0);

s.scopeWindow.size = 600;
s.scopeWindow.size = 222;

// scoping buses:

a = Bus.audio(s, 4);
{ WhiteNoise.ar(0.2.dup(4)) }.play(s, a.index);

a.scope;

c = Bus.control(s, 3);
{ WhiteNoise.kr(1.dup(4) * MouseX.kr) }.play(s, c.index);

c.scope;

// note that scoping control rate buses shows block size interpolation (this is due to the
// fact that ScopeOut.kr doesn't work yet.)


external use: you can pass your own view in to add a stethoscope to it;


w = SCWindow.new("my own scope", Rect(20, 20, 400, 500));
w.view.decorator = FlowLayout(w.view.bounds);
c = Stethoscope.new(s, view:w.view);
w.onClose = { c.free }; // don't forget this
w.front;


