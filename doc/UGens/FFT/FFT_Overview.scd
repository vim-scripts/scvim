FFT Overview

FFT and IFFT

SuperCollider implements a number of UGens supporting FFT based processing. The most basic of these are [FFT] and [IFFT] which convert data between the time and frequency domains:

FFT(buffer, input)
 IFFT(buffer)

FFT stores spectral data in a local buffer (see [Buffer]) in the following order: DC, nyquist, real 1f, imag 1f, real 2f, imag 2f, ... real (N-1)f, imag (N-1)f, where f is the frequency corresponding to the window size, and N is the window size / 2.

The buffer's size must correspond to a power of 2. The window size is equivalent to the buffer size, and the window overlap is fixed at 2. Both FFT and IFFT use a Welch window, the combination of which (i.e. Welch2) is a Hanning window.

Phase Vocoder UGens and Spectral Processing

In between an FFT and an IFFT one can chain together a number of Phase Vocoder UGens (i.e. 'PV_...') to manipulate blocks of spectral data before reconversion. The process of buffering the appropriate amount of audio, windowing, conversion, overlap-add, etc. is handled for you automatically.

 s = Server.local.boot;
 b = Buffer.alloc(s,2048,1);
 
 (
 SynthDef("help-randcomb", { arg out=0,bufnum=0;
 var in, chain;
 in = {WhiteNoise.ar(0.8)}.dup;
 chain = FFT(bufnum, in);
 chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4)); 
 Out.ar(out, IFFT(chain));
 }).play(s,[\out,0,\bufnum,b.bufnum]);
 )

PV Ugens write their output data in place, i.e. back into the same buffer from which they read. PV UGens which require two buffers write their data into the first buffer, usually called 'bufferA'.

 (
 b = Buffer.alloc(s,2048,1);
 c = Buffer.alloc(s,2048,1);
 d = Buffer.read(s,"sounds/a11wlk01.wav");
 )
 
 (
 SynthDef("help-magMul2", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
 var inA, chainA, inB, chainB, chain;
 inA = LFSaw.ar([100, 150], 0, 0.2);
 inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
 chainA = FFT(bufnumA, inA);
 chainB = FFT(bufnumB, inB);
 chain = PV_MagMul(chainA, chainB); // writes into bufferA
 Out.ar(out, 0.1 * IFFT(chain));
 }).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
 )

Note that PV UGens convert as needed between cartesian (complex) and polar representations, therefore when using multiple PV UGens it may be impossible to know in which form the values will be at any given time. FFT produces complex output (see above), so while the following produces a reliable magnitude plot:

 b = Buffer.alloc(s,1024);
 a = { FFT(b.bufnum, LFSaw.ar(4000)); 0.0 }.play;
 (
 b.getn(0, 1024, { arg buf;
 var z, x;
 z = buf.clump(2).flop;
 z = [Signal.newFrom(z[0]), Signal.newFrom(z[1])];
 x = Complex(z[0], z[1]);
 {x.magnitude.plot}.defer
 })
 )
 a.free;

any Synth using PV UGens might not.

PV UGens in the Standard Library

The following PV UGens are included in the standard SC distribution:

 [FFT] Fast Fourier Transform
 [IFFT] Inverse Fast Fourier Transform
 [PV_Add] complex addition
 [PV_BinScramble] scramble bins
 [PV_BinShift] shift and stretch bin position
 [PV_BinWipe] combine low and high bins from two inputs
 [PV_BrickWall] zero bins
 [PV_ConformalMap] complex plane attack 
 [PV_CopyPhase] copy magnitudes and phases
 [PV_Diffuser] random phase shifting
 [PV_HainsworthFoote]
 [PV_JensenAndersen]
 [PV_LocalMax] pass bins which are a local maximum
 [PV_MagAbove] pass bins above a threshold
 [PV_MagBelow] pass bins below a threshold
 [PV_MagClip] clip bins to a threshold
 [PV_MagFreeze] freeze magnitudes
 [PV_MagMul] multiply magnitudes
 [PV_MagNoise] multiply magnitudes by noise
 [PV_MagShift] shift and stretch magnitude bin position
 [PV_MagSmear] average magnitudes across bins
 [PV_MagSquared] square magnitudes
 [PV_Max] maximum magnitude
 [PV_Min] minimum magnitude
 [PV_Mul] complex multiply
 [PV_PhaseShift]
 [PV_PhaseShift270] shift phase by 270 degrees
 [PV_PhaseShift90] shift phase by 90 degrees
 [PV_RandComb] pass random bins
 [PV_RandWipe] crossfade in random bin order
 [PV_RectComb] make gaps in spectrum
 [PV_RectComb2] make gaps in spectrum
