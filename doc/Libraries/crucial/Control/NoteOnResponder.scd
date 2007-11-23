
NoteOnResponder


NoteOnResponder(function, src, chan, num, value, install = true)

(
	c = NoteOnResponder({ |src,chan,note,vel|
		[src,chan,note,vel].postln;
		},
		nil, // any source
		nil, // any channel
		nil, // any note
		nil // any vel
	)
)

c.remove


(
	c = NoteOnResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		{ |val| val.exclusiveBetween(50,60) }, // within this note range
		nil // any vel
	)
)

c.remove


CCResponder.removeAll


