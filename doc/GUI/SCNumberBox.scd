SCNumberBox

superclass: SCStaticTextBase

(
w = SCWindow("SCNumberBox Example", Rect(100, 500, 400, 60));
//w.view.decorator = FlowLayout(w.view.bounds);
b = SCNumberBox(w, Rect(150, 10, 100, 20));
b.value = rrand(1,15);
b.action = {arg numb; numb.value.postln; };
w.front
)

b.value = rrand(1,15);

b.setProperty(\boxColor,Color.grey);
b.setProperty(\stringColor,Color.white);
b.setProperty(\align,\center);
