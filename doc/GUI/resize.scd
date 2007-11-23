
resize				resize behavior for SCView and its subclasses


resize takes nine different arguments defining the behavior when window is resized.


		1 2 3
		4 5 6
		7 8 9
		
		1 - fixed to left, fixed to top
		2 - horizontally elastic, fixed to top
		3 - fixed to right, fixed to top
		
		4 - fixed to left, vertically elastic
		5 - horizontally elastic, vertically elastic
		6 - fixed to right, vertically elastic
		
		7 - fixed to left, fixed to bottom
		8 - horizontally elastic, fixed to bottom
		9 - fixed to right, fixed to bottom
		


Example

// the popupmenu contains the various modes

(
w = SCWindow.new("soundfile test", Rect(200, 200, 720, 250));

p = SCPopUpMenu(w, Rect(10,10,80,20))
	.items_( Array.fill(9, {arg i; (i+1).asString;}) )
	.action_({ arg sbs;
		a.resize_(sbs.value+1);
	});

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");

a = SCSoundFileView.new(w, Rect(10,40, 700, 180))
	.soundfile_(f)
	.read(0, f.numFrames)
	.resize_(1);

w.front;
)






