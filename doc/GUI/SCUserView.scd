SCUserView user-definable view

superclass: SCView

SCUserView is a user-definable View intended mainly for use with Pen and drawHooks.

See also: [SCWindow], [Pen], [Color], and [String]

keyDownFunc_

Set the function which should be evaluated if the view is in focus and a key is pressed. This function will be passed four arguments: the View, the key pressed as a Char, modifier keys (shift, alt, etc.), and the unicode value. See [SCView] for more details.

 (
 // select the window, type something and watch the post window
 w = SCWindow.new("select this window and type something");
 c = SCUserView(w,w.view.bounds);
 c.keyDownFunc = { arg view,char,modifiers,unicode;
 [char, modifiers, unicode].postln;
 c.drawFunc = {
 char.asString.drawAtPoint(180@150, Font("Gadget", 70), Color.blue(0.3, 0.5))
 };
 w.refresh;
 };
 w.front; c.focus;
 )

drawFunc_

Set the function which should be evaluated if the view is refreshed. This happens every time the whole window is refreshed (manually by calling SCWindow-refresh or e.g. by selecting the view or resizing the window).
 
 (
 var func;
 
 func = {|me|
 Pen.use{
 // clipping into the boundingbox
 Pen.moveTo((me.bounds.left)@(me.bounds.top));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@0));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@me.bounds.height));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (0@me.bounds.height));
 Pen.lineTo((me.bounds.left)@(me.bounds.top));
 Pen.clip;
 
 // draw background
 Color.gray(0.5).set;
 Pen.moveTo((me.bounds.left)@(me.bounds.top));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@0));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@me.bounds.height));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (0@me.bounds.height));
 Pen.lineTo((me.bounds.left)@(me.bounds.top));
 Pen.fill; 

 Pen.translate(100, 100);
 10.do{
 Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
 Pen.addArc((400.exprand(2))@(100.rand), rrand(10, 100), 2pi.rand, pi);
 Pen.perform([\stroke, \fill].choose);
 }
 }
 };

 w = SCWindow.new("DrawFunc Examples").front;
 w.view.background_(Color.white);
 3.do{|i|
 v = SCUserView(w, Rect(20+(i*120), 100, 100, 100));
 v.drawFunc = func;
 };
 w.refresh;
 )

 
mouseBeginTrackFunc_

Set the function which should be evaluated if the mouse is at the beginning of tracking (mouse-down). This function will be passed four arguments: theView, x coordinate, y coordinate, and keyboard modifiers.

mouseTrackFunc_

Set the function which should be evaluated if the mouse is tracked. This function will be passed four arguments: theView, x coordinate, y coordinate, and keyboard modifiers.

mouseEndTrackFunc_

Set the function which should be evaluated if the mouse is at the end of tracking (mouse-up). This function will be passed four arguments: theView, x coordinate, y coordinate, and keyboard modifiers.
 
 (
 var drawFunc, beginTrackFunc, endTrackFunc, trackFunc, sat = 0, absX;
 
 drawFunc = {|me|
 Pen.use{
 // clipping into the boundingbox
 Pen.moveTo((me.bounds.left)@(me.bounds.top));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@0));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@me.bounds.height));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (0@me.bounds.height));
 Pen.lineTo((me.bounds.left)@(me.bounds.top));
 Pen.clip;
 
 // draw background
 Color.gray(sat).set;
 Pen.moveTo((me.bounds.left)@(me.bounds.top));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@0));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (me.bounds.width@me.bounds.height));
 Pen.lineTo(((me.bounds.left)@(me.bounds.top))
 + (0@me.bounds.height));
 Pen.lineTo((me.bounds.left)@(me.bounds.top));
 Pen.fill; 

 Pen.translate(100, 100);
 10.do{
 Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
 Pen.addArc((400.exprand(2))@(100.rand), rrand(10, 100), 2pi.rand, pi);
 Pen.perform([\stroke, \fill].choose);
 }
 }
 };
 beginTrackFunc = {|me, x, y, mod|
 absX = x;
 postf("begin path: x=%\n",absX);
 };
 endTrackFunc = {|me, x, y, mod|
 postf("end path: (absX-x)=%\n", (absX-x))
 };
 trackFunc = {|me, x, y, mod|
 sat = ((absX-x)/100);
 me.refresh;
 };

 w = SCWindow.new.front;
 w.view.background_(Color.white);
 3.do{|i|
 v = SCUserView(w, Rect(20+(i*120), 100, 100, 100));
 //v.background_(Color.white); // not affecting anything...
 v.drawFunc = drawFunc;
 v.mouseBeginTrackFunc = beginTrackFunc;
 v.mouseEndTrackFunc = endTrackFunc;
 v.mouseTrackFunc = trackFunc;
 };
 w.refresh;
 )
 
// draw on the view

 (
 var w, txt, tmppoints, all;
 tmppoints = [];
 
 w = SCWindow("draw on me", Rect(128, 64, 340, 360));
 w.drawHook_{
 Pen.use { 
 Pen.width = 1;
 Pen.beginPath;
 
 tmppoints.do{ |p, i|
 if(i == 0){
 Pen.moveTo(p);
 }{
 Pen.lineTo(p);
 }
 };
 all.do{|points|
 points.do{|p, i|
 if(i == 0){
 Pen.moveTo(p);
 }{
 Pen.lineTo(p);
 }
 };
 };
 Pen.stroke;
 };
 };
 v = SCUserView(w,Rect(0, 0, 340, 360))
 .mouseTrackFunc_({|v,x,y|
 tmppoints = tmppoints.add(x@y);
 w.refresh;
 })
 .mouseEndTrackFunc_({|v,x,y|
 all = all.add(tmppoints.copy);
 tmppoints = [];
 w.refresh;
 });
 
 w.front;
 )