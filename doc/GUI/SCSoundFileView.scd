
SCSoundFileView


(
w = SCWindow.new("soundfile test", Rect(200, 200, 800, 400));
a = SCSoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
f.inspect;

a.soundfile = f;
a.read(0, f.numFrames);
a.elasticMode = true;

a.timeCursorOn = true;
a.timeCursorColor = Color.red;
a.timeCursorPosition = 2050;
a.drawsWaveForm = true;
a.gridOn = true;
a.gridResolution = 0.2;

w.front;
)

// step by step examples:

(		// make a simple SCSoundFileView
w = SCWindow.new("soundfile test", Rect(10, 700, 750, 100));
w.front;
a = SCSoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
// f.inspect;

a.soundfile = f;			// set soundfile
a.read(0, f.numFrames);		// read in the entire file.
a.refresh;				// refresh to display the file.
)

		// reading file
a.read(0, f.numFrames / 2).refresh;	// read first half
a.read.refresh;					// read entire file by default
a.read(f.numFrames / 2).refresh; 	// read second half
a.read(0, -1).refresh;				// -1 also reads entire file, like buffer.

	// block sets visual resolution of waveform, default is 64.
	// i.e. the view keeps peak values for each block of e.g. 64 samples
	// rather than the entire waveform.
a.read(0, -1, block: 32).refresh;
a.read(0, -1, block: 24).refresh;
a.read(0, -1, block: 16).refresh;

	// for longer files, you can use:
a.readWithTask;

	// zoom is relative: < 0 zooms in, > 0 zooms out.
a.zoom(0.2).refresh;
a.zoom(2).refresh;
a.zoom(2).refresh;
a.zoomToFrac(0.5); // zoom to half file size
a.zoomAllOut;
	
a.gridOn = true;			// time grid, 1 second by default,
a.gridResolution = 0.2;		// or set resolution in seconds
a.gridColor = Color.green;	// color is changeable.
a.gridOffset_(0.1);		// not sure if this is working?



a.timeCursorOn = true;			// a settable cursor
a.timeCursorPosition = 2050;	// position is in frames.
a.timeCursorColor = Color.white;	

		// toggle drawing on/off
a.drawsWaveForm = false;
a.drawsWaveForm = true;

	// these methods should return view properties (not done yet):
a.gridOn
a.gridResolution
a.gridColor
a.timeCursorOn
a.timeCursorPosition
a.timeCursorColor

		// Selections: multiple selections are supported.
		// e.g. use selection 0:
a.setSelectionColor(0, Color.red);	// set...( index, value )
a.selectionStart(0);				// at index
a.setSelectionStart(0, 12345);		
a.setSelectionSize(0, 12345);

a.setSelectionStart(0, 1234);
a.selectionStart(0);		//

		// now selection 1
a.setSelectionColor(1, Color.white);
a.setSelectionStart(1, 1234).setSelectionSize(1, 1234 * 2);
a.selectionStart(1);		//
a.setSelectionStart(0, 12345);		//

		// the current selection gets changed when click/dragging in view.
a.currentSelection;	// index of current selection;
a.currentSelection_(1);	// switch current selection - try click/drag white now.
a.currentSelection;

a.selections.size;		// 64 selections
a.selections[0];
a.selections[1];
a.selections;

	// setSelection (index, selection);
a.setSelection(0, [234, 2345]);
a.selection(1);	// returns [start, size].


a.elasticMode = true;	// not sure if this is working yet?

(		// mouseUpAction
a.mouseUpAction = {
	("mouseUp, current selection is now:"
		+ a.selections[a.currentSelection]).postln;
};
)
	// lock selection 0:
a.currentSelection_(0);
a.setEditableSelectionStart(0, false);
a.setEditableSelectionSize(0, false);


	// unlock selection 0:
a.setEditableSelectionStart(0, true);
a.setEditableSelectionSize(0, true);

a.selectionStartTime(0);
a.selectionDuration(0);


a.setSelectionStart(0, 12345);
a.setSelectionSize(0, 12345);
a.readSelection.refresh;
a.readSelection(16).refresh;	// in higher resolution
a.read.refresh;				// go back to entire file.


a.dataNumSamples;	// visual data have this many points
a.data.plot;		//
a.setData(a.data.reverse);


a.zoom(0.25);		// scrolling is normalized
a.scrollTo(0.5);	//
a.scrollTo(0.6);	//
a.scroll(12);		// scroll is in viewFrames.

a.zoom(4);	

w.close;



