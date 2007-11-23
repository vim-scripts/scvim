
SCCompositeView

A view that contains other views.



grouping by background color
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(0,0,300,300));

a = SC2DSlider(c,Rect(0,0,100,100));	
b = SC2DSlider(c,Rect(100,100,100,100));

c.background = Gradient(Color.rand,Color.rand);

w.front;
)

Coordinates are the same as that for the window, not relative to the origin of the composite view (as in other gui frameworks).
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(50,0,300,300));

a = SC2DSlider(c,Rect(0,0,100,100));	
b = SC2DSlider(c,Rect(100,100,100,100));

c.background = Gradient(Color.rand,Color.rand);

w.front;
)


keydown bubbling

Note that the keyDown action is assigned to the composite view. If c and d do not have keyDown actions themselves, the event is passed to b, the parent.
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(0,0,500,500));

a = SC2DSlider(c,Rect(0,0,100,100));	
b = SC2DSlider(c,Rect(100,100,100,100));

w.front;

c.keyDownAction = {
	"keydown bubbled up to me".postln;
};

//d is on window w, not on composite view c
d = SC2DSlider(w,Rect(200,200,100,100));
)
click on the different views and hit keys on the keyboard.



decorators
	a 'decorator' object can be set to handle layout management. all views added to the composite view will now be placed by the decorator.

(
a = SCWindow.new;

b = SCCompositeView(a,Rect(0,0,500,500));
b.decorator = FlowLayout(b.bounds);

// adding views to b automatically use the decorator
// no need to use parent.decorator.place
c = SC2DSlider(b,Rect(0,0,100,100));	// size matters
d = SC2DSlider(b,Rect(0,0,100,100)); // origin doesn't

a.front;
)


hiding / swapping
	
(
a = SCWindow.new;
q = 3;

e = SCButton(a,Rect(0,0,160,20));

e.states = Array.fill(q,{ arg i;
	[i.asString,Color.black,Color.white]
});

e.action = { arg butt;
	p.visible = false;
	p = c.at(butt.value);
	p.visible = true;
};

c = Array.fill(q,{ arg i;
	b = SCCompositeView(a,Rect(0,25,300,300));
	b.decorator = FlowLayout(b.bounds);
	c = SC2DSlider(b,Rect(0,0,100,100));
	c.x = 1.0.rand;
	d = SC2DSlider(b,Rect(0,0,100,100));
	d.y = 1.0.rand;
	b.visible = false;
	b
});

p = c.at(0); // previous
p.visible = true; // show first one

a.front;

)

removing
(
	w = SCWindow.new;
	c = SCCompositeView(w,Rect(0,0,300,300));
	a = SC2DSlider(c,Rect(0,0,100,100));	
	b = SC2DSlider(c,Rect(100,100,100,100));
	c.background = Gradient(Color.rand,Color.rand);
	w.front;
)


a.remove;
c.refresh;


resize contraints
resize the window to see how the contents behave
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(0,0,300,300));
c.background = Gradient(Color.rand,Color.rand);

c.resize = 5; // elastic

a = SC2DSlider(c,Rect(0,0,100,100));	
a.resize = 1; // fixed

b = SC2DSlider(c,Rect(100,100,100,100));
b.resize = 2; // x elastic
b.setProperty(\minWidth,30); // up to a point
b.setProperty(\maxWidth,200);
w.front;

)
(bug: composite view should get limited by it's contents' limitations)


// resize behaviours
(
var a;
a = { |i|
	var w, b, x;
	i = i + 1;
	w = SCWindow("resize:"+i, Rect(10 + (i * 110), 300, 100, 80));
	b = w.view.bounds;
	x = SCCompositeView(w, w.view.bounds)
		.background_(Color.rand)
		.resize_(i);
	x.decorator = FlowLayout(x.bounds).gap_(0.0 @ 0.0);

	{
	var t;
	t = SCStaticText(x, Rect(0, 0, 40, 40))
		.background_(Color.rand)
	 	.resize_(i)
	 	.string_(i)
	 	.font_(Font("Helvetica", 26));
	}.dup;
	
	 w.front;
	 w.onClose = {a.do(_.close) };


} ! 9;
)



