SCTextView a text editor

 
 superclass: SCView
 see also: Document
 
 *new(window, bounds);
 
string_ set the text
string get the text
setString(string, rangestart, rangesize) 
 set text into a range 
selectedString get the selected text only
selectionStart get the current position in the text 
selectionSize get the current size of selection in the text 
stringColor_ set the color of the whole text 
setStringColor(color, start, size) 
 set the color of a selection of text 
setStringColor(color, start, size) 
autoHideScrollers_ 
hasVerticalScroller_ 
hasHorizontalScroller_
textBounds_ 
font_
 usesTabToFocusNextView_
enterInterpretsSelection_


//examples



(
var win, txtv;

win = SCWindow.new.front;
win.view.decorator_(FlowLayout(win.view.bounds));
txtv = SCTextView(win,Rect(0,0, 300,200))
 .hasVerticalScroller_(true)
 .autohidesScrollers_(true)
 .focus(true);
)