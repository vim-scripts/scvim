
playN

is a multichannel play method for Monitors and NodeProxies
that supports playing proxy outputs over non-adjacent channels;
somewhat like a splitter/line mixer.

Server.default = s = Server.internal;
s.boot;

p = ProxySpace.push;
s.scope(8);

	// a 3 channel test sound
~test3 = { SinOsc.ar([2, 3, 5] * 100) * 0.2 };

	// compare: play out of 3 adjacent channels
~test3.play(3);
~test3.play(6);

~test3.stop;
~test3.play;	// play remembers old (series) output settings;


	// outs
~test3.playN([2, 4,7]) // playN to 3 non-adjacent channels

	// set outs, amps and vol:
(
~test3.playN(
	outs: [2,3,5],
	amps: [0.5, 0.25, 0.125],
	vol: 1
);
)
~test3.vol_(2);

~test3.stop;
~test3.playN;	// remembers last state.

		// set outs while playing.
		// note: this does not work reliably with play method!
~test3.monitor.outs_([3,2,1]);	

		// set amps while playing.
		// note: this does not work with play method!
~test3.monitor.amps_(1/[1, 2, 3]).vol_(1);	
~test3.playN;	
~test3.monitor.outs_([2, 4, 7]);	


	// you can also spread out one chan to several:
(
~test3.playN(
	outs: [1, 3, [5,6,7]],
	amps: [0.5, 0.25, [0.125,0.25, 0.5]],
	vol: 2
);
)

~test3.stop;
~test3.playN;	

		// do changes while off:
~test3.stop;
~test3.monitor.outs_([2, 4, [5,6,3]]);	
~test3.monitor.amps_(1/[1, 2, [3,2,1]]);	
~test3.playN;	
		
		// most comfortable way to edit - mac only:
~test3.playNDialog;



