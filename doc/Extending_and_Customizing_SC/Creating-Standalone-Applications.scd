

Creating Standalone Applications

Introduction

On OS X, applications are special directories known as "bundles." This allows you to create stand-alone applications running SuperCollider code that are opaque, in the sense that the user does not need to install SuperCollider, run SuperCollider code, or even know that SuperCollider is involved. (Of course, your application must be open-source and comply with the GPL.) This is useful for distributing applications to the general public, or for creating special-purpose applications for your own use.

Creating a standalone application

1- Open the Language.xcodeproj project in Xcode.

2- Rename the "Standalone Template" target by control-cliking it and choosing "Rename". This target name is used for both the .app name and for the name presented in the menu bar.



3- Customize the "Standalone Resources" directory, which is located at the root of the SuperCollider source directory. Any files you put in this directory will overide the files placed in the standalone application. For example if you wanted to create your own version of Array.sc you would need to create the following path (creating folders where necessary):
	Standalone Resources/SCClassLibrary/Common/Collections/Array.sc
	
Your version of Array.sc will now overide the default. Similarly you can replace application resources to customize your application. "Standalone Resources/SCcube.icns" can be overridden to provide a custom icon. "Standalone Resources/English.lproj/MainMenu.nib" can be overriden to provide a custom menu bar and "Standalone Resources/English.lproj/Credits.rtf" can be overidden to provide a new about box. The "Standalone Resources" directory by default comes with a small demo application that puts up a window with a button that generates a tone when pushed.

4- Build the standalone application by control-clicking on the target and choosing "Build [target name]". This will place your standalone app in the build directory. It is recommended that you develop your application fully in a normal SuperCollider environment before creating a standalone application.



Adding your own behavior

You've now created an application that behaves exactly like SuperCollider. To run your own code on launch and simulate an ordinary application, you'll need to modify Main-startup. Here's an example (the same code used by the SC_StandAlone target):

	startup {
		super.startup;
		
		Document.startup;
		
		// set the 's' interpreter variable to the internal server.
		// You should use the internal server for standalone applications--
		// otherwise, if your application has a problem, the user will
		// be stuck with a process, possibly making sound, that he won't know
		// how to kill.
		interpreter.s = Server.internal;
		
		// server windows turned off for stand-alone application
		//Server.internal.makeWindow;
		//Server.local.makeWindow;
		
		// Start the application using internal server
		interpreter.s.waitForBoot({
			var sb, demo;
			sb = SCWindow.screenBounds;
			
			demo = SCSA_Demo.new(
				"the cheese stands alone",
				Rect(
					(sb.width - SCSA_Demo.width) * 0.5,
					(sb.height - SCSA_Demo.height) * 0.5,
					SCSA_Demo.width,
					SCSA_Demo.height
				),
				interpreter.s
			);
			demo.front;
			// Close post window after application launches. If you want
			// to hide it completely, put this line after Document.startup instead.
			Document.closeAll(false);
		}, 25);
				
		// You probably don't want to include this, since the user won't have it
		//"~/scwork/startup.rtf".loadPaths;

The class SCSA_Demo contains the entire application, including the main window. This is the tidiest way to work, and requires the least modification to SuperCollider. If you don't want to write a class, you can execute an .rtf file instead:

interpreter.executeFile(String.scDir ++ "/myapp.rtf");

However, any sizable application will benefit from encapsulation in classes.

Note that the example uses the internal server. This is part and parcel of keeping the application stand-alone; it shouldn't call extraneous processes behind the user's back that will persist if the application fails. If you need to use the local server for some reason, make sure scsynth is in your resources folder.

Managing multiple standalone applications

To manage several standalone applications simply create several targets and several resources directories. The resources directories should be named according to "[target name] Resources". If a resources directory is found when building that matches the target name, that directory will be used instead than the default "Standalone Resources" directory.


