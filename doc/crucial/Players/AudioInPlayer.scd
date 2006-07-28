AudioInPlayer


Plays the first two channels of your Audio input.

AudioInPlayer(numChannels,firstChannel)
 firstChannel - starting at 0
 
 AudioInPlayer.new.play

 AudioInPlayer.new.gui

watch the feedback


(

Instr([\audioIn,\filter],{ arg audio,ffreq=400,rq=0.1,amp=0.1;
 RLPF.ar( audio, ffreq, rq) * amp
});

Patch([\audioIn,\filter],[
 AudioInPlayer.new
]).gui

)