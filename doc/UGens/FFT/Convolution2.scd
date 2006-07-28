Convolution2 real-time convolver

Convolution2.ar(in, bufnum, trigger, framesize, mul, add)

Strict convolution with fixed kernel which can be updated using a trigger signal.

//see ch18 "http://www.dspguide.com/ch18.htm" Steven W Smith

in - processing target
bufnum - buffer index for the fixed kernel, may be modulated in combination with the trigger
trigger - update the kernel on a change from <=0 to >0
framesize - size of FFT frame, must be a power of two. Convolution uses twice this number internally, maximum value you can give this argument is 2^16=65536. Note that it gets progressively more expensive to run for higher powers! 512, 1024, 2048, 4096 standard. 



(//allocate three buffers
b = Buffer.alloc(s,2048);
c = Buffer.alloc(s,2048);
d = Buffer.alloc(s,2048);

b.zero;
c.zero;
d.zero;
)

(
50.do({ |it| c.set(20*it+10, 1.0.rand); });
3.do({ |it| b.set(400*it+100, 1); });
20.do({ |it| d.set(40*it+20, 1); });
)


(
SynthDef( "conv-test", { arg kernel, trig=0;
 var input;
 
 input=Impulse.ar(1);

 //must have power of two framesize
 Out.ar(0,Convolution2.ar(input,kernel,trig,2048, 0.5));
}).send(s)

)


x = Synth.new("conv-test",[\kernel,b.bufnum]);

// changing the buffer number:
x.set(\kernel,c.bufnum);
x.set(\trig,0);
x.set(\trig,1); // after this trigger, the change will take effect.
x.set(\kernel,d.bufnum);
x.set(\trig,0);
x.set(\trig,1); // after this trigger, the change will take effect.

d.zero;
40.do({ |it| d.set(20*it+10, 1); });// changing the buffers' contents
x.set(\trig,0);
x.set(\trig,1); // after this trigger, the change will take effect.

x.set(\kernel,b.bufnum);
x.set(\trig,0);
x.set(\trig,1); // after this trigger, the change will take effect.



////next example

b = Buffer.read(s,"sounds/a11wlk01.wav");

(
 { var input, kernel;
 
 input=AudioIn.ar(1);

 //must have power of two framesize
 Out.ar(0,Convolution2.ar(input,b.bufnum,0,512, 0.5));
 }.play;

)


//another example

(
//must have power of two framesize- FFT size will be sorted by Convolution2 to be double this
//maximum is currently a=8192 for FFT of size 16384
a=2048;
s = Server.local; 
//kernel buffer
g = Buffer.alloc(s,a,1);
)

(
g.set(0,1.0);
100.do({arg i; g.set(a.rand, (i+1).reciprocal)});
)

(
//random impulse response

 {
 var input,inputAmp,threshhold,gate;

input = AudioIn.ar(1); 
inputAmp = Amplitude.kr(input);
threshhold = 0.02; // noise gating threshold
gate = Lag.kr(inputAmp > threshhold, 0.01); 
 
 Out.ar(0,Convolution2.ar(input*gate,g.bufnum,0, a, 0.5));
 }.play;

)






//one last example
(
b = Buffer.alloc(s, 512, 1);
b.sine1(1.0/[1,2,3,4,5,6], true, true, true);
)

(
 { var input, kernel;
 
 input=AudioIn.ar(1);

 //must have power of two framesize
 Out.ar(0,Convolution2.ar(input,b.bufnum,0, 512, 0.5));
 }.play;

)
