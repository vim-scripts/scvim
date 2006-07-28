Creating Stand-Alone Applications

Contents

Introduction
Creating a stand-alone application using the Finder
Creating a stand-alone application using Xcode
Adding your own behavior

Introduction

On OS X, applications are special directories known as "bundles." This allows you to create stand-alone applications running SuperCollider code that are opaque, in the sense that the user does not need to install SuperCollider, run SuperCollider code, or even know that SuperCollider is involved. (Of course, your application must be open-source and comply with the GPL.) This is useful for distributing applications to the general public, or for creating special-purpose applications for your own use.

Creating a stand-alone application using the Finder

Step 1: Make a copy of the SuperCollider application, and name it whatever you'd like your application to be called. Then control-click on the copy and select "Show Package Contents" from the contextual menu. You'll get a new Finder window that shows you the inside of the application bundle. Navigate to Contents/Resources. This is where the folders that normally reside outside the SuperCollider application will go.

Step 2: Option-drag the following items into the Resources folder as needed:

 ? SCClassLibrary--this is absolutely necessary, and of course can contain your own classes.
 ? plugins--your application will launch without this, but you won't get very far making sound.
 ? recordings--not necessary if your application does not allow recording, or if you have the user select the recording directory.
 ? sounds--if your application requires any preexisting soundfiles, put them here.
 ? synthdefs--not absolutely necessary, but very handy.
 ? Help--if your users aren't dealing with SuperCollider code, they don't need the SuperCollider help files, but you should create a Help.help.rtf file for your own application and put it in here.
 ? If you want your application to be able to use the local server, drag in scsynth. This is not recommended for most applications, though; see Adding your own behavior, below.

Step 3: Edit MainMenu.nib by double-clicking on it. It will in open in InterfaceBuilder, presenting you with a "virtual" menubar that you can modify as you wish (deleting the Help menu, for example). The exception is the name of the application menu ("SuperCollider")--you can change it here, but the change will not be picked up by the application. See step 4.

Step 4: Edit English.lproj/InfoPlist.strings, replacing "SuperCollider" with the name of your application in the CFBundleName line. This will show up in your application's main menu.

Now you have an application that behaves exactly like SuperCollider, but is entirely self-contained (can be dragged anywhere with no accompanying files) and has its own name. To make it behave like an ordinary application (with its own main window, etc.), see Adding your own behavior below.

Now when you launch the copy, it will use the items you dragged in (and any modifications of the class library will be stored there instead of the original). You can drag it anywhere, give it to other people, etc.

Creating a stand-alone application using Xcode

In the SuperCollider source, there's an Xcode project called xSC_StandAlone. This is an Xcode 2.1 project, and will not open in earlier versions. It has two targets: 

 ? SC_StandAlone. This creates a simple but complete application in its final form.
 ? SC_StandAlone_Devel. This creates a development version of the same application, the differences being that Main-startup is not modified, so that the server and post windows are created, and that an alias of its class library is used, so that any modifications are made to the original in the code folder, rather than in the bundle.
 
To create your own application:

Step 1: Make a copy of the SCSA_Aux folder (inside the SuperCollider3 folder), and name it after your application (e.g. MyApp_Aux). Change the names of all its subfolders similarly. Edit the MainMenu.nib and English.lproj/InfoPlist.strings files in both MyApp_Resources and MyApp_Devel_Resources as described in the previous section.

Step 2: Make a copy of the xSC_StandAlone project, name it after your application, and open it in Xcode. Delete the SCSA_Resources and SCSA_Devel_Resources groups (choosing Delete References Only at the dialog), and add MyApp_Resources and MyApp_Devel_Resources to the SC_StandAlone and SC_StandAlone_Devel targets, respectively (selecting the Recursively Add Groups option in the dialog). Make sure you're adding them to the right targets.

Delete the SCSA_Library folder (choosing Delete References Only at the dialog), and add MyApp_Library in its place, selecting the Create Folder option (it should show up as a blue folder instead of a yellow one). Drag it to the Copy Files build phase of the SC_StandAlone target. You don't need to add it to the SC_StandAlone_Devel target.

Step 3: Rename the the SC_StandAlone_Devel target to MyApp_Devel (by control-clicking on the target icon and selecting "Rename" from the contextual menu). Double-click on the MyApp_Devel target. In the Base Product Name field, change "SC_StandAlone_Devel" to "MyApp_Devel". Do the same thing in the Info.Plist Entries section. Click the Run Script box. In the script that appears, replace SCSA with MyApp wherever it appears (three times).

Step 4: Repeat step 3 for the SC_StandAlone target (leaving off _Devel, of course).

Step 5: Build away!

Adding your own behavior

Using either of the above methods, you've created an application that behaves exactly like SuperCollider. To run your own code on launch and simulate an ordinary application rather than a development environment, you'll need to modify Main-startup. Here's an example (the same code used by the SC_StandAlone target):

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
// Server.internal.makeWindow;
// Server.local.makeWindow;
 
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
// "~/scwork/startup.rtf".loadPaths;

The class SCSA_Demo contains the entire application, including the main window. This is the tidiest way to work, and requires the least modification to SuperCollider. If you don't want to write a class, you can execute an .rtf file instead:

interpreter.executeFile(String.scDir ++ "/myapp.rtf");

However, any sizable application will benefit from encapsulation in classes.

Note that the example uses the internal server. This is part and parcel of keeping the application stand-alone; it shouldn't call extraneous processes behind the user's back that will persist if the application fails. If you need to use the local server for some reason, make sure scsynth is in the application's bundle.
