
PlayerEffectSocket

hot swappable effects layer

there is no crossfading or envelopes built into this. the mix is always 100% wet.
it is meant as a raw component that a more sophisticated switcher can use.



not working yet...


	s = Server.local;
	s.boot;
	
	// play on a private bus
	p = Patch({ Saw.ar * 0.2 });
	b = Bus.audio(s);
	p.play(bus: b);

	// read from that bus and play main out
	e = PlayerEffectSocket.new;
	e.setInputBus(b);
	e.play;
	// but no effect is playing yet, so no sound
		
	// prepare some effects
	f = Patch({ arg audio,ffreq=300,rq=0.3;
			RLPF.ar(audio,ffreq,rq)
		});
	g = Patch({ arg audio,ffreq=300,rq=0.3;
			RHPF.ar(audio,ffreq,rq)
		});
	f.prepareForPlay;
	g.prepareForPlay;
	
	
	e.setSource(f);
	
	e.setSource(g);
	
	// if you haven't prepared them
	e.prepareAndTrigger(
		Patch({ arg audio;
			Median.ar(11,audio)
		})
	);
	
	e.insp

Even if you have prepared the players, they are spawned in a subgroup of the group the PlayerEffectSocket is playing on, and the bus the PlayerEffectSocket is assigned to.

You can also use
	e.preparePlayer(f);
	e.preparePlayer(g);
which will directly prepare them for the right group and bus.
	
	
	// note PlayerInputProxy on first input
	f.insp
	g.insp
	
setSource finds the first PlayerInputProxy in the Patch and sets its input bus.


	
	

