
CXMenu


A pop up menu that does its action and closes itself after you select an item.

The difference between this and PopUp is that here there are separate functions for
each menu item, and with PopUp there is one action.

(
m = CXMenu(
	\soup->{ "soup".postln; },
	\pork->{ "pork".postln; },
	\duck->{ "duck".postln; },
	\tiramisu->{ "tiramisu".postln; }
);


m.gui(nil);

)

(
m = CXMenu(
	\myName->{ "you hit myName".postln; },
	\yourName->{ "you hit yourName".postln; }
);

m.closeOnSelect = false;

m.gui;

)	
	

On another layout
(
Sheet({ arg f;
	CXLabel(f,"partials:");
	f.startRow;
	m = CXMenu.newWith(
		Array.fill(15,{ arg i;
			i.asString.asSymbol -> { i.postln }
		})
	);
	m.closeOnSelect = false;
	m.gui(f);
})
)
You can add things to the menu above
m.add(\more->{ "more".postln; });


On a normal SCWindow

(

w = SCWindow.new;
w.front;

x = CXMenu( \a -> { "a".postln },\b -> { "b".postln },\c -> { "c".postln });
x.closeOnSelect = false;
x.gui(w);

)
Note that the arrow keys work to navigate once you are focused on any of the buttons.




