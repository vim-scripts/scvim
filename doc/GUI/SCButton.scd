SCButton


each state:
 [ name, text color, background color ]

(

w = SCWindow.new;
w.front;

b = SCButton(w,Rect(20,20,340,30));
b.states = [
 ["suffering",Color.black,Color.red],
 ["origins of suffering",Color.white,Color.black],
 ["cessation of creating suffering",Color.red,Color.white],
 ["the path to cessation of creating suffering",
 Color.blue,Color.clear]
 ];
b.action = { arg butt;
 butt.value.postln; 
};
)

Failure to set any states at all results in an invisible button.


// does not do action
b.value = 2;

// does action if it results in a change of value
b.valueAction = 3;

// clips to size of states
b.valueAction = -1;

// floats no problem
b.valueAction = 3.3;



(

w = SCWindow.new;
w.front;

b = SCButton(w,Rect(20,20,340,30));
b.states = [
 ["suffering",Color.black,Color.red]
 ];


// new state doesn't take effect until ...
b.states = [
 ["cessation of suffering",Color.red,Color.black]
 ];
//window is refreshed
w.refresh;

//or the view itself is refreshed
b.refresh;

)