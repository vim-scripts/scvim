
PV_PhaseShift				shift phase of all bins

PV_PhaseShift(buffer, shift)

buffer - fft buffer.
shift - phase shift in radians.

See also FFT Overview.

Server.default = s = Server.internal; s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
)

(
{
	var in, chainA, chainB;
	in = SinOsc.ar(500);
	chainA = FFT(b.bufnum, in);
	chainB = PV_Copy(chainA, c.bufnum);
	chainB = PV_PhaseShift(chainB, pi); // shifted by 180 degrees
	0.5 * IFFT([chainA, chainB]); // normal, shifted
}.scope;
)

(
{
	var in, chain;
	in = SinOsc.ar(500);
	chain = FFT(b.bufnum, in);
	chain = PV_PhaseShift(chain, LFNoise2.kr(1, 180, 180));
	Out.ar(0, 0.5 * IFFT(chain).dup); 
}.scope;
)

b.free; c.free;


