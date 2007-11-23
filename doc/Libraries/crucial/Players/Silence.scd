
Silence



Silence.new.play



//this causes an error
Patch({ arg audio;
	RLPF.ar(audio,1300)
},[
	0.0
]).play


// Silence uses no cpu at all
Patch({ arg audio;
	RLPF.ar(audio,1300)
},[
	Silence.new
]).play


