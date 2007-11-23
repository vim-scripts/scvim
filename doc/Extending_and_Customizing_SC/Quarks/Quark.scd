
Quark

see Quarks first

A Quark is a package of SC classes, helpfiles, C++ source for UGens and other SC code.

A Quark object is created from the quark file found in {Application Support}/quarks/DIRECTORY

It contains basic information about the package:

name
summary
version
author
dependencies
tags
path

Of particular importance for the Quarks interface class is the PATH. This path is relative to the quark directory and usually is simply the name of the folder, which should by convention be the same as the name of the quark. However, you may put quarks inside a top-level folder for clarity. 

It may even be possible to nest quarks inside of quarks (a kind of aggregate package), though a better way to do that would be to define a basically empty quark (the aggregate) and specify the other sub quarks as dependencies.

These Quark objects are mostly used just by the Quarks class, and you usually don't need to deal with them at all.

But you do need to make the quark file :

Format of the .quark File

// a quark file contains a dictionary containing all needed and un-needed information on the particular quark. 

(
// a must:
	\name: 		"theName",
	\path: 		"path/relative/to/quark/dir",
	\summary:		"A human readable explanation on the purposes of this quark.\nThis will be visible in Quarks.listInstalled",
	\author: 		"My Name",

// optional:
	\version:		1.0, // must be a float
	\organization: 	"My Organization",
	\country: 		"My Country",
	\since: 		"2004",
	\helpdoc: "theName.html",
	\ext_dependancy: "Information on additional software needed to run this quark properly",
	\url:      "http://www.strangeQuark.de",

// If the quark depends on other quarks, you can specify it as a list containing:
// (1) strings (just the quark name)
// (2) key->value pairs (name->version)
// or (3) arrays with info in this order: [name, version, repositoryBaseUrl]

//	\dependencies: [["nameOfDependantQuark", 1.0, "https://svn.weirdserver.be/trunk/weirdquarks"]],
//	\dependencies: [("nameOfDependantQuark" -> 1.0)],
	\dependencies: "nameOfDependantQuark"
)

Please test that you don't have any syntax errors in your quark file before commiting it.
Thank you.


