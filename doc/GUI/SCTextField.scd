SCTextField

superclass: SCNumberBox

Sheet({ arg l;
 b = SCTextField(l,Rect(0,0,150,30));
 b.string = "hi there";
 b.action = {arg field; field.value.postln; }
});


// does not do the action
b.value = "yo";


b.setProperty(\boxColor,Color.grey);
b.setProperty(\stringColor,Color.white);
b.setProperty(\align,\center);



Does not handle composed character sequences ( ? ? etc. )

option-e appears to freeze it ?