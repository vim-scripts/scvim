FlowView
superclass: SCLayoutView

an SCCompositeView with a FlowLayout inside of it.

In one respect this is simply a lazy contraction of this :

w = SCWindow.new;
w.view.decorator = FlowLayout.new( w.bounds );
w.front;

crucial style gui objects and normal sc views can easily coexist here.

FlowView(parent,bounds)



(
// makes a window automatically
f = FlowView.new;

//lazy crucial gui objects work
ActionButton(f,"a");

// normal sc views are flowed
SCSlider(f,Rect(0,0,100,100));

// flow within a flow
g = f.flow({ arg g;
 ActionButton(g,"a");
 SCSlider(g,Rect(0,0,100,100)).backColor_(Color.rand);
}).background_(Color.black);
 // shrinks to fit the contents afterwards

// rather than this : f.decorator.nextLine 
// talk to the FlowView
f.startRow;
// it will insert a StartRow object as a pseudo-view,
// this will keep the flow as you specified it for views that follow it :
ActionButton(f,"next line");
// even after you resize a parent view etc.

)





// tests
(
FlowView.new.flow({ arg f;
// b = ActionButton(f,"hi",minWidth:140)
}).background_(Color.grey)

)
(
FlowView.new.flow({ arg f;
 b = ActionButton(f,"hi",minWidth:140);
}).background_(Color.grey)

)
(
FlowView.new.flow({ arg f;
 b = SCSlider(f,Rect(0,0,100,100));
}).background_(Color.grey)

)
(
FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 //b = ActionButton(f,"hi",minWidth:140)
 }).background_(Color.white)
}).background_(Color.grey)

)
(

FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 b = ActionButton(f,"hi",minWidth:140)
 }).background_(Color.white)
}).background_(Color.grey)

)

(

FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
 b = ActionButton(f,"hi",minWidth:140);
 }).background_(Color.white)
}).background_(Color.grey)


)

(

FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
 b = ActionButton(f,"hi",minWidth:140);
 }).background_(Color.white)
}).background_(Color.grey)


)
(

FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 b = ActionButton(f,"hi",minWidth:140);
 f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
 }).background_(Color.white)
}).background_(Color.grey)

)

(

FlowView.new.flow({ arg f;
 g = f;
 f.flow({ arg f;
 b = SCSlider(f,Rect(0,0,140,20));
 f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
 }).background_(Color.white)
}).background_(Color.grey)


)


(

FlowView.new.flow({ arg f;
 b = SCSlider(f,Rect(0,0,140,20));
 f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
}).background_(Color.grey)


)


(

FlowView.new.flow({ arg f;
 g = f;
 w = f.flow({ arg f;
 b = f.flow({ arg f;
 ActionButton(f,"hello",minWidth:100);
 }).background_(Color.blue);
 ActionButton(f,"hi",minWidth:140);
 }).background_(Color.white)
}).background_(Color.grey)

)

b.remove(true);
w.resizeToFit(true,true);


// add something big back in
ActionButton(w,"i'm back",minWidth: 200);
//its messed up, outside of the bounds
w.resizeToFit(true,true);

