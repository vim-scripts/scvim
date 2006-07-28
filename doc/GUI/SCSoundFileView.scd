SCSoundFileView


(
w = SCWindow.new("soundfile test", Rect(200, 200, 800, 400));
a = SCSoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
f.inspect;

a.soundfile = f;
a.read(0, f.numFrames);
a.elasticMode = true;

a.timeCursorOn = true;
a.timeCursorColor = Color.red;
a.timeCursorPosition = 2050;
a.drawsWaveForm = true;
a.gridOn = true;
a.gridResolution = 0.2;

w.front;

)