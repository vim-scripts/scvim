VSFPvari-speed sound file player

This is for playing long soundfiles from disk. This is not a sample player.

VSFP(path);

pchRatio_ set the pchRatio of playback
*getNew browse for a file, make a VSFP with it and pass it into the function

(
v = VSFP(path/to/file);
v.play;
v.pchRatio = 0.4;
v.pchRatio = 1.9;
)


(

VSFP.getNew({ arg v;
 Sheet({ arg layout;
 v.topGui(layout);
 NumberEditor(1.0,[0.01,32.0])
 .action_({ arg value; v.pchRatio = value; })
 .gui(layout)
 })
})

)



It can't go backwards yet, but its not impossible.
