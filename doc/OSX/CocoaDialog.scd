CocoaDialogfile dialogs that utilize OS X Cocoa services.


see also: [Cocoa]

OSX only.

*getPaths(okFunc, cancelFunc, maxSize)

Displays an Open File Dialog. If ok is pressed then okFunc is evaluated with the selected paths passed as an Array of Strings as the first argument. If cancel is pressed then cancelFunc is evaluated. maxSize is the maximum number of files which may be selected. The default is 20.

(
CocoaDialog.getPaths({ arg paths;
 paths.do({ arg p;
 p.postln;
 })
},{
 "cancelled".postln;
});
)

*savePanel(okFunc, cancelFunc)

Displays a Save File Dialog. If ok is pressed then okFunc is evaluated with the selected path passed as a Strings as the first argument. If cancel is pressed then cancelFunc is evaluated.

(
CocoaDialog.savePanel({ arg path;
 path.postln;
},{
 "cancelled".postln;
});
)
