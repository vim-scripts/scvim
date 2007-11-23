

Shaper		wave shaper

Shaper.ar(bufnum, in, mul, add)

Performs waveshaping on the input signal by indexing into the table.
bufnum - the number of a buffer filled in wavetable format containing the transfer function.
in - the input signal.

Server.default = s = Server.internal; s.boot;
b = Buffer.alloc(s, 512, 1, {arg buf; buf.chebyMsg([1,0,1,1,0,1])});
(
scope({
	Shaper.ar(
		b.bufnum,
		SinOsc.ar(300, 0, Line.kr(0,1,6)),
		0.5
	)
});
)



