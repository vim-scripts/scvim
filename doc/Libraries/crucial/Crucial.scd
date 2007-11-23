
Crucial

superclass: Object

If you are looking for the intro to the library, see [CRUCIAL-LIBRARY].

This class initializes some lightweight resources relevant to crucial library and loads some useful utilities into the Library (a shared dictionary of reusable functions).


Crucial.menu;

You can put this in Main if you like:

	run { // called by command-R
		Crucial.menu;
	}
	
	

You should set personal preferences in Main-startUp, as this file (Crucial.sc) will get overwritten
by CVS updates from time to time.	


In Main-startUp you can set:
	// you can move all of your documents to your home directory
	Document.dir = "~/Documents/SuperCollider/";	
		see Document
	
	Instr.dir = "~/Documents/SuperCollider/Instr/";
		see Instr
		
	// this would allow your sounds to be shared by other applications
	Sample.soundsDir = "~/Sounds/";
		see Sample
		// copy a11wlk01.wav to there for use in helpfiles !

	
	

everything is called in *initClass

	preferences: Colors, root paths.

	creates some useful common Specs

	installs some general use Library functions.

	see [Library]


	


