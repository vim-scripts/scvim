Document


Document(title, text, isPostWindow);

Document.new("this is the title", "this is the text");


Document.open(path);

Document.open("Help/Help.help.rtf");

Document.allDocuments
array where all open documents are stored.

Document.current
returns the current Document.

Document.hasEditedDocuments
returns true if there are unsaved changes in one of the open Document.

Document.closeAll(leavePostOpen)
by default the postWindow stays open.

Document.closeAllUnedited(leavePostOpen)
by default the postWindow stays open.

background_
set the background color of a Document
(
a = Document("background", "'hardly see anything");
a.background_(Color.blue(alpha:0.8));
)

stringColor_
set the text color of a Document
(
a = Document("background", "where are my glasses?");
a.background_(Color.red(alpha:0.8));
a.stringColor_(Color.red);
)

font_(font, rangestart, rangesize)
set font. if rangestart = -1 for the whole document

bounds_(Rect)
set bounds

close
close a Document

(
Task({
 var doc;
 doc = Document("background", "closing in 2 seconds");
 doc.stringColor_(Color.red);
 1.wait;
 doc.background_(Color.red(alpha:0.8));
 1.wait;
 doc.close;
 }).play(AppClock);
 
)

isEdited
returns true if a Document has unsaved changes unless it is the postWindow

(
Document.current.isEdited.postln;
)

syntaxColorize
same as command' 

(
a = Document.allDocuments.at(0).syntaxColorize; 
)

selectLine

(
Document.current.selectLine(1);
)

selectionStart
get the current position in the text 

(
Document.current.selectionStart.postln;
)

selectionSize
get the current size of selection in the text 

(
Document.current.selectionSize.postln;
)

selectRange(start, length)

(
Document.current.selectRange(Document.current.selectionStart, 100);
)

string(rangestart, rangesize)
get the text of a document. If no rangestart is applied the whole text is returned.

(
Document.current.string;
)

selectedString
get the currently selected text.
(
var doc;
doc = Document.current;
doc.selectRange(doc.selectionStart-40, 10);
doc.selectedString.postln;
)

string_(string, rangestart, rangesize)
set the text of a document. if rangestart is -1 (default) the whole text is replaced
(
var doc;
doc = Document(string:"");
doc.string_("set a String")
)


selectedString_
insert text at the current position

(
var doc, txt;
doc = Document.current;
txt = "doc.postln; \n";
doc.selectedString_(txt);
)

front
(
Document.allDocuments.at(0).front; 
)

keyDownAction_
register a keyDownAction. this is useful for macros

(
var doc, txt;
doc = Document.current;
doc.keyDownAction_({arg doc, key, modifiers, num;
 [doc, key, modifiers].postln
});
)
(
Document.current.keyDownAction_(nil);
)

toFrontAction_
called when the window is clicked to front

example:
associate a proxyspace to two different windows.
(
s = Server.local;
s.boot;
q = ProxySpace.push(s);
q.pop;
r = ProxySpace.push(r);
r.pop;
a = Document("proxy r", "//this is proxyspace r \n x = ~out.play; \n ~out = { SinOsc.ar([400, 500]*0.9, 0, 0.2) };");
a.background_(Color(0.8, 1.0, 1.0));

b = Document( "proxy q", "//this is proxyspace q \n x = ~out.play; \n ~out = { SinOsc.ar([1400, 1500]*0.9, 0, 0.2) };");
b.background_(Color(1.0, 1.0, 0.8));

b.toFrontAction_({
 if(currentEnvironment == r,{r.pop});
 q.push;
});
a.toFrontAction_({
 if(currentEnvironment == q,{q.pop});
 r.push;

});
)
(
//need to pop proxyspace from other examples
q.pop
r.pop
)

onClose_
register a close - action.
(
Document.current.onClose_({
 var doc;
 doc = Document("before closing","did you call me?");

 Task({
 
 doc.stringColor_(Color.red);
 0.1.wait;
 doc.background_(Color.red(alpha:0.8));
 0.3.wait;
 doc.close;
 }).play(AppClock);

})
)

mouseDownAction_
(

//add a mouse action to this document: 
//example: easy button:
//when you click in front of a 17 a SinOsc will start up;
Server.local.boot;
Document.current.mouseDownAction_({arg doc;
 var char;
 char = doc.rangeText(doc.selectionStart, 2);
 if(char == "17",{
 {EnvGen.kr(Env.perc, doneAction:2) * SinOsc.ar([600,720,300].choose, 0, 0.5)}.play;
 });
 if(char == "23",{
 {EnvGen.kr(Env.perc, doneAction:2) * PinkNoise.ar(0.2)}.play;
 });
})

)
test here and click in front of the number:
  17
  23




unfocusedFront_
(
Document.allDocuments.at(0).unfocusedFront
)


(

var doc;
doc = Document("", "||");
doc.background_(Color.blue(alpha: 1.0.rand));
Task({
 1000.do({
 doc.setFont(size: [7,8,9,24].choose);
 0.08.wait;
 })
}).play(AppClock);
Task({
 100.do({
 1.01.wait;
 doc.stringColor_([Color.red(alpha: 1.0.rand), Color.green(alpha: 1.0.rand)].choose);
 })
}).play(AppClock);
Task({
 100.do({
 1.01.wait;
 doc.selectedString_(["\"\n#","||","-", "--"].choose);
 })
}).play(AppClock);
Task({
 var co, mul;
 co = 0.1;
 mul = 1.02;
 100.do({
 0.16.wait;
 co = co * mul;
 if(co > 0.99, { co = 0.1 });
 doc.background_(Color.blue(alpha: co));
 });
 doc.close;
}).play(AppClock)

)

//
Utilities and settings for dealing with documents such as super collider code files. By default the document directory is SuperCollider's application directory.

In Main-startUp you can set this to a more practical directory:

 Document.dir = "~/Documents/SuperCollider";


*standardizePath
 if it is a relative path, expand it to an absolute path relative to your document directory. expand tildes in path (your home directory), resolve symbolic links (but not aliases).
 also converts from OS9 macintosh path format.
 
 Document.standardizePath(
 ":Patches:newfoots:fastRuckAndTuck"
 )
 /Volumes/Macintosh HD/Users/cruxxial/Documents/SC3docs/Patches/newfoots/fastRuckAndTuck
 
 
 Document.standardizePath(
 "~/Documents/SC3docs/Patches/newfoots/fastRuckAndTuck"
 )
 Patches/newfoots/fastRuckAndTuck
 
 
 Document.standardizePath(
 "Patches/newfoots/fastRuckAndTuck"
 )
 Patches/newfoots/fastRuckAndTuck
 

*abrevPath
 reduce the path relative to your document directory if possible.

