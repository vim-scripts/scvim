
FreeSelf			when triggered, free enclosing synth

superclass: UGen

	
	free enclosing synth when input signal crosses from non-positive to positive
	
	*kr(src) src - input signal

	//example
	
	(
	SynthDef("freeSelf-help", {arg out, t_trig;
		FreeSelf.kr(t_trig);
		Out.ar(out, SinOsc.ar(400,0,0.2));
	}).send(s);
	)
	
	s.sendMsg("/s_new", "freeSelf-help", 1731);
	s.sendMsg("/n_set", 1731, \t_trig, 1);

	// a single impulse SynthDef:
	
	(
	SynthDef("dirac", {arg out, amp=0.1;
		var u;
		u = Impulse.ar(1);
		FreeSelf.kr(u);
		Out.ar(out, u * amp);
			// multiply by amp after using for release, so amp = 0
			// doesn't cause synth buildup.
	}).send(s);
	)
	
	(
	Task {
		loop({
			fork {
				exprand(34, 156).do {|i|
					i = i + 1;
					s.sendMsg("/s_new", "dirac", -1,0,0, \amp, 1 / i);
					(0.006 * i).wait;
				};
			};	
			1.wait;
		})
	} .play;
	)
	

