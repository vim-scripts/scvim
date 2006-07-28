SCHLayoutView


(
q = 10;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));

Array.fill(q,{ arg i;
 SCSlider(h,Rect(0,0,20,75)).value_(i / q)
});

w.front
)



elastic
(
q = 10;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));
h.background = Color.red(alpha:0.1);
h.resize = 5; // elastic
Array.fill(q,{ arg i;
 var s;
 s = SCSlider(h,Rect(0,0,20,75));
 s.value = i / q;
 s
});

w.front
)

Contents are elastic
(
q = 10;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic
Array.fill(q,{ arg i;
 var s;
 s = SCSlider(h,Rect(0,0,20,75));
 s.resize = 5; // elastic
 s.value = i / q;
 s
});

w.front
)

set minWidth on contents
(
q = 5;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));
h.background = Color.red(alpha:0.2);
h.resize = 5; // elastic

Array.fill(q,{ arg i;
 var s;
 s = SCSlider(h,Rect(0,0,20,75));
 s.value = i / 5;
 if(i < 2,{
 s.resize = 5; // some elastic
 s.setProperty(\minWidth,20);
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

h = SCHLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic

Array.fill(q,{ arg i;
 var s;
 s = SCSlider(h,Rect(0,0,20,75));
 
 s.value = i / 5;
 s.resize = 5;
 s.setProperty(\minWidth,20);
 s.setProperty(\maxWidth,40);
 s
});

w.front
)

Text flows
(
q = 5;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic

Array.fill(q,{ arg i;
 var s;
 s = SCStaticText(h,120@20).string_("abcdefg");

 s.resize = 5;
 s.setProperty(\minWidth,10);
 s.setProperty(\maxWidth,80);

 // not working
 s.setProperty(\maxHeight,10);
 s.setProperty(\minHeight,10);

 s.background = Color.white;
 s
});

w.front
)

spacing
(
q = 10;
w = SCWindow.new;

h = SCHLayoutView(w,Rect(0,0,300,300));
h.setProperty(\spacing,0);

Array.fill(q,{ 
 SCSlider(h,Rect(0,0,20,75))
});

w.front
)

