
Font

	Font(name, size)

command-T to look for Font names.

SCStaticText, SCButton and their subclasses (SCNumberBox, SCDragView, SCDragSink, SCDragBoth) can set their fonts.


(
var w,f;

w = SCWindow("Fonts", Rect(128, 64, 340, 360));
w.view.decorator = f = FlowLayout(w.view.bounds,Point(4,4),Point(4,2));

[
"Helvetica-Bold",
"Helvetica",
"Monaco",
"Arial",
"Gadget",
"MarkerFelt-Thin"

].do({ arg name;
	var v, s, n, spec, p, height = 16;

		v = SCStaticText(w, Rect(0, 0, 56, height+2));
		v.font = Font(name, 13);
		v.string = name;

		s = SCButton(w, Rect(0, 0, 140, height+2));
		s.font = Font(name, 13);
		s.states = [[name]];
		
		n = SCNumberBox(w, Rect(0, 0, 56, height+2));
		n.font = Font(name, 13);
		n.object = pi;

	f.nextLine;
});

w.front;

)

(
var w,f,i=0;

w = SCWindow("Fonts", Rect(128, 64, 800, 760));
w.view.decorator = f = FlowLayout(w.view.bounds,Point(4,4),Point(4,2));

Font.availableFonts.do({ arg name;
	var v, s, n, spec, p, height = 16,font;
	font = Font(name,13);
	
		v = SCStaticText(w, Rect(0, 0, 56, height+2));
		v.font = font;
		v.string = name;

		s = SCButton(w, Rect(0, 0, 140, height+2));
		s.font = font;
		s.states = [[name]];
		s.action = { font.asCompileString.postln; };
		
		n = SCNumberBox(w, Rect(0, 0, 56, height+2));
		n.font = font;
		n.object = pi;
	if( (i = i + 1) % 3 == 0,{
		f.nextLine;
	});
});

w.front;

)


