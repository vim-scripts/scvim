VarSaw

variable duty saw


play({
 VarSaw.ar(
 LFPulse.kr(3, 0, 0.3, 200, 200), 
 0, 
 LFTri.kr(1.0).range(0,1), //width
 0.1) 
});


play({ VarSaw.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1) });

compare:

play({ LFPulse.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1) });
