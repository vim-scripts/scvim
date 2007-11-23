
IndexInBetween		

IndexInBetween.ar(bufnum, in, mul, add)
IndexInBetween.kr(bufnum, in, mul, add)



bufnum - index of the buffer
in - the input signal.



(
// autotune.
s = Server.local;
t = ([0, 1, 3, 4, 7, 11, 12] + 70).midicps;
b = Buffer(s, t.size, 1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ).postln );

{
	var index, in, out, f0, fdiff;
	var bufnum = b.bufnum;
	in = Pulse.ar(MouseX.kr(t.minItem, t.maxItem)) * 0.1;
	f0 = Pitch.kr(in).at(0);
	index = IndexInBetween.kr(bufnum, f0);
	fdiff = index.frac * (Index.kr(bufnum, index + 1) - Index.kr(bufnum, index));
	out = PitchShift.ar(in, 0.1, 1 - (fdiff / f0), 0.01, 0.01);
	RLPF.ar(out, [2000, 5000], 0.3)
}.play;
)

b.free;


// basic test.
(

s = Server.local;
t = [ 200, 210, 400, 430, 600, 800 ];
b = Buffer(s, t.size, 1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ).postln );


{
	var index, f0, f1, f3;
	var bufnum = b.bufnum;
	f0 = MouseX.kr(200, 900);
	index = IndexInBetween.kr(bufnum, f0);
	f1 = IndexL.kr(bufnum, index);
	SinOsc.ar([f0, f1]) * 0.1
	
}.play;
)

b.free;




