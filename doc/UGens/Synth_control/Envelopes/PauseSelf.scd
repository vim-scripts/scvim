
PauseSelf			when triggered, pause enclosing synth

superclass: UGen

	
	pause enclosing synth when input signal crosses from non-positive to positive
	
	*kr(src) src - input signal



	//example
	
	(
	SynthDef("pauseSelf-help", {arg out, t_trig;
		PauseSelf.kr(t_trig);
		Out.ar(out, SinOsc.ar(400,0,0.2));
	}).send(s);
	)
	
	s.sendMsg("/s_new", "pauseSelf-help", 1731);
	s.sendMsg("/n_set", 1731, \t_trig, 1);
	s.sendMsg("/n_run", 1731, 1);
	s.sendMsg("/n_set", 1731, \t_trig, 1);
	s.sendMsg("/n_free", 1731);

