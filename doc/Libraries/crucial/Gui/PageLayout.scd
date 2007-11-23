
PageLayout

A PageLayout is a window that manages the layout of views added to it.

You request a rectangle using layout.layRight(x,y)

the layout manager moves its internal cursor, wrapping to a new line, then to a new window as necessary.

Wraps to the next line
(
	var f;
	f=PageLayout.new("flow");
	
	504.do({ arg i;
		SCButton( f.window, f.layRight(30,30) )
			.states_([[i.asString,Color.black,Color.white]])
	});
	
	f.front;
)



Exceeding the bottom of the window wraps to a new window
(
	var f;
	f=PageLayout.new("flow");
	
	800.do({ arg i;
		var r;
		r= f.layRight(30,30); // obtain the rectangle first
						// in case we cascade to the next window
		SCButton( f.window, r )
			.states_([[i.asString,Color.black,Color.white]])
	});
	f.front;
)



The windows are treated as a group. When one closes, they all close.

.window
returns the current window being written to.

.layRight(x,y)
allocates space and returns a Rect of size (x,y)

.close
close all windows created by the PageLayout

.focus( index )
focus the view on the current window

.toFront
cascades all windows owned by PageLayout to front

.resizeToFit
resizes all windows to fit their contents, brings them all to front


(
	var f,sliders;
	f= PageLayout.new("a vaguely practical example");
	
	sliders=Array.fill(rrand(16,32),{ arg i;
		SCSlider( f.window, f.layRight(10, 150));
	});

	f.within( 50,150,{ arg subf;
		SCSlider( subf.window, subf.layDown( 30,30));
		SCSlider( subf.window, subf.layDown( 30,30));
		SCSlider( subf.window, subf.layDown( 30,30));
		SCSlider( subf.window, subf.layDown( 30,30));
	});
	
	f.resizeToFit;
	f.front;
)


//
//// layout within a layout
//(var f;
//	f=PageLayout.new("flow");
//	
//	30.rand.do({ arg i;
//		SliderView(f.win, f.layRight(80.rand,80.rand))
//	});
//	
//	// html joke, but useful
//	f.hr;
//	
//	// allocate space for a small layout within
//	// a verticle strip
//	f.within( 100,300,{ arg subLayout;
//		5.do({ arg i;
//			RangeView(subLayout.win, subLayout.layRight(100.rand,100.rand),"",0,1,0,1)
//		})
//	});
//	
//	// more sliders to the right of the strip
//	30.rand.do({ arg i;
//		SliderView(f.win, f.layRight(80.rand,80.rand))
//	});
//	
//	// continuing with a new section below
//	f.hr;
//	30.rand.do({ arg i;
//		SliderView(f.win, f.layRight(80.rand,80.rand))
//	});
//	
//)



A nice way to work with PageLayout is with [Sheet]



A PageLayout closes all of its windows when any of its windows is closed.
When a PageLayout closes, it sends the \didClose notification (see NotificationCenter).

	You can register to receive that notification:
	
	NotificationCenter.registerOneShot( f,\didClose, yourObject,{
			// stop the model from playing, clean house,
			// unregister a keydown etc.
	});
	
	This notification unregisters itself after being called.

removeOnClose(controller)
	this method adds the controller to the PageLayout's autoremove list. when the window closes, all items on the list will be sent the .remove message. this allows them to release any of their own dependancies, clean the poop out of their cage etc.

	eg:	Updater, ObjectGui (and subclasses), and NotificationRegistration

	

A Note about MVC/Dependencies

this is some under-the-hood stuff that you don't need to know about but might be interested in.

When a subclass of ObjectGui is added to a PageLayout it adds itself as a dependant on that layout. (ObjectGui::guify).
	
When PageLayout creates a SCWindow, it sets the window's onClose function to call PageLayout::release. this calls .release on all of the PageLayout's dependants.

The PageLayout calls .release on all the gui objects when the SCWindow closes. The gui objects release their dependancy on their models, thus severing the link between the two, allowing garbage collection.
	
	
		
in sc all Views must actually be on a window. when a View is created, it is added to a window, and the SCWindow keeps track of them in its view.children array.
	
this gui system has Gui classes that build and maintain an interface/gui on a specific model. They are Controllers, and they create actual View objects and control the interface between those and the Model.
		
these controllers add themselves as dependants on the models.
	eg. a PatchGui is a dependant of a Patch

when a SCWindow is shut, it calls .release on every normal view (StringView, RangeView etc.),	to cause each view to sever its dependency relationship with its model. Otherwise, even though the window is gone and the view is not visible ( and neither the window, the view or the model have any direct reference to each other), it will not get garbage collected because there is still an entry in the dependants dictionary (Object classvar) listing that view as a dependant on the model. there is still a link between model and view.
	
The Gui objects (controllers) need to know when the window closes so they can release themselves from the model.
	
	in Object::guify this happens:
	
		layout.removeOnClose(guiObject)
	
	
	
	
	
	


