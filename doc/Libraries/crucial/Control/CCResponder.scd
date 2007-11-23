
CCResponder


CCResponder(function, src, chan, num, value, install = true)

(
	c = CCResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		nil, // any CC number
		nil // any value
	)
)

c.remove


(
	c = CCResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		80, // CC number 80
		{ |val| val < 50 } // any value less than 50
	)
)

c.remove


CCResponder.removeAll


