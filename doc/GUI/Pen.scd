Pen draw on an SCWindow

superclass: Object

A class which allows you to draw on a [SCWindow]. It has no instance methods.

The following methods must be called within an SCWindow-drawHook or a SCUserView-drawFunc function, and will only be visible once the window or the view is refreshed. Each call to SCWindow-refresh SCUserView-refresh will 'overwrite' all previous drawing by executing the currently defined function.

See also: [SCWindow], [SCUserView], [Color], and [String]

Drawing Methods

The following methods define paths. You will need to call *stroke or *fill to actually draw them.

 *moveTo (point)
 Move the Pen to point. point is an instance of [Point].
 
 *lineTo (point)
 Draw a line (define a path) from the current position to point. point is an instance of [Point].
 
 *line (p1, p2)
 Draw a line (define a path) from p1 to p2. Current position will be p2. p1 and p2 are instances of [Point].

// *curveTo(point, cpoint1, cpoint2)
 draws an interpolated curve from the current position to point. 
cpoint1, cpoint2 are help-points determining the curves curvature.
 (Splines, B-Splines, Nurbs?)
 Unfortunately not working for now...

// *quadCurveTo(point, cpoint1)
 draws an interpolated curve from the current position to point. 
cpoint1 is a help-point determining the curves curvature.
 Unfortunately not working for now...

 *addArc(center, radius, startAngle, arcAngle)
Draw an arc around the [Point]center, at radius number of pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Pen.translate(100, 100);
 10.do{
 Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
 Pen.addArc((100.rand)@(100.rand), rrand(10, 100), 2pi.rand, pi);
 Pen.perform([\stroke, \fill].choose);
 }
 };
 w.refresh;
 )

 *addWedge(center, radius, startAngle, arcAngle)
Draw a wedge around the [Point]center, at radius number of pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Pen.translate(100, 100);
 10.do{
 Color.blue(rrand(0.0, 1), rrand(0.0, 0.5)).set;
 Pen.addWedge((100.rand)@(100.rand), rrand(10, 100), 2pi.rand, 2pi.rand);
 Pen.perform([\stroke, \fill].choose);
 }
 };
 w.refresh;
 )

 *addAnnularWedge (center, innerRadius, outerRadius, startAngle, arcAngle)
Draw an annular wedge around the [Point]center, from innerRadius to outerRadius in pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Pen.translate(100, 100);
 1000.do{
 Color.green(rrand(0.0, 1), rrand(0.0, 0.5)).set;
 Pen.addAnnularWedge(
 (100.rand)@(100.rand), 
 rrand(10, 50), 
 rrand(51, 100), 
 2pi.rand, 
 2pi.rand
 );
 Pen.perform([\stroke, \fill].choose);
 }
 };
 w.refresh;
 )

// *addRect(rect)
 adds a rectangle to the drawing; 
Unfortunately not working for now...

*stroke
 outline the previous defined path. 
 
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.red.set;
 Pen.moveTo(200@100);
 
 Pen.lineTo(250@200);
 Pen.lineTo(300@200);
 Pen.lineTo(200@250);
 Pen.lineTo(100@200);
 Pen.lineTo(150@200);
 Pen.lineTo(200@100);

 Pen.stroke
 };
 w.refresh;
 )
 
*fill
 fill the previous defined path. 
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.red.set;
 Pen.moveTo(200@100);

 Pen.lineTo(250@200);
 Pen.lineTo(300@200);
 Pen.lineTo(200@250);
 Pen.lineTo(100@200);
 Pen.lineTo(150@200);
 Pen.lineTo(200@100);

 Pen.fill
 };
 w.refresh;
 )
 
These methods do require separate calls to *stroke or *fill.

 *strokeRect(rect)
 Strokes a rectangle into the window. rect is an instance of [Rect].
 
(
 w = SCWindow("strokeRect", Rect(128, 64, 360, 360));
 w.drawHook = {
 var h, v, r;
 v = h = 300.0;
 r = Rect(100, 100, 160, 80);
 Color.black.alpha_(0.8).set;
 Pen.strokeRect(r);
 };
 w.front;
 )

 *fillRect(rect)
 Draws a filled rectangle into the window. rect is an instance of [Rect].

 *strokeOval(rect)
 Strokes an oval into the window. rect is an instance of [Rect].
 
(
 w = SCWindow("strokeOval", Rect(128, 64, 360, 360));
 w.drawHook = {
 var h, v, r;
 v = h = 300.0;
 r = Rect(100, 100, 160, 80);
 Color.black.alpha_(0.8).set;
 Pen.strokeOval(r);
 };
 w.front;
 )

 *fillOval(rect)
 Draws a filled oval into the window. rect is an instance of [Rect].
 
// *drawAquaButton(rect, type=0, down=false, on=false)

Graphics State Methods

The following commands transform the graphics state, i.e. they effect all subsequent drawing commands. These transformations are cumulative, i.e. each command applies to the previous graphics state, not the original one.

 *translate(x=0, y=0)
 translate the coordinate system to have its origin moved by x,y

 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.blue.set;
 Pen.translate(200,100);
 
 // 0@0 is now 200@100
 Pen.moveTo(0@0);

 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);

 Pen.stroke
 };
 w.refresh;
 )
 
 // cumulative translations 
 (
 w = SCWindow.new.front;
 w.view.background_(Color.clear);
 w.drawHook = {
 // set the Color
 Color.black.set;
 // draw 35 lines
 35.do {
 Pen.moveTo(0@0);
 Pen.lineTo(50@350);
 // shift 10 to the right every time
 Pen.translate(10, 0);
 Pen.stroke
 }
 };
 w.refresh;
 )

 *scale (x=0, y=0)
Scales subsequent drawing. x and y are scaling factors (i.e. 1 is normal, 2 is double size, etc.).
 
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.green.set;
 Pen.translate(200,100);
 Pen.scale(0.5, 2);
 // you have to set a starting point...
 Pen.moveTo(0@0);

 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);

 Pen.stroke
 };
 w.refresh;
 )

 *skew (x=0, y=0)
Skews subsequent drawing. x and y are skewing factors (i.e. 1 is normal).
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.green(0.5, 0.8).set;
 Pen.translate(200,100);
 Pen.skew(0.5, 0.2);
 // you have to set a starting point...
 Pen.moveTo(0@0);

 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);

 Pen.fill
 };
 w.refresh;
 )

 *rotate (angle=0, x=0, y=0)
Rotates subsequent drawing around the Point x@y by the amount angle in radians [0..2pi].
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 c = 0;
 w.drawHook = {
 Pen.translate(220, 200);
 
 10.do({
 Pen.translate(0,10);
 // set the Color for all "real" drawing
 Color.hsv(c.fold(0, 1), 1, 1, 0.5).set;
 
 // you have to set a starting point...
 Pen.moveTo(0@0);
 
 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);
 
 Pen.fill;
 Pen.rotate(0.2pi);
 
 c = c + 0.1;
 });
 };
 w.refresh;
 )

 *matrix_ (array)
 transforms coordinate system.
 array = [a, b, c, d, x, y]
 a zoomX
 b shearingX
 c shearingY
 d zoomY
 x translateX
 y translateY
 (
 var controlWindow, w;
 var r, a, b, c, d, matrix = [1, 0, 0, 1, 10, 10];
 var sliders, spex, name;
 
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 
 // create a controller-window 
 controlWindow = SCWindow("matrix controls", Rect(400,200,350,120));
 controlWindow.front;
 
 // determine the rectangle to be drawn
 r = Rect.fromPoints(a = 0 @ 0, c = 180 @ 180);
 b = r.leftBottom;
 d = r.rightTop;
 
 // the drawHook
 w.drawHook = {
 Color.red.set;
 Pen.matrix = matrix;
 Pen.width = 5;
 Pen.strokeRect(r);
 Pen.strokeOval(r);
 Color.blue.set;
 Pen.width = 0.1;
 Pen.line(a, c);
 Pen.line(b, d);
 Pen.stroke;
 
 "A".drawAtPoint(a - 6, Font("Helvetica-Bold", 12));
 "B".drawAtPoint(b - 6, Font("Helvetica-Bold", 12));
 "C".drawAtPoint(c - (0@6), Font("Helvetica-Bold", 12));
 "D".drawAtPoint(d - (0@6), Font("Helvetica-Bold", 12));
 
 "a matrix test".drawInRect(r.moveBy(50,50), Font("Helvetica", 10));
 };
 
 controlWindow.view.decorator = sliders = FlowLayout(controlWindow.view.bounds);
 spex = [
 [0, 2.0].asSpec,
 [0, 2.0].asSpec,
 [0, 2.0].asSpec,
 [0, 2.0].asSpec,
 [0, 200.0].asSpec,
 [0, 200.0].asSpec
 ];
 name = #[zoomX, shearingX, shearingY, zoomY, translateX, translateY];
 6.do { |i|
 EZSlider(controlWindow, 300 @ 14, name[i], spex[i], { |ez| var val;
 val = ez.value;
 [i, val.round(10e-4)].postln;
 matrix.put(i, val);
 w.refresh; // reevaluate drawHook function
 }, matrix[i]);
 sliders.nextLine;
 };
 w.refresh;
 )


 *width_(width=1)
 sets the width of the Pen for the whole stroke
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.blue(0.5, 0.5).set;
 Pen.translate(200,100);
 Pen.width = 10;
 // you have to set a starting point...
 Pen.moveTo(0@0);

 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);

 Pen.stroke
 };
 w.refresh;
 )

 *use (function)
 Draw function, and then revert to the previous graphics state. This allows you to make complex transformations of the graphics state without having to explicitly revert to get back to 'normal'.
 
 (
 // modified by an example of Stefan Wittwer
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 //paint origin
 Color.gray(0, 0.5).set;
 Pen.addArc(0@0, 20, 0, 2pi);
 Pen.fill;
 Pen.width = 10;

 Pen.use { // draw something complex...
 Pen.width = 0.5;
 Pen.translate(100,100);
 Color.blue.set;
 Pen.addArc(0@0, 10, 0, 2pi);
 Pen.fill;
 20.do{
 Pen.moveTo(0@0);
 Pen.lineTo(100@0);
 Color.red(0.8, rrand(0.7, 1)).set;
 Pen.stroke;
 Pen.skew(0, 0.1);
 };
 };
 
 // now go on with all params as before
 // translation, skewing, width, and color modifications do not apply
 Pen.line(10@120, 300@120);
 Pen.stroke;
 };
 w.refresh
 )

 *path(function)
 make a path, consisting of the drawing made in function.
Unfortunately not working for now... 
 (there's no Meta_Pen-endPath which currently is used in this method)

 *beginPath
Discard any previous path.
 
// incomplete arrow
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // set the Color
 Color.blue.set;
 Pen.translate(200,100);
 Pen.moveTo(0@0);

 Pen.lineTo(50@100);
 Pen.lineTo(100@100);
 
 // forget what we just drew
 Pen.beginPath;
 Pen.moveTo(100@100);
 Pen.lineTo(0@150);
 Pen.lineTo(-100@100);
 Pen.lineTo(-50@100);
 Pen.lineTo(0@0);

 Pen.stroke
 };
 w.refresh;
 )

 *clip
Use the previously defined path as a clipping path.
 
 (
 w = SCWindow.new.front;
 w.view.background_(Color.white);
 w.drawHook = {
 // outline the clipping path
 Pen.moveTo(110@110);
 Pen.lineTo(290@110);
 Pen.lineTo(290@240);
 Pen.lineTo(110@240);
 Pen.lineTo(110@110);
 // now clip
 Pen.clip;
 
 // everything else we draw is now clipped
 Color.yellow.set;
 Pen.fillRect(Rect(0,0,400,400));
 Color.red.set;
 Pen.moveTo(200@100);
 
 Pen.lineTo(250@200);
 Pen.lineTo(300@200);
 Pen.lineTo(200@250);
 Pen.lineTo(100@200);
 Pen.lineTo(150@200);
 
 Pen.fill;
 };
 w.refresh;
 )


Examples

(
// simple rotating and scaling
 w = SCWindow("Pen Rotation and Scaling", Rect(128, 64, 360, 360));
 w.drawHook = {
 var h, v;
 v = h = 300.0;
 Pen.use {
 // use the same rect for everything, just scale and rotate
 var r = Rect(0,0,200,80);
 Color.black.set;
 // offset all subsequent co-ordinates
 Pen.translate(80,20);
 Pen.fillRect(r);
 Color.red.set;
 // scale all subsequent co-ordinates
 Pen.scale(0.8, 0.8);
 Pen.translate(8,10);
 // rotate all subsequent co-ordinates
 Pen.rotate(0.1pi);
 Pen.fillRect(r);
 Color.blue.set;
 // lather, rinse, repeat
 Pen.scale(0.8, 0.8);
 Pen.rotate(0.1pi);
 Pen.width = 3;
 Pen.strokeRect(r);
 Color.yellow(1,0.5).set;
 Pen.scale(0.8, 0.8);
 Pen.rotate(0.1pi);
 Pen.translate(20,-20);
 Pen.fillOval(r);
 }
 };

 w.front;
)

// redraw at random interval
// different every time
(
var w, run = true;
w = SCWindow("my name is... panel", Rect(128, 64, 800, 800));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawHook = {
 Pen.use {
 Pen.width = 0.2;
 400.do {
 Pen.beginPath;
 Pen.moveTo(Point(10.rand * 80 + 40, 10.rand * 80 + 40));
 Pen.lineTo(Point(10.rand * 80 + 40, 10.rand * 80 + 40));
 Pen.stroke;
 };
 };
};

{ while { run } { w.refresh; 1.0.rand.wait } }.fork(AppClock)

)

(
var w, run = true;
w = SCWindow("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawHook = {
 Pen.use {
 Pen.width = 2;
 80.do {
 Pen.width = rrand(0,4) + 0.5;
 Pen.beginPath;
 Pen.moveTo(Point(800.rand, 500.rand));
 Pen.lineTo(Point(800.rand, 500.rand));
 Pen.stroke;
 };
 };
};

{ while { run } { w.refresh; 1.0.rand.wait } }.fork(AppClock)

)

// Animation

// Uses random seed to 'store' data
// By reseting the seed each time the same random values and shapes are generated for each 'frame'
// These can then be subjected to cumulative rotation, etc., by simply incrementing the phase var.
(
// By James McCartney
var w, h = 700, v = 700, seed, run = true, phase = 0;
w = SCWindow("wedge", Rect(40, 40, h, v), false);
w.view.background = Color.rand(0,0.3);
w.onClose = { run = false }; // stop the thread on close
w.front;
// store an initial seed value for the random generator
seed = Date.seed;
w.drawHook = {
 Pen.width = 2;
 Pen.use {
 // reset this thread's seed for a moment
 thisThread.randSeed = Date.seed;
 // now a slight chance of a new seed or background color
 if (0.006.coin) { seed = Date.seed; };
 if (0.02.coin) { w.view.background = Color.rand(0,0.3); };
 // either revert to the stored seed or set the new one
 thisThread.randSeed = seed;
 // the random values below will be the same each time if the seed has not changed
 // only the phase value has advanced
 Pen.translate(h/2, v/2);
 // rotate the whole image
 // negative random values rotate one direction, positive the other
 Pen.rotate(phase * 1.0.rand2);
 // scale the rotated y axis in a sine pattern
 Pen.scale(1, 0.3 * sin(phase * 1.0.rand2 + 2pi.rand) + 0.5 );
 // create a random number of annular wedges
 rrand(6,24).do {
 Color.rand(0.0,1.0).alpha_(rrand(0.1,0.7)).set;
 Pen.beginPath;
 Pen.addAnnularWedge(Point(0,0), a = rrand(60,300), a + 50.rand2, 2pi.rand 
 + (phase * 2.0.rand2), 2pi.rand);
 if (0.5.coin) {Pen.stroke}{Pen.fill};
 };
 };
};

// fork a thread to update 20 times a second, and advance the phase each time
{ while { run } { w.refresh; 0.05.wait; phase = phase + 0.01pi;} }.fork(AppClock)

)

(
var w, phase = 0, seed = Date.seed, run = true;
w = SCWindow("my name is... panel", Rect(128, 64, 800, 800));
w.view.background = Color.blue(0.4);
w.onClose = { run = false; };
w.front;
w.drawHook = {
 Pen.use {
 if (0.02.coin) { seed = Date.seed; };
 thisThread.randSeed = seed;
 Color.white.set;
 200.do {
 var a = 4.rand;
 var b = 24.rand;
 var r1 = 230 + (50 * a);
 var a1 = 2pi / 24 * b + phase;
 var r2 = 230 + (50 * (a + 1.rand2).fold(0,3));
 var a2 = 2pi / 24 * (b + (3.rand2)).wrap(0,23) + phase;
 Pen.width = 0.2 + 1.0.linrand;
 Pen.beginPath;
 Pen.moveTo(Polar(r1, a1).asPoint + Point(400,400));
 Pen.lineTo(Polar(r2, a2).asPoint + Point(400,400));
 Pen.stroke;
 };
 thisThread.randSeed = Date.seed;
 40.do {
 var a = 4.rand;
 var b = 24.rand;
 var r1 = 230 + (50 * a);
 var a1 = 2pi / 24 * b + phase;
 var r2 = 230 + (50 * (a + 1.rand2).fold(0,3));
 var a2 = 2pi / 24 * (b + (3.rand2)).wrap(0,23) + phase;
 Pen.width = 0.2 + 1.5.linrand;
 Pen.beginPath;
 Pen.moveTo(Polar(r1, a1).asPoint + Point(400,400));
 Pen.lineTo(Polar(r2, a2).asPoint + Point(400,400));
 Pen.stroke;
 };
 };
};

{ while { run } { w.refresh; 0.1.wait; phase = phase + (2pi/(20*24)) } }.fork(AppClock)

)


(
var w, h = 800, v = 600, seed = Date.seed, phase = 0, zoom = 0.7, zoomf = 1, run = true;
w = SCWindow("affines", Rect(40, 40, h, v));
w.view.background = Color.blue(0.4);
w.onClose = { run = false };
w.front;
w.drawHook = {
 thisThread.randSeed = Date.seed;
 if (0.0125.coin) { seed = Date.seed; phase = 0; zoom = 0.7; zoomf = exprand(1/1.01, 1.01); }
 { phase = phase + (2pi/80); zoom = zoom * zoomf; };
 thisThread.randSeed = seed;
 Pen.use {
 var p1 = Point(20.rand2 + (h/2), 20.rand2 + (v/2));
 var p2 = Point(20.rand2 + (h/2), 20.rand2 + (v/2));
 var xscales = { exprand(2** -0.1, 2**0.1) } ! 2;
 var yscales = { exprand(2** -0.1, 2**0.1) } ! 2;
 var xlates = { 8.rand2 } ! 2;
 var ylates = { 8.rand2 } ! 2;
 var rots = { 2pi.rand + phase } ! 2;
 var xform;
 xscales = (xscales ++ (1/xscales)) * 1;
 yscales = (yscales ++ (1/yscales)) * 1;
 xlates = xlates ++ xlates.neg;
 ylates = ylates ++ xlates.neg;
 rots = rots ++ rots.neg;
 xform = {|i| [xlates[i], ylates[i], rots[i], xscales[i], yscales[i]] } ! 4;
 Color.grey(1,0.5).set;
 Pen.width = 8.linrand + 1;
 Pen.translate(400, 400);
 Pen.scale(zoom, zoom);
 Pen.translate(-400, -400);
 1200.do {
 var p, rot, xlate, ylate, xscale, yscale;
 Pen.width = 8.linrand + 1;
 Pen.beginPath;
 #rot, xlate, ylate, xscale, yscale = xform.choose;
 Pen.translate(xlate, ylate);
 Pen.rotate(rot, h/2, v/2);
 Pen.scale(xscale, yscale);
 Pen.moveTo(p1);
 Pen.lineTo(p2);
 Pen.stroke;
 };
 };
};

{ while { run } { w.refresh; 0.05.wait; } }.fork(AppClock)

)


-------------------------------------------------------------------------------------------------------
NodeBox vs. SC3 (modified from a mailinglist-post of James McCartney)
-------------------------------------------------------------------------------------------------------
rect() Pen.strokeRect, Pen.fillRect
oval() Pen.strokeOval, Pen.fillOval
line() Pen.line -- or use Pen.moveTo, Pen.lineTo
arrow()
star()

beginpath() Pen.beginPath
moveto() Pen.moveTo
lineto() Pen.lineTo
curveto() not now
endpath() Pen.stroke, Pen.fill 
 (paths don't need to be stored as data because you can compose them functionally).
drawpath() Pen.stroke, Pen.fill
beginclip()
endclip()

transform() -- not needed since rotate lets you specify the center point.
translate() Pen.translate
rotate() Pen.rotate
scale() Pen.scale
skew() Pen.skew
push() Pen.push // private method???
pop() Pen.pop // private method???
reset() Pen.matrix = [0,0,0,0,0,0]

colormode() not necessary use hsv or rgb as needed. missing CMYK though. easy to add.
color() Color.hsv(h,s,v) or Color(r,g,b)
fill() color.setFill
nofill() use Pen.stroke or Pen.fill as needed.
stroke() color.setStroke
nostroke() use Pen.stroke or Pen.fill as needed.
strokewidth() Pen.width

font() Font(name, size)
fontsize() Font(name, size)
text() string.drawAtPoint
textpath() 
textwidth() string.bounds -- currently commented out but should work once reenabled.
textheight() string.bounds
textmetrics()
lineheight()
align() use string.drawCenteredIn, string.drawLeftJustIn, string.drawRightJustIn

image() not yet
imagesize() not yet

size() -- all of these are covered by other mechanisms in SC
var()
random()
choice()
grid()
open()
files()
autotext()