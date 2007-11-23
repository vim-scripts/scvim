
SCVLayoutView


(
q = 10;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));

Array.fill(q,{ arg i;
	SCSlider(v,Rect(0,0,75,20)).value_(i / q)
});

w.front
)



elastic
resize the window ... oooh
(
q = 10;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));
v.resize = 5; //  elastic
Array.fill(q,{ arg i;
	var s;
	s = SCSlider(v,Rect(0,0,75,20));
	s.value = i / q;
	s
});

w.front
)

(
q = 10;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));
v.resize = 5; //  elastic
Array.fill(q,{ arg i;
	var s;
	s = SCSlider(v,Rect(0,0,75,20));
	s.resize = 5; // elastic
	s.value = i / q;
	s
});

w.front
)

(
q = 5;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));
v.resize = 5; //  elastic

Array.fill(q,{ arg i;
	var s;
	s = SCSlider(v,Rect(0,0,75,20));
	s.value = i / 5;
	if(i < 2,{
		s.resize = 5; // some elastic
		s.setProperty(\minHeight,20);
	},{
		s.resize = 1; // some not elastic
	});
	s
});

w.front
)

(
q = 5;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));
v.resize = 5; //  elastic

Array.fill(q,{ arg i;
	var s;
	s = SCSlider(v,Rect(0,0,75,20));
	
	s.value = i / 5;
	s.resize = 5;
	s.setProperty(\minHeight,20);
	s.setProperty(\maxHeight,40);
	s
});

w.front
)



spacing
(
q = 10;
w = SCWindow.new;

v = SCVLayoutView(w,Rect(10,10,300,300));
v.setProperty(\spacing,0);

Array.fill(q,{
	SCSlider(v,Rect(0,0,75,20))
});

w.front
)



