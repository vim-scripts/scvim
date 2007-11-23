
PlayerAmp

scales the amplitude of the player

(

p = PlayerAmp(
	Patch({
		SinOsc.ar
	}),
	0.4
);

p.gui;

)


p.amp = 0.2;

p.amp = 1.0;





