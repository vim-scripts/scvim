SCListView



(

 w = SCWindow.new.front;
 l = [
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative",
 "absolute","relative"
 ];
 v = SCListView(w,Rect(10,10,180,50));
 v.items = l;
 v.background_(Color.white);
 v.action = { arg sbs;
 [sbs.value, l.at(sbs.value)].postln; // .value returns the integer
 };

)

v.value = 16.rand

