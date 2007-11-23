
Platform

superclass: Object

Platform is an abstract class encapsulating various platform dependent constants and properties, such as directories, primitive features and startup files. The platform object is accessible through the 'platform' method of the main process instance:

thisProcess.platform

Platform name and platform dependent actions

name - returns the platform name

*case(... cases)

	perform actions depending on the current platform (name), just like Object:switch:

	Platform.case(
		\osx,		{ "OSX".postln },
		\linux,		{ "Linux".postln },
		\windows, 	{ "Windows".postln }
	);

Directories and filesystem stuff

classLibraryDir
*classLibraryDir			- location of the bundled class library

helpDir
*helpDir					- location of the bundled help files

systemAppSupportDir
*systemAppSupportDir		- system application support directory

userAppSupportDir
*userAppSupportDir		- user application support directory

systemExtensionDir
*systemExtensionDir		- system extension directory (see Using-Extensions)

userExtensionDir
*userExtensionDir			- user extension directory (see Using-Extensions)

platformDir
*platformDir				- platform specific directory for class files (see Using-Extensions)

pathSeparator
*pathSeparator			- platform specific path separator

Startup files

startupFiles				- files to be loaded on startup
loadStartupFiles			- (re)load startup files

Features

Features are abstract symbols that can be declared by extension authors and be checked during runtime in user code. Apart from explicitly declared features, class and primitive names are implicitly declared.

declareFeature(aSymbol)

	Declare aSymbol to be a feature present in the runtime. Class names and primitive names cannot be declared as features.

hasFeature(aSymbol)

	Return true if the feature aSymbol is present in the runtime system. aSymbol can refer to explicitly declared features as well as class and primitive names.
	
	thisProcess.platform.hasFeature(\Object);
	thisProcess.platform.hasFeature('_SCWindow_BeginFullScreen');
	thisProcess.platform.hasFeature('_myFuncyPrimitive');
	
	thisProcess.platform.declareFeature('superCrazyCompositionSystem');
	thisProcess.platform.hasFeature('superCrazyCompositionSystem');

when(features, ifFunction, elseFunction)
*when(features, ifFunction, elseFunction)

	Evaluate ifFunction if all features are present, otherwise evaluate elseFunction.
	
	Platform.when(#[\Document, \SCWindow], { "yeehah!".postln });


