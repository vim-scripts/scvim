Speech

Speech lets you use the cocoa speech synthesizer.


"hi i'm talking with the default voice now, i guess".speak;


First argument is always the voice channel number, second the value

 Speech.setSpeechVoice(0,14);
 Speech.setSpeechPitch(0, 40); //pitch in MIDI Num
 Speech.setSpeechRate(0, 10);
 Speech.setSpeechVolume(0,0.8);
 Speech.setSpeechPitchMod(0, 200);

Two actions can be applied:

Speech.wordAction = {arg voiceNum;
 //i.postln;
 // the currently speaking text may not be changed
 //Speech.setSpeechPitch(voiceNum,[41,60].choose);
 //Speech.setSpeechRate(voiceNum,[60,80, 10].choose);
};
Speech.doneAction_({arg voiceNum;
 Speech.setSpeechPitch(voiceNum,[41,48,40,43,30,60].choose);
});

Pause the speech while speaking: 1=pause, 0= start

Speech.pause(0,1);

Initialization happens automatically, by default with one voice channel.
You may explicitly initalize with more channels, up to 128:


(
Speech.init(64);

Task({
 64.do ({arg i;
 [0.1, 0.18, 0.2].choose.wait;
 Speech.setSpeechRate(i,[90, 30, 60].choose);
 Speech.setSpeechVolume(i,0.07);
 "no this is private. float . boolean me. char[8] ".speak(i);
 });
}).play;
)

//jan.t@kandos.de 04/2003





