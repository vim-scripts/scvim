
SCEnvelopeView



value_([times,values])
	where times and values are all 0..1

value
	[times,values]
	where times and values are all 0..1

action
	function is passed the view

index
	the current or last moved node

drawRect_(boolean)
	set wether to show the points or not

drawLines_(boolean)
	draw lines between the point

setThumbSize(index, size)
	set the size of a point for the specified index, if the index is -1 set the size for all points

thumbSize_(size)
	set the size of all points

setThumbWidth(index, width)	
	set the width of a point for the specified index, if the index is -1 set the width for all points
	
thumbWidth_( width)	
	set the width of all points

setThumbHeight(index, heigth)	
	set the height of a point for the specified index, if the index is -1 set the height for all points

thumbHeight_(heigth)	
	set the height of all points

setEditable(index, boolean)
	makes a specified point unmovable
		
editable_(boolean)
	makes all points unmovable

selectionColor_(color)	
	set the color of the point when selected

setFillColor(index, color)	
	set the point color
		
fillColor_(color)	
	set the color for all points
	
setString(index, string)
	give a point a string
	
connect_(index, arrayofpoints)
	connect a point to others and do not use the standart connection scheme



	
use as envelope view
(
//use shift-click to keep a node selected
a = SCWindow("envelope", Rect(200 , 450, 250, 100));
a.view.decorator = FlowLayout(a.view.bounds);

b = SCEnvelopeView(a, Rect(0, 0, 230, 80))
	.drawLines_(true)
	.selectionColor_(Color.red)
	.drawRects_(true)
	.resize_(5)
	.action_({arg b; [b.index,b.value].postln})
	.thumbSize_(5)
	.value_([[0.0, 0.1, 0.5, 1.0],[0.1,1.0,0.8,0.0]]);

a.front;
)
(
//make the first point unmoveable
b.setEditable(0,false);
)

(
//use shift click to select/unselect the points
a = SCWindow("test", Rect(200 , 450, 450, 150));
a.view.decorator = FlowLayout(a.view.bounds);

b = SCEnvelopeView(a, Rect(0, 0, 350, 100))
	.thumbSize_(5)
	.drawLines_(true)
	.fillColor_(Color.green)
	.selectionColor_(Color.red)
	.drawRects_(true)
	.value_([(0.0, 0.1 .. 1.0), (0.0, 0.1 .. 1.0)])
	.setEditable(0,false);

a.front;
)
(
r = Routine({
	var j = 0;
	20.do({ arg i;
	b.select((b.size -1).rand.abs);

	0.1.wait;
	b.x_(1.0.rand.abs);
	b.y_(1.0.rand.abs);
	});
	b.select(-1);

	});
	AppClock.play(r);
)	

c = b.xvalues;




//show boxes with a string in it:
(
a = SCWindow("text-boxes", Rect(200 , 450, 450, 450));
a.view.decorator = FlowLayout(a.view.bounds);

b = SCEnvelopeView(a, Rect(0, 0, 440, 440))
	.thumbWidth_(60.0)
	.thumbHeight_(15.0)
	.drawLines_(true)
	.drawRects_(true)
	.selectionColor_(Color.red)
	.value_([[0.1, 0.4, 0.5, 0.3], [0.1, 0.2, 0.9, 0.7]]);
//b.setStatic(0,true);
4.do({arg i;
	b.setString(i, ["this", "is", "so much", "fun"].at(i));
	b.setFillColor(i,[Color.yellow, Color.white, Color.green].choose);
});
a.front;
)


the text objects can be connected:
(
b.connect(3, [2.0,0.0,1.0]);
b.connect(0,[2.0,3.0,1.0]);
b.drawLines_(true);
)


