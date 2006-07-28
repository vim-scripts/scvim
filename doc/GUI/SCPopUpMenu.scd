SCPopUpMenu




The 8-fold noble path
(
var sbs;
 w = SCWindow.new.front;
 l = [
 "right view","right thinking","right mindfulness","right speech",
 "right action","right diligence","right concentration","right livelihood"
 ];
 sbs = SCPopUpMenu(w,Rect(10,10,180,20));
 sbs.items = l;
 sbs.background_(Color.white);
 sbs.action = { arg sbs;
 [sbs.value, l.at(sbs.value)].postln; // .value returns the integer
 };
)




The underlying OS X graphics system gives special meanings to some characters
- divider line

(

var sbs;
 w = SCWindow.new.front;
 l = [
 "1 absolute", 
 "-replaced by a divider", // starting with a -
 "3 relative",
 
 "4 fore <= aft", // fore aft ( <= disappears )
 "5 fore <hello aft", // fore ello aft
 "6 something -> else", // ok
 
 "7 fore ?hello aft", // fore hello aft
 "8 fore ?-hello aft", // fore -hello aft (one - )
 "9 fore -<hello aft", // fore ello aft

 "10 something (else)", // item greyed out
 "11 something \(else)", // item still greyed out
 "12 something [else]", // ok
 "13 something {else}", // ok

 "14 something | else" // ok

 ];
 sbs = SCPopUpMenu(w,Rect(10,10,180,20));
 sbs.items = l;
 sbs.background_(Color.white);
 sbs.action = { arg sbs;
 [sbs.value, l.at(sbs.value)].postln; // .value returns the integer
 };

)

also these:
<
=
(


