
SCWindow			Cocoa user interface window	

Inherits from: Object

A class representing a user interface window in the Cocoa gui system on OSX. Note that for cross-platform compatibility it is preferable to use the GUI abstraction layer rather than use this class directly.

See also: SCView, GUI, SCScrollTopView, Pen

Creation / Class Methods

	*new(name, bounds, resizable, border, server, scroll)
	
		Creates a new SCWindow instance. You will need to call front (see below) on it before it will be visible.
		name - The name that will be displayed in the title bar. An instance of String or Symbol. The default is 'panel'.
		bounds - A Rect specifying the location and size of the window. The size does not include the title bar. N.B. Location is measured from the bottom left	of the screen. This is different from view location, which is measured from the upper left of the window (not including the title bar). The default is Rect(128, 64, 400, 400).
		resizable - A Boolean indicating whether this window can be resized by the user. The default is true.
		border - A Boolean indicating whether this window has a border. Borderless windows have no title bar and thus can only be closed in code. The default is true.
		server - This is a dummy argument which is here to provide compatibility with SwingOSC and has no effect. See GUI for more details.
		scroll - A Boolean indicating whether this window will add scrollers if its contents exceed its bounds. If this is set to true resize settings will be ignored for enclosed views. See SCScrollTopView. The default is false.
		
		w = SCWindow.new;
		w.front; // draw it and bring it to the front

	*allWindows
	
		Returns an Array of all open SCWindows.
	
	*closeAll
	
		Closes all open SCWindows.
		
	*screenBounds
	
		Returns a Rect indicating the bounds of the current screen (i.e. monitor resolution).
			

Instance Methods
	
	acceptsClickThrough_(boolean)
	acceptsClickThrough
		
		Set or return a Boolean indicating whether or not the window receives clicks when it is not front-most. The default is true.

	acceptsMouseOver_(boolean)
	acceptsMouseOver
		
		Set or return a Boolean indicating whether or not the window receives mouseOver events. The default is false.
	
	alpha_(alpha)
	
		Set the transparency of this window. alpha is a Float between 0.0 (invisible) and 1.0 (opaque).

	alwaysOnTop_(bool)
	alwaysOnTop
		
		Set or return a Boolean value indicating whether this window is always front-most. The default is false.
		
	bounds_(argBounds)
	bounds
		
		Set or return a Rect corresponding to the location and size of the window. The size does not include the title bar. N.B. Location is measured from the bottom left of the screen. This is different from view location, which is measured from the upper left of the window (not including the title bar). Note that because of the way Cocoa applications work, setting the bounds doesn't complete until the application finishes its current application event cycle. Thus, if you check the bounds in the same chunk of code, the SCWindow will not yet return the updated values.
		
		(
		w = SCWindow.new("test");
		w.front;
		w.bounds = Rect(50, 50, 50, 50);
		w.bounds.postln; // still the old bounds
		{ w.bounds.postln; nil }.defer(0.1); // next application event cycle
		)
		
	close
	
		Closes this window.
		
	drawHook_(function)
	drawHook
		
		Set or return a drawing Function. See Pen and SCUserView for more information.
		
	front
	
		Display this window and bring it to the front.		
	
	fullScreen
	endFullScreen
		
		Puts the window in or out of full screen mode. Putting a window into fullScreen mode may change its bounds.
		
		(
		w = SCWindow.new;
		w.front;
		w.fullScreen;
		AppClock.sched(2, {w.endFullScreen});
		AppClock.sched(3, {w.close});
		)
	
	isClosed
	
		Returns a Boolean indicating whether this window has been closed.
		
	minimize
	
		Minimize this window to the dock.
		
	name_(argName)
	name
		
		Set or return a String corresponding to the text in this window's title bar.
		
	onClose_(val)
	onClose
		
		Set or return a Function to be evaluated when the window is closed.	
	
	refresh
	
		Force this window and its contents to redraw. This is sometimes necessary in order to update drawing.
		
	setInnerExtent(width,height)
	
		Changes the size of this window while keeping the top left corner fixed. This is the usual desired behavior, as by default Cocoa uses a flipped coordinate system.
	
	userCanClose_(bool)
	userCanClose
		
		Set or return a Boolean value indicating whether the user can close this window by clicking on its close button. The default is true.
		
	view
	asView
	
		Returns this window's top level view, which contains all of its other views. This will be an instance of SCTopView or SCScrollTopView depending on the value passed to the scroll argument when the window was created. See *new above.
				

Examples


//how to add views
(
var w;
w = SCWindow("my name is... panel", Rect(128, 64, 340, 360));

32.do({ arg i;
	b = SCButton(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
	b.states = [["Start "++i, Color.black, Color.rand],
		["Stop "++i, Color.white, Color.red]];
});
w.front;
)

// using a decorator on this window's top view
(
var w;
w = SCWindow("my name is... panel", Rect(128, 64, 340, 360));

w.view.decorator = FlowLayout(w.view.bounds);
w.view.background = Color(0.6,0.8,0.8);
32.do({ arg i;
	b = SCButton(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
	b.states = [["Start "++i, Color.black, Color.rand],
		["Stop "++i, Color.white, Color.red]];
});

w.front;
)

// setting bounds
(
x = SCWindow.new;
x.front;
)

x.bounds_(Rect(10,10,100,30));
x.close;

// borderless windows
w = SCWindow.new(border:false).front; // can't be manually closed
w.close; // so close it in code

// onClose
(
x = SCWindow.new.front;
x.alpha = 0.8;
x.onClose_({ y = Synth.new(\default) }); //close the window and the synth plays
)
x.close;
y.free;

// a window with scrollers
(
w = SCWindow(scroll: true); // you must set this when the window is created
c = SC2DSlider(w, Rect(0, 0, 1500, 300));
d = SCSlider(w, Rect(0, 310, 20, 300));
c.background = Color.grey.alpha = 0.6;
d.background = Color.grey.alpha = 0.6;
w.front;
)


