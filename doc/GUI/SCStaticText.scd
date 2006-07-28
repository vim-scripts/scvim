SCStaticText

A non-editable textfield

string_(string)
set the text.

font_(font)
set the font.

stringColor_(color)
 set the color of the string.

Examples

(
w = SCWindow.new.front;
a = SCStaticText(w, Rect(10, 10, 100, 20));
a.string = "Rolof's Rolex";
)

// adjust bounds
a.bounds = Rect(5, 5, 100, 20)


///// dynamic

(
w = SCWindow.new.front;
a = Array.fill(20, {SCStaticText(w, Rect(w.bounds.extent.x.rand, w.bounds.extent.y.rand, 100, 16))
 .string_("Rolof's Rolex".scramble)
 .stringColor_(Color.rand)
 .font_(Font([
 "Helvetica-Bold",
 "Helvetica",
 "Monaco",
 "Arial",
 "Gadget",
 "MarkerFelt-Thin"
 ].choose, 16))
});
)

r = {inf.do{|i|
 thisThread.randSeed_(1284);
 a.do{|item| 
 {item.bounds = Rect(5+w.bounds.extent.x.rand * (cos(i*0.01)).abs, w.bounds.extent.y.rand * sin(i*0.001), 100, 20)}.defer;
 };
 0.1.wait;
}}.fork

r.stop

