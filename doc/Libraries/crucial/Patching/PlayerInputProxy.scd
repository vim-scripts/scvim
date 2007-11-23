
PlayerInputProxy

		represents an audio or control input for a player that is to be dynamically
		patchable at runtime.
		eg. 	an input to an effect.
			a potential controller/interface input
		
	PlayerInputProxy(spec)
			
	p = Patch({ arg audio,ffreq;
		RLPF.ar(audio,ffreq)
	},[
		PlayerInputProxy.new
	]);
	
	it holds the place. if the patch is played, it is silent. 
	
	p.play
	
	other classes can detect these inputs and patch into them.
	
	
	
	
	




notes:

/*

XFadeEfxFunc.new("Patches/breaks/felaoopkunnzz",
	Patch.new([ 'efxFilters3', 'combN' ], [
		PlayerInputProxy.new,
		StreamKrDur.new(PbrownGUI.new(600, 1000, 100, inf), 8, 1), -0.02 ]
	),
	0.5,
	1,
 	1)
	
*/

the XFadeEfxFunc would know numChannels and rate of input,
 and sets it on the PlayerInputProxy

 so pip can save blank

 if pip is played (silent), it has defaults and would play it as mono

 	PlayerInputProxy.new.play


 if the channels changes while playing, it would have to respawn








