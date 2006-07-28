gui make a graphical user interface for an object

Anything can be gui-ed.

nil.gui;
"2".gui;
2.gui;
[1,nil,"tree"].gui;


Add yourself to a page (window)
(
 f = MultiPageLayout.new;
 nil.gui(f);
 "2".gui(f);
 2.gui(f);
 Object.dependantsDictionary.gui(f);
)

gui(parent,bounds)

parent -
 a View, FlowView, MultiPageLayout or SCWindow
bounds -
 Usually the bounds are not specified. The object's gui class first adds a container,
 lays its things inside that container and then shrinks the container to fit it.
 If you specify a bounds, the container will be set to that size and will stay that way.

You can put 'gui' style objects onto any 'normal' window just as you would any
view. 
(
w = SCWindow.new; 
w.front;

SFP.new.gui(w,Rect(100,200,100,300));

SFP.new.gui(w,Rect(2,2,500,200));
)


(
i = Instr([\test, \envtest], { arg freq, gate,envadsr;
 var out;
 out = EnvGen.ar(envadsr, gate, doneAction:0)
 * SinOsc.ar(freq);
 [out,out]
});
p = Patch(i);

// instead of using the .gui method of the Patch
// take all the args out and add them to a window
// yourself to format it any way you choose to

w = SCWindow.new(bounds:Rect(10,10,800,500));
w.front;

c = p.args.collect({ arg ag,i;
 ag.gui(w,Rect(0,50 * i,600,50)); 
});

)
c is now an array of gui objects: subclasses of ObjectGui

As per normal views, you can make them invisible:

c.at(0).visible = false;

c.at(0).visible = true;


Each class specifies its associated guiClass, a subclass of ObjectGui

Object-guiClass { ^ObjectGui }
 AbstractPlayer-guiClass { ^AbstractPlayerGui }
 Patch-guiClass { ^PatchGui }

For any class where it is appropriate, a separate gui class is implemented, usually inheriting much of its behavior from the gui class of the superclass.

//ControlSpecGui
ControlSpec.new.gui

see also [ObjectGui]

