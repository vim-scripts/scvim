
NumberEditor  			holds a float for editing

NumberEditor.new(value,spec)
	value -  initial value
	spec -  ControlSpec or StaticSpec. see [Spec]

like all editors,
	.value
	.asCompileString
	.next
	
all return the float value, not the editor itself.

This is the default control view for a StaticSpec. 

If used in a Patch, it will return its initial value when the patch starts, but will not be modulateable after that. See KrNumberEditor for modulateable.

NumberEditor can also be used in Pbind, since it returns its float value in response to .next or .value







(
n = NumberEditor(2.3,[0,10]);
n.value = 5.6;
n.asCompileString.postln;
5.6
)


(
//note that the .gui message returns a NumberEditorGui
n = NumberEditor(440.0,\freq).gui;
n.insp;
)

(
// so make sure you get the NumberEditor
n=NumberEditor(440.0,\freq);
n.gui;
n.insp;
)


(
	f=MultiPageLayout.new;
	
	n=NumberEditor(440.0,\freq);
	n.topGui(f);
	
	ActionButton(f,"post value",{ n.value.postln });
	// it compiles as its value
	ActionButton(f,"post NumberEditor asCompileString",{
		n.asCompileString.postln
	});
	f.resizeToFit.front;
)

// programatically set it
n.value = 100
n.changed; // now the slider moves
	// and sends to the server !




// controlling the display
(
Sheet({ arg f;
	f.startRow;
	NumberEditor(440.0,\freq).gui(f); // default

	NumberEditor(440.0,\freq).smallGui(f); // smallGui never has slider
	NumberEditor(440.0,\freq).gui(f,nil, false); //use gui,nil bounds, slider: false	

	f.startRow;
	NumberEditor(440.0,\freq).gui(f,60@10,true); // slider 60 by 10
	f.startRow;
	NumberEditor(440.0,\freq).gui(f, 200@40, true); // slider 200 by 40
	f.startRow;


	NumberEditor(440.0,\freq).smallGui(f);
	NumberEditor(440.0,\freq).smallGui(f);
	NumberEditor(440.0,\freq).smallGui(f);
	NumberEditor(440.0,\freq).smallGui(f);

	f.startRow;
	NumberEditor(440.0,\freq).gui(f,20@100,true);	// verticle, with slider
	NumberEditor(440.0,\freq).gui(f,20@100,true);	// verticle, with slider
})
)
bug: verticle not working yet

Putting them on a Sheet
(
w = Sheet({ arg h;
	c = Array.fill(10,{ arg i;
		var n;
		n = NumberEditor(0,\amp);
		h.startRow;
		n.gui(h);
		n
	});
});

)

Putting them on a MultiPageLayout
(
w = MultiPageLayout.new;
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	w.startRow;
	n.gui(w);
	n
});
w.front;
)

Putting them on normal windows
(
w = SCWindow.new;
w.front;
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	n.gui(w,Rect(10,25 * i, 150,13));
	n
});

)

using a MultiPageLayout on a window
(

w = SCWindow.new;
w.front;
p = MultiPageLayout.on(w);
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	n.gui(p);
	p.startRow;
	n
});

)


put them on a FlowView
(

w = SCWindow.new;
w.front;
p = FlowView(w,Rect(10,10,500,500));
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	n.gui(p);
	p.startRow;
	n
});

)







// a nice glitch display
//verticle not working yet
(
w = SCWindow.new;
w.front;
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	n.gui(w,Rect(10 + (15 * i),25, 13,150));
	n
});

)

// in SCVLayout not working yet either
(
w = SCWindow.new;
w.front;
v = SCVLayoutView.new(w,w.view.bounds);
c = Array.fill(10,{ arg i;
	var n;
	n = NumberEditor(0,\amp);
	n.gui(v,Rect(0,0,100,20));
	n
});

)


//works with sliders
(
w = SCWindow.new;
w.front;
v = SCVLayoutView.new(w,w.view.bounds);
c = Array.fill(10,{ arg i;
	var n;
	n = SCSlider(v,Rect(0,0,100,20));
	n
});

)


