
RelativeToParent

A decorator for use with SCCompositeView
it causes the coordinate system of children placed

Normally the coordinate system is the same of that as the parent,
not relative to the parent. ie. 0,0 is not the top left corner inside of the parent)
as you might expect.
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(50,0,300,300));

a = SC2DSlider(c,Rect(0,0,100,100)); 
b = SC2DSlider(c,Rect(100,100,100,100));

c.background = Gradient(Color.rand,Color.rand);

w.front;

)

the decorator fixes that for you
(
w = SCWindow.new;

c = SCCompositeView(w,Rect(50,0,300,300));
c.decorator = RelativeToParent( c.bounds );

a = SC2DSlider(c,Rect(0,0,100,100)); 
b = SC2DSlider(c,Rect(100,100,100,100));

c.background = Gradient(Color.rand,Color.rand);

w.front;

)

// this doesn't work yet though
c.bounds = c.bounds.moveBy(50,50);


development note:

what is needed is to inform the decorator that the parentBoundsDidChange
and replace all children.
the same thing needs to happen when a child is removed (if the decorator was a flow layout).




