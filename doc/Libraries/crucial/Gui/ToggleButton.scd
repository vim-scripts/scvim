
ToggleButton


ToggleButton.new(layout,title,onFunction,offFunction,initialState)



t = ToggleButton(nil,"push me",{
	"on".postln;
},{
	"off".postln;
},false);

t.toggle;


