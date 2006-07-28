SCMovieView

can play movies such as .mov and mpg, 
and image files like jpg, png, tiff and others.
(currently, it gets stuck on picts.)
This is basically a wrapper for a Cocoa Quicktime view.



(
w = SCWindow("mov").front;
b = SCButton(w, Rect(0, 0, 150, 20))
 .states_([["pick a file"]])
 .action_({ File.openDialog("", { |path| m.path_(path) }) });
m = SCMovieView(w, Rect(0,20,360, 260));
)

 // random-pick a tiff from the Help folder
m.path_("Help/*/*/*.tiff".pathMatch.choose);

 // or point it to a movie (you may have that one too):
m.path_("/Library/Application\ Support/iDVD/Tutorial/Movies/Our\ First\ Snowman.mov");


m.start; // playback
m.muted_(true); // thank god
m.stop; 
 
 //rate
m.rate_(0.2); 
 // backwards
m.gotoEnd.rate_(-1).start;

 // select a range on the controller and play it
m.rate_(1).playSelectionOnly_(true).start;

 // loopModes:
m.loopMode_(1); // only one direction
m.loopMode_(0).start; // back and forth



m.stop;
m.gotoBeginning;
 
 // single steps
m.stepForward;

10.do { m.stepForward; };
m.stepBack;

// select with shift-drag, copy paste between movieviews or quicktime player
m.editable_(true);


m.showControllerAndAdjustSize(true, true);
 // resize compared to image size:
m.resizeWithMagnification(0.75); 

 //goto time (in seconds)
m.currentTime_(1);

 // not there yet, but would be nice to have:
 // startFrame, length
m.setSelection_(20, 15);

 
m.frame_(frame); // jump to frame
m.frame.postln; // poll current frame pos


