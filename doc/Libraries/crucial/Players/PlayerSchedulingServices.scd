

Player Scheduling Services


more to come....


j = loadDocument("Patches/cheapSamples/jayz");
r = "Patches/cheapSamples/techverb".loadDocument;

j.gui
r.gui

j.prepareForPlay;
r.prepareForPlay;


// dead on
j.spawnAtTime(BeatSched.tdeltaTillNext(4.0));
r.spawnAtTime(BeatSched.tdeltaTillNext(4.0));

r.stop;

// restart
r.spawnAtTime(BeatSched.tdeltaTillNext(4.0));



