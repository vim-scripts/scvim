
TdefEditor 	a line of editing controls for a Tdef.

TdefEditor uses the Gui class to be platform independent;
it also uses the Document class which is not cross-platform yet.

play/stop button :
	indicates whether the tdef is playing:
		" >" if it is stopped,
		" _" if it is playing and active,
		" |" if it is playing, but the stream has ended.
	
pause/resume button:
	only visible if one can pause or resume the Tdef.
	"paus" when you can pause it,
	"rsum" when you can resume it.

src button:
	opens a document to edit the source (function) of the Tdef.
	green if a source exists, white if not.

env button:
	opens a document to edit the environment of the Tdef,
	which is where one can keep all variables the tdef uses
	for easy access.
	green if the tdef has an envir, white if not.

(
Tdef(\a, { |e| 100.do { |i| i.postln; 0.5.wait } });

t = TdefEditor(Tdef(\a), 4);
Tdef(\a).set(\otto, 12, \ann, 1234);
)
Tdef(\a).stop;
Tdef(\a).play;
Tdef(\a).pause;
Tdef(\a).resume;

t.proxy_(nil);
t.proxy_(Tdef(\a));


Tdef(\b, { |e| 100.do { |i| Tdef(\a).set(\otto, 8.rand); exprand(0.1, 3.0).wait } });
Tdef(\b).play;
TdefEditor(Tdef(\b));

	// see all Tdefs:
TdefAllGui(16);

See also TdefAllGui, PdefEditor, PdefAllGui.

	// full test suite for TdefEditor:
	
t = TdefEditor();
t.proxy_(Tdef(\a));
t.proxy_(Tdef(\b));
t.proxy_(nil);
t.proxy_(Tdef(\a));

Tdef(\a, { 10.do { |i| i.postln; 0.5.wait } });
Tdef(\a).source_(nil);

Tdef(\a).set(\otto, 2);
Tdef(\a).envir_(nil);

Tdef(\a, { 10.do { |i| i.postln; 0.5.wait } });
Tdef(\a).play;
Tdef(\a).pause;
Tdef(\a).resume;

	// bug still there: setting envir starts tdef!
Tdef(\a).set(\otto, 2);



