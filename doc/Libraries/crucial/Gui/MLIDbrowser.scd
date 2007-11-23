
MLIDbrowser


MultiLevelIdentityDictionary browser

From any node, you can browse down to the leaves.

*new(name1,name2 ... nameN , onSelect)

	name1,name2 ... nameN -
		the name of the node you wish to start browsing at.
		if nil, it will browse from the top of Library.
				
	onSelect -
		the function that is executed when you click on a leaf node.
		if nil, it will supply a function that guis the item.
		


(
// what exactly is in Library right now ?
	MLIDbrowser.new;
)

(
// put in something to library
	Library.put(\test,"hello");
	MLIDbrowser.new(\test);	
)


(
// browse all currently loaded instruments
// if you have no Instr loaded, then Library.at(Instr) will return nil
	Instr("help-MLIDbrowser",{ arg freq=440,phase=0.0,amp=0.2;
		SinOsc.ar(freq,phase,amp);
	});

	//make a Patch when you select an instr
	MLIDbrowser(\Instr,{ arg instr; Patch(instr.name).topGui });
)

To browse all the Instr in your Instr folder, you need to load each one of them.

Simply by accessing each one by its first name (filename and first symbol in the name list), you will force it to load.

[\oscillOrc,\synths].do({ arg name; Instr.at(name) });




