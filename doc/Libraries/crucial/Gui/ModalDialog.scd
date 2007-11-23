
ModalDialog


(
	ModalDialog({ arg layout; 		// pops a small window for you
		
		var choices;
		
		choices= [
			BooleanEditor([true,false].choose),
			BooleanEditor([true,false].choose),
			BooleanEditor([true,false].choose),
			BooleanEditor([true,false].choose),
			BooleanEditor([true,false].choose),
			BooleanEditor([true,false].choose)
			];
			
		choices.do({ arg c,i;
			c.gui(layout);
		});
		
		choices // return your objects
		
	},{ // ok function
		arg choices; // receives those objects
		choices.sum({ arg boolgui,i;
			boolgui.value.binaryValue * (2**i)
		}).postln
	});
)	
	
	
	see also [Sheet]


