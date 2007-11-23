
SynthConsole


*new( object, layout)

convenient buttons for common utilities:
	play, record, stop, tempo etc.
	
each method adds another button.

This may be used on its own and it is also a component used in AbstractPlayerGui for all Players.

An easy way to use it:

(
	Sheet({ arg f;
	
		SynthConsole({ arg synth;
			 SinOsc.ar(300,0,0.3)
		},f) // if no layout provided it will create one
		.play
		.scope
		.fftScope
		.record("SoundFiles/testy.aiff") // sets defaultPath for the prompt dialog
		.write(20) // 20 seconds
		.pauseableRecord	// |,| toggle recording on and off while you play
		.stop
		.formats
		.tempo // gui the default Tempo
		
	})	
)
certain controls are not yet enabled in sc3, so the button will not appear.

note: the play button sends the .play message to your object.


see also [FunctionPlayer]

SynthConsole sends notifications that you can register to recieve through NotificationCenter:
	

	NotificationCenter.register(yourSynthConsole,\didStop,you,{
		// do something like
		true.tabletTracking; // turn back on the wacom mouse
	});
	
	NotificationCenter.register(yourSynthConsole,\didRecordOrWrite,you,{
		arg path; // path is passed in with the notification
		savedTo = path;
	});
	



	


