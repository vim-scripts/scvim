
GUI Overview

The GUI class provides a means of writing cross platform GUI code. It serves as a black-box factory for different implementations of the GUI classes. Refer to the bottom of this document for a list of GUI classes.

Basic Usage

GUI classes are referred to by calling a class method on GUI. Here is an example of how a window is created and populated:

The GUI class has class methods for determining the current GUI kit and for switching the GUI kit (look at the help file for [SCWindow] to see how this is done directly in native cocoa GUI).

(
	var w, b;
	// GUI.window returns the window class for the current kit
	// ; hence GUI.window.new instantiates a new window
	w = GUI.window.new( "my name is... panel", Rect( 128, 64, 340, 360 ));

	w.view.decorator = FlowLayout( w.view.bounds );
	w.view.background = Color( 0.6, 0.8, 0.8 );

	32.do({ arg i;
		// the same is true for all other widgets
		// ; here GUI.button returns the button class for the current kit
		b = GUI.button.new( w, Rect( rrand( 20, 300 ), rrand( 20, 300 ), 75, 24 ));
		b.states = [[ "Start " ++ i, Color.black, Color.rand ],
				  [ "Stop " ++ i, Color.white, Color.red ]];
	});

	w.front;
)

Alternative syntax for making e.g. windows and buttons:

w = GUI(\window).new.front;
GUI(\slider).new(w, Rect(0,0,400, 20));

Switching and Referring to GUI Kits

As of this writing, two GUI kits are available through the GUI class: Cocoa (Mac OS X native) GUI and Swing (Java) GUI. Note that SwingOSC is not part of the default SuperCollider distribution, so you may have to install it separately.

You can switch the GUI kit by calling one of the following class methods:

GUI.cocoa;	// use cocoa in subsequent GUI creation procedures
GUI.swing;	// use swing in subsequent GUI creation procedures
			// NOTE: If you do not have SwingOSC installed, you get
			// a warning only, and do not switch; so you cannot
			// accidentally disable your (mac) gui system.
	
These methods return the new GUI kit implementation. The current implementation can be queried by calling

GUI.current;	// returns the current GUI kit implementation

The default GUI kit is cocoa. To store an implementation for later use, you can store the result of GUI.current. The implementation responds to GUI classes in the same way as the GUI class itself. Therefore:

(
	var w, b, kits;

	kits	= [ GUI.cocoa, GUI.swing ];

	2.do({ arg j;
		w = kits[ j ].window.new( "my name is... panel", Rect( 128 + (j * 400), 64, 340, 360 ));

		w.view.decorator = FlowLayout( w.view.bounds );
		w.view.background = Color( 0.6, 0.8, 0.8 );

		32.do({ arg i;
			b = kits[ j ].button.new( w, Rect( rrand( 20, 300 ), rrand( 20, 300 ), 75, 24 ));
			b.states = [[ "Start " ++ i, Color.black, Color.rand ],
					  [ "Stop " ++ i, Color.white, Color.red ]];

		});
		w.front;
	});
)

For persistency, you can store the identifier of the kit implementation and recall the kit through the class method fromID:

x = GUI.cocoa;
y = x.id;				// store the identifier of a kit implementation
y.postln;				// ; the id could be stored in a preferences file for example
GUI.swing;
// now switch back to the kit implementation with identifier y
GUI.fromID( y );
GUI.current.id.postln;	// --> cocoa



The *use and *useID methods allow you to temporarily switch the kit, so as to use it only for a dedicated block of statements:

GUI.cocoa;
GUI.useID( \swing, {Array.rand( 1000, 0.0, 1.0 ).plot });
GUI.current.id.postln;	// --> still cocoa


You can get a particular kit using the *get method. You can switch to a particular kit using the *set method:

x = GUI.get( \swing );	 // note: unlike *swing and *cocoa, this does not _switch_ the current kit!
GUI.current.id.postln;	 // --> still cocoa
GUI.set( x );			 // now we make SwingOSC the current kit
GUI.window.viewPalette;



List of Kit-specific GUI Classes

The following GUI classes have individual helpfiles. There are a number of undocumented GUI classes listed in [Undocumented-Classes].
Using the GUI class, each class is referred to by the original cocoa name, stripped of the prefix 'SC' and beginning with a lower case character (exceptions are indicated by red colour). Blue colour indicates optional classes not included in the default distribution.

GUI.window				[SCWindow]				[JSCWindow]			a frame that can contain gadgets
GUI.view					[SCView]					[JSCView]			base class ; drag-object and global keyboard management
GUI.compositeView			[SCCompositeView]			[JSCCompositeView]	container view for nesting layouts
GUI.hLayoutView			[SCHLayoutView]			[JSCHLayoutView]		container view with horizontal distribution of children
GUI.vLayoutView			[SCVLayoutView]			[JSCVLayoutView]		container view with vertical distribution of children
GUI.button				[SCButton]				[JSCButton]			a multiple state push button
GUI.popUpMenu			[SCPopUpMenu]			[JSCPopUpMenu]		a collapsed multiple choice button
GUI.slider					[SCSlider]					[JSCSlider]			a horizontal or vertical slider
GUI.rangeSlider			[SCRangeSlider]			[JSCRangeSlider]		horizontal interval slider
GUI.slider2D				[SC2DSlider]				[JSC2DSlider]			horizontally and vertically moveable slider
GUI.textField				[SCTextField]				[JSCTextField]			an editable one line text field
GUI.ezSlider				[EZSlider]					[JEZSlider]			a combo of slider, numberbox and label
GUI.ezNumber				[EZNumber]				[JEZNumber]			a combo of numberbox and label
GUI.listView				[SCListView]				[JSCListView]			a list of text items
GUI.staticText				[SCStaticText]				[JSCStaticText]			a text label
GUI.numberBox			[SCNumberBox]			[JSCNumberBox]		editable number field
GUI.dragSource			[SCDragSource]			[JSCDragSource]		object container acting as a source for drag-n-drop
GUI.dragSink				[SCDragSink]				[JSCDragSink]			object container acting as a target for drag-n-drop
GUI.dragBoth				[SCDragBoth]				[JSCDragBoth]			combination of DragSource and DragSink
GUI.stethoscope			[Stethoscope]				[JStethoscope]			oscilloscope tool
GUI.scopeView			[SCScope]				[JSCScope]			oscilloscope view
GUI.tabletView				[SCTabletView]			--- TODO ---			view for receiving graphic tablet data
GUI.tabletSlider2D			[SC2DTabletSlider]			--- TODO ---			2D slider with support for graphic tablet data
GUI.freqScope				[FreqScope]				[JFreqScope]			spectrum tool
GUI.freqScopeView			[SCFreqScope]				[JSCFreqScope]		spectrum view
GUI.multiSliderView			[SCMultiSliderView]			[JSCMultiSliderView]	array of sliders
GUI.envelopeView			[SCEnvelopeView]			[JSCEnvelopeView]		breakpoint envelope editor
GUI.userView				[SCUserView]				[JSCUserView]			view for user-defined drawing operations
GUI.soundFileView			[SCSoundFileView]			[JSCSoundFileView]	waveform view / editor for sound files
GUI.movieView			[SCMovieView]				[JSCMovieView]		canvas for movie (QuickTime) and image display
GUI.textView				[SCTextView]				[JSCTextView]			multiline text editor
GUI.quartzComposerView	[SCQuartzComposerView]	--- TODO ---			view for displaying QuartzComposer documents

GUI.dialog				[CocoaDialog]				[SwingDialog]			file selection dialog management

GUI.font					[Font]					[JFont]				a font typeface description
GUI.pen					[Pen]					[JPen]				custom drawing operations class

GUI.mouseX				[MouseX]					[JMouseX]			UGen for horizontal mouse coordinate
GUI.mouseY				[MouseY]					[JMouseY]			UGen for vertical mouse coordinate
GUI.mouseButton			[MouseButton]				[JMouseButton]		UGen for mouse button detection
GUI.keyState				[KeyState]					--- TODO ---			UGen for key press detection

GUI.speech				[Speech]					--- TODO ---			text-to-speech synthesis management


As you can see, code originally written for cocoa GUI can easily be converted to platform neutral code, by replacing the cocoa class names with the GUI factory spelling which can be done almost automatically. Note: to instantiate a GUI object, you must make explicit use of the new method:

w = SCWindow( "dada", Rect( 100, 100, 100, 100 )).front;    // OK (abbreviation)
w = SCWindow.new( "dada", Rect( 100, 100, 100, 100 )).front;  // OK (explicit new call)
w = GUI.window( "dada", Rect( 100, 100, 100, 100 )).front   // NOT working!
w = GUI.window.new( "dada", Rect( 100, 100, 100, 100 )).front; // OK


List of Kit-independant GUI Classes

These classes are not available through the GUI class but need to be used directly. They are platform neutral in themselves.

[Color]
[FlowLayout]		// currently no help file
[Document]		// cross-platform ??
[Gradient]			// currently no help file
[HiliteGradient]		// currently no help file


Inspectors

These classes use the current GUI kit implementation as returned by GUI.current . You usually do not instantiate them directly, but use one of the "Plus-GUI" methods described in the next paragraph.

[ObjectInspector]
[StringInspector]
[ClassInspector]
[FunctionDefInspector]
[MethodInspector]
[SlotInspector]
[FrameInspector]


Browsers

[ClassBrowser]


Accessing "Plus-GUI"methods

"Plus-GUI" methods are methods added to other classes such as String or Server that provide GUI functionality for those classes. These methods use the current GUI kit implementation as returned by GUI.current .

.inspect
	Examples for Inspectors:
		Server.default.inspect;
		Server.inspect;

.browse
	Examples for Browsers:
		UGen.browse;				// ClassBrowser
		SynthDescLib( \myLib ).read.browse;

.makeWindow
	Examples for Server:
		if( s.window.notNil, {s.window.close});
		s.makeWindow;
		s.scope;

.plot
	Examples for Plotting:
		see [ArrayedCollection], [Buffer], [Env], [Function], [Signal], [SoundFile], [Wavetable]

.scope
	Examples for Scoping
		see [Bus], [Function], [Server], [UGen]




Extending GUI Kits

GUI Kits can be extended with custom classes by using their respective .put methods:

GUI.get( \cocoa ).put( \myText, SCStaticText );
GUI.get( \swing ).put( \myText, JSCStaticText );

GUI.cocoa;
GUI.swing;
(
	w = GUI.window.new;
	GUI.myText.new( w, w.view.bounds.insetBy( 20, 20 )).string_( "schoko" ).background_( Color.red );
	w.front;
)

If you intend to add extensions from within your own classes upon class library initialization time, the preferred way is to do this in the startup process:

MyGUIExtension {
	*initClass {
		StartUp.add({
			var scheme;
			
			scheme = GUI.get( \cocoa );
			if( scheme.notNil, {scheme.put( \myText, SCStaticText )});
			scheme = GUI.get( \swing );
			if( scheme.notNil, {scheme.put( \myText, JSCStaticText )});
		});
	}
}


Additional GUI-related Documents

[resize]



last mod: 25-Apr-07


