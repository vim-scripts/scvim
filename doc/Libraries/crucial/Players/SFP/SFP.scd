
SFP  						sound file player


SFP.new(path,tempo,firstBeatIsAtFrame)

SFP plays long sound files from disk. It is not a sample player, it is to be used for playing recordings and long sound files.

Paths should be either fully specified or
if a relative path is used it will be relative to the classvar :

AbstractSFP.dir

which by default is "~/SoundFiles/"

so test.aiff will be determined internally by using the standardizePath method:

SFP.standardizePath("test.aiff")

for me this would result in :

/Users/cruxxial/SoundFiles/test.aiff

You may set the AbstractSFP.dir = "wherever you want it"
in your startup.rtf file.

or you may simply fully specify your paths.

(

SFP.getNew({ arg v;
	Sheet({ arg layout;
		v.topGui(layout);
	})
})

)


(
// no path supplied
// click on the path (which is nil) to browse for a file
SFP.new.gui
)

see also VSFP




