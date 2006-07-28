SCMultiSliderView


isFilled = true
looks like a candlestick graph
(
//use as table
var size;
size = 350 / 6;
a = SCWindow("test", Rect(200 , 450, 450, 150));
a.view.decorator = FlowLayout(a.view.bounds);
b = SCMultiSliderView(a, Rect(0, 0, 350, 100));

c = Array.new;
size.do({arg i;
 c = c.add(0.01);
 });
c = c.reverse;
b.value_(c);

b.isFilled_(true);

// width in pixels of each stick 
b.indexThumbSize_(2.0);
// spacing on the value axis
b.gap_(4);

a.front;
)


flip by 90 degree
(
b.indexIsHorizontal_(false);

a.bounds_(Rect(200 , 450, 150, 430));
b.bounds_( Rect(10, 0, 100, 390));

b.background_(Color.black);
b.strokeColor_(Color.white);
b.fillColor_(Color.white);

b.gap = 1;

a.front;
)


isFilled = false
individual squares for each point
(
//use as multislider
var size;
size = 12;
a = SCWindow("test", Rect(200 , 450, 10 + (size * 17), 10 + (size * 17)));
a.view.decorator = FlowLayout(a.view.bounds);
b = SCMultiSliderView(a, Rect(0, 0, size * 17, size * 17));
b.action = {arg xb; ("index: " ++ xb.index ++" value: " ++ xb.currentvalue).postln};

c = Array.new;
size.do({arg i;
 c = c.add(i/size);
});
b.value_(c);

b.isFilled = false;

b.xOffset_(5);
b.thumbSize_(12.0);

// value axis size of each blip in pixels
b.valueThumbSize_(15.0);
// index axis size of each blip in pixels
b.indexThumbSize_( b.bounds.width / c.size );
b.gap = 0;

b.strokeColor_(Color.blue);
b.fillColor_(Color.blue);

a.front;
)

read only mode
(
b.readOnly = true;
// show an area as selected, used like a cursor
b.showIndex = true;
// move the selection index
b.index = 4;
// 1 item wide
b.selectionSize = 1;

)

b.index;
b.selectionSize;

(
//use it as sequencer
b.setProperty(\showIndex, true);

r = Routine({
 var j = 0;
 20.do({ arg i;
 0.1.wait;
 b.index_(j);
 if (j < 11 ,{j = j + 1},{j = 0});
 });
 0.1.wait;
 20.do({ arg i;
 [0.1,0.2].choose.wait;
 b.index_(b.size.rand);
 });
});
AppClock.play(r);

)
Note: this forces the entire view to redraw at each step and will spend a lot of CPU.

drawLines
(
//use as multislider II with lines
var size;
size = 12;
a = SCWindow("test", Rect(200 , 450, 450, 150));
a.view.decorator = FlowLayout(a.view.bounds);
b = SCMultiSliderView(a, Rect(0, 0, size * 17, 50));
a.view.decorator.nextLine;
//e = SCDragBoth(a , Rect(0, 0, size * 17, 50));
e = SCMultiSliderView(a, Rect(0, 0, size * 17, 50));
c = Array.new;
size.do({arg i;
 c = c.add(i/size);
});
b.value_(c);

b.xOffset_(18);
b.thumbSize_(1);
b.strokeColor_(Color.blue);
b.drawLines_(true);
b.drawRects_(true);
b.indexThumbSize_(1);
b.valueThumbSize_(1);

a.front;
)
c = Array.newClear(12);
b.getProperty(\referenceValues, Array.newClear(12));
c.size;



(
//press shift to extend the selection
//use as waveView: scrubbing over the view returns index
//if showIndex(false) the view is not refreshed (faster);
//otherwise you can make a selection with shift - drag.
var size, file, maxval, minval;
size = 640;
a = SCWindow("test", Rect(200 , 140, 650, 150));
a.view.decorator = FlowLayout(a.view.bounds);
b = SCMultiSliderView(a, Rect(0, 0, size, 50));
b.readOnly_(true);
a.view.decorator.nextLine;



d = Array.new;
c = FloatArray.newClear(65493);

e = SCSlider( a, Rect(0, 0, size, 12));
e.action = {arg ex; b.setProperty(\xOffset, (ex.value * 4) + 1 )};

file = SoundFile.new;
file.openRead("sounds/a11wlk01.wav");
file.numFrames.postln;
file.readData(c);
//file.inspect;
file.close;
minval = 0;
maxval = 0;
f = Array.new;
d = Array.new;
c.do({arg fi, i;
 if(fi < minval, {minval = fi});
 if(fi > maxval, {maxval = fi});

 //f.postln;
 if(i % 256 == 0,{
 d = d.add((1 + maxval ) * 0.5 );
 f = f.add((1 + minval ) * 0.5 );
 
 minval = 0;
 maxval = 0;
 });
});

b.reference_(d); //this is used to draw the upper part of the table
b.value_(f);

e = SCSlider( a, Rect(0, 0, size, 12));
e.action = {arg ex; b.setProperty(\startIndex, ex.value *f.size )};

//b.enabled_(false);
b.action = {arg xb; ("index: " ++ xb.index).postln};
b.drawLines_(true);
b.drawRects_(false);
b.isFilled_(true);
b.selectionSize_(10);
b.index_(10);
b.thumbSize_(1); 
b.gap_(0);
b.colors_(Color.black, Color.blue(1.0,1.0));
b.showIndex_(true);
a.front;

)



the "index" is also the "selection"
setting showIndex = true will allow selections.
shift click and drag will select an area.
setting selectionSize will set that selection area.
this dispay may also be used to look like an index as in the above sequencer example.
(
var size;
size = 12;
a = SCWindow("test", Rect(200 , 450, 10 + (size * 17), 10 + (size * 17)));
a.view.decorator = FlowLayout(a.view.bounds);
b = SCMultiSliderView(a, Rect(0, 0, size * 17, size * 17));
b.action = { arg xb; ("index: " ++ xb.index ++" value: " ++ xb.currentvalue).postln};

c = Array.new;
size.do({ arg i;
 c = c.add(i/size);
});
b.value_(c);

b.xOffset_(5);
b.thumbSize_(12.0);
b.strokeColor_(Color.blue);
b.fillColor_(Color.blue);

b.drawLines(false);

b.showIndex = true;
b.index_(4);
a.front;

)

// this means the x-dimension size in pixels
b.indexThumbSize = 40

// not the selection size 

// value pixels, the y-dimension
b.valueThumbSize = 100

