Convolution real-time convolver

Convolution.ar(in, kernel, framesize, mul, add)

Strict convolution of two continuously changing inputs. Also see [Convolution2] for a cheaper CPU cost alternative for the case of a fixed kernel which can be changed with a trigger message. 

//see ch18 "http://www.dspguide.com/ch18.htm" Steven W Smith

in - processing target
kernel - processing kernel. 
framesize- size of FFT frame, must be a power of two


(

 { var input, kernel;
 
 input=AudioIn.ar(1); 
 kernel= Mix.ar(LFSaw.ar([300,500,800,1000]*MouseX.kr(1.0,2.0),0,1.0));

 //must have power of two framesize
 Out.ar(0,Convolution.ar(input,kernel, 1024, 0.5));
 }.play;

)

(
//must have power of two framesize- FFT size will be sorted by Convolution to be double this
//maximum is currently a=8192 for FFT of size 16384
a=2048;
s = Server.local; 
//kernel buffer
g = Buffer.alloc(s,a,1);
)

(
//random impulse response
g.set(0,1.0);
100.do({arg i; g.set(a.rand, 1.0.rand)});


 { var input, kernel;
 
 input=AudioIn.ar(1); 
 kernel= PlayBuf.ar(1,g.bufnum,BufRateScale.kr(g.bufnum),1,0,1);
 
 Out.ar(0,Convolution.ar(input,kernel, 2*a, 0.5));
 }.play;

)