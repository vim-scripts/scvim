ActionButton

Superclass: Object

crucial dependencies: PageLayout

*new( layout, title, function )
if layout is nil, a new PageLayout will be created.
the size of the button will scale to that of the string

(
 ActionButton(nil,"hit me",{ 
 "yeah baby".postln 
 });
 
)

( 
// bigger title... bigger button
 ActionButton(nil,"hit me hit me hit me hit me hit me hit me hit me hit me hit me hit me hit me ",{ 
 "yeah baby".postln 
 });
)


(
// set minimum sizes for x and y
// longer text will still cause it to expand
ActionButton(nil,"hit me",{ 
 "yeah baby".postln 
},200,40,Color.white,Color.black);

)



// accepting drags by setting the view.receiveDrag handler
the list view by default gives an integer when dragging from it.
here i am making the action button accept dragged integers.
(
Sheet({ arg f;

 a = SCListView(f,100@100);
 a.items = ["a","b","c"];

 b = ActionButton(f,"i accept integers",{ 
 "was hit".postln 
 });
 b.view.canReceiveDragHandler = { SCView.currentDrag.isNumber };
 b.view.receiveDragHandler = { 
 a.items[ SCView.currentDrag.asInteger ].postln; 
 };
})
)

here the list view is made to export a string when dragged from.
the action button is accepting strings dragged to it.
(
Sheet({ arg f;
 a = SCListView(f,100@100);
 a.items = ["a","b","c"];
 a.beginDragAction = { arg listView;
 listView.items[ listView.value ].debug("begin dragging");
 };

 b = ActionButton(f,"i accept strings",{ 
 "butt hit".postln 
 });
 b.view.canReceiveDrag = { SCView.currentDrag.isString };
 b.view.receiveDrag = { 
 SCView.currentDrag.postln; 
 };
})
)
