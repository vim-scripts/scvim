
SelectButtonSet


Radio button style set, fashioned as a single object.

SelectButtonSet.new( layout,
	labels, // array of labels or a quantity
	action,
	color, // or color function
	selectedColor, // or selectedColor function
	x,y // optional size of each button
	)


(

	SelectButtonSet( nil, [ "one", "two","three","four"] , 
		{ arg selectedIndex,selectButtonSet;
			[ selectedIndex, selectButtonSet ].postln;
		},width: 60
	)
	
)


(

	SelectButtonSet( nil, 
		16 , // make 16 buttons 
		{ arg selectedIndex,selectButtonSet;
			[ selectedIndex, selectButtonSet ].postln;
		}	
	)
	
)


.selected
	selected index
.selectedLabel
	label of the selected
select( index)
passiveSelect( index )
	action not performed
	
color and selectedColor may be either a Color object or a function
that will be passed the selected index when valued.
	

on various kinds of layouts/windows/nil :

(
SelectButtonSet(
	nil,
		["1", "2"], 
		{|i| ("Input" + i).postln},
		width: 40, height: 30
	);
)	

(
SelectButtonSet(
	FlowView.new,
		["1", "2"], 
		{|i| ("Input" + i).postln},
		width: 40, height: 30
	);
)
(
SelectButtonSet(
	SCWindow.new.front,
		["1", "2"], 
		{|i| ("Input" + i).postln},
		width: 40, height: 30
	);
)
(
SelectButtonSet(
	SCHLayoutView.new(SCWindow.new.front,400@400),
		["1", "2"], 
		{|i| ("Input" + i).postln},
		width: 40, height: 30
	);
)

(
// vertical
SelectButtonSet(
	SCVLayoutView.new(SCWindow.new.front,100@400),
		["1", "2"], 
		{|i| ("Input" + i).postln},
		width: 40, height: 30
	);

)	
	
	
	


