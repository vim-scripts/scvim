
TempoPlayer

Outputs the current tempo in beats per seconds. All TempoPlayers share the same TempoBus, and so don't incur any additional resources.

Move the tempo slider.
(
	Instr(\helpTempoPlayer,{ arg tempo;
		Impulse.ar( tempo )
	},[
		\tempo
	]);
	
	Patch(\helpTempoPlayer
	,[
		TempoPlayer.new
	]).gui
)


A TempoBus belongs to a specific server for its whole object-lifetime. A TempoPlayer is only told which server it is to play on when it is asked to prepare for play by its parent object.  A TempoPlayer can be saved in a larger musical structure and that structure is capable of being played on disparate servers.

the symbol \tempo is registered in Spec.specs as a TempoSpec

\tempo.asSpec.insp

whose defaultControl is a TempoPlayer

\tempo.asSpec.defaultControl.insp

so that the argname tempo in an Instr would by default result in a TempoPlayer for a Patch using that Instr.

Patch({ arg tempo;
	Impulse.ar( tempo )
}).gui



execute this many times
(

Patch({ arg tempo;
	Impulse.ar( tempo )
},[
	TempoPlayer.new

]).play(atTime: 1)

)



see BeatClockPlayer



