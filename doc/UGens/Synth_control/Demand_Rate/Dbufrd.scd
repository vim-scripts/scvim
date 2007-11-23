
Dbufrd		 buffer demand ugen

superclass: UGen


*new(bufnum, phase, loop)
	
bufnum	buffer number to read from
phase	index into the buffer (demand ugen or any other ugen)
loop		when phase exceeds number of frames in buffer, loops when set to 1 (default :1)
	
	

// example

b = Buffer.alloc(s, 24, 1);
b.setn(0, { exprand(200, 500) } ! b.numFrames);
b.getn(0, b.numFrames, {|x| x.postln })

(
{var indexPattern;
	indexPattern = Dseq([Dseq([0, 3, 5, 0, 3, 7, 0, 5, 9], 3), Dbrown(0, 23, 1, 5)], inf);
	SinOsc.ar(
		Demand.kr(Dust.kr(10), 0, Dbufrd(b.bufnum, indexPattern))
	) * 0.1
}.play;
)

// buffer as a time pattern

c = Buffer.alloc(s, 24, 1);
c.setn(0, { [1, 0.5, 0.25].choose } ! c.numFrames);
c.getn(0, c.numFrames, {|x| x.postln })

(
{var indexPattern;
	indexPattern = Dseq([Dseq([0, 3, 5, 0, 3, 7, 0, 5, 9], 3), Dbrown(0, 23, 1, 5)], inf);
	SinOsc.ar(
		Duty.kr(
			Dbufrd(c.bufnum, Dseries(0, 1, inf)) * 0.5,
			0,
			Dbufrd(b.bufnum, indexPattern)
		)
	) * 0.1
}.play;
)

// free buffers

b.free; c.free;





