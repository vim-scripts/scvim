SCNSObject

note: this is experimental (03/2006) things might change and be careful wrong or unsupported Cocoa-calls can crash this Application!

SCNSObject creates a bridge between SuperCollider and Objective-C / Cocoa.
It holds an NSObject and sends messages to it.
The class and messages are passed as Strings. Arguments must be in an Array.
On creation only the init message is passed, alloc is called internally. So all constructor messages other then alloc are not supported yet.

Example:
The Cocoa synthax:
 NSNumber *n = [[NSNumber alloc] initWithFloat: 1.1];
 [n floatValue];
turns into:
 n = SCNSObject("NSNumber", "initWithFloat:", [1.1]);
 n.invoke("floatValue");
 
Multiple messages are put together in one STring and their arguments in one Array.
Example:
Cocoa:
 NSWindow *c = [[NSWindow alloc] initWithContentRect: rect styleMask: 10 backing: 2 defer:YES];
SC:
 c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(0,0,400,100), 10, 2, 1]);

Defer:

Some methods need to be defered. If you want to defer ust call invoke with defer:true. Watch out there is no smart protection for methods that need defer until now! In general you should defer graphic operations.
So calling this might crash sc-lang: c.invoke("makeKeyAndOrderFront:", [nil]);
but this line is fine:
 c.invoke("makeKeyAndOrderFront:", [nil], true); 

Types:

SCNSObjects are converted to NSObjects.

Some types are converted directly:
Rect -> NSRect
Point -> NSPoint

Many obj-c types are not supported yet (NSRange, nib-files, ...).

A String in SC is different than the cString used in Cocoa. So you might get some strange artefacts.

z = SCNSObject("NSString","initWithCString:", ["x 3456512"]);

Actions:

.initAction is a convenience method to add an action to a gui element.
Depending on the type there are different actions to be set: "doFloatAction:"
 "doIntAction:"
 "doStateAction:"
 "doAction:"
 
Examples:

//create a window and add a Slider that posts its value. 

(
var winname = "cocoa test", win, nsname, slider;
nsname = SCNSObject("NSString","initWithCString:length:", [winname, winname.size], false);

win = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",
 [Rect(100,140,400,30), 10, 2, 1]);
win.setDelegate.action_({
 "closing window, releasing objects".postln;
 [winname,nsname,slider,e].do{|it| it.release};
});
slider = SCNSObject("NSSlider", "initWithFrame:", [Rect(0,0,390,20)]); 
e = SCNSObject("SCGraphView", "initWithFrame:", [Rect(0,0,400,30)]); 
win.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [slider], true);
slider.invoke("setFloatValue:", [0.5]);
win.invoke("makeKeyAndOrderFront:", [nil], true);
win.invoke("setTitle:", [nsname]);

{a = slider.initAction;
a.action_({|v,val| val.postln});}.defer(0.1);
~win = win;
)
~win.className
~win.invoke("close", defer:true);



(
z = SCNSObject("NSString","initWithCString:", ["x 3456512"]);

c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(0,0,400,100), 10, 2, 1]);
c.setDelegate.action_({
 "closing window, releasing objects".postln;
 [z,c,d,e].do{|it| it.release};
});
d = SCNSObject("NSTextField", "initWithFrame:", [Rect(0,0,100,20)]); 
e = SCNSObject("NSView", "initWithFrame:", [Rect(0,0,400,100)]); 
c.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [d], true);
c.invoke("makeKeyAndOrderFront:", [nil], true);

)
(
z = SCNSObject("NSString","initWithCString:", ["x 3456512"]);

c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(100,100,100,20), 10, 2, 1]);
c.setDelegate.action_({
 "closing window, releasing objects".postln;
 [z,c,d,e].do{|it| it.release};
});
d = SCNSObject("NSButton", "initWithFrame:", [Rect(0,0,100,20)]); 
e = SCNSObject("NSView", "initWithFrame:", [Rect(0,0,400,100)]); 
c.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [d], true);
c.invoke("makeKeyAndOrderFront:", [nil], true);
d.invoke("setButtonType:", [3]);
{
d.initAction("doStateAction:");
d.nsAction.action_({|it,val| val.postln;});
}.defer(0.1);
)

