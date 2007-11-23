
PathName			file and directory path utilities				

superclass: Object

PathName is a utility Class for manipulating file names and paths.
It expects a path to a file, and lets you access parts of that file path.

Creation

*new(path)

path is a String which likely contains one or more / as typical for folder separation.

PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");

~ will be converted to your fully addressed home directory. Symbolic Links will be expanded, as per String-standardizePath.

Class Methods

tmp
tmp_(aPath)

Get or set the global temp directory as a String. This is used by Buffer, etc. By default this is "/tmp/" for Linux and OSX, and "/WINDOWS/TEMP/" for Windows.

Instance Methods

fileName

returns just the name of the file itself; i.e.
everything after the last slash in the full path.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.fileName.postln;
)

pathOnly

returns the full path up to the file name itself; i.e.
everything up to and including the last slash.
This is handy e.g. for storing several files in the same folder.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.pathOnly.postln;
)

isRelativePath
isAbsolutePath
asRelativePath
	you MUST have correctly initialized the scroot classvar for this
	to know what it is relative to !


folderName

returns only the name of the folder that the file is in;
i.e. everything in between the last but one and the last slash.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.folderName.postln;
)


fullPath
returns the full path name that PathName contains.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.fullPath.postln;
)

allFolders

returns a list of all the folder names in the pathname.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.allFolders.postln;
)

diskName
if path is an absolute path, returns the disk name; else a blank string.

(
var myPath;
myPath = PathName.new("MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.diskName.postln;
)

( // note the / at the start
var myPath;
myPath = PathName.new("/MyDisk/SC 2.2.8 f/Sounds/FunkyChicken");
myPath.diskName.postln;
)

endNumber
returns a number at the end of PathName.
Returns zero if there is no number.

PathName("floating1").endNumber.postln;

PathName("floating").endNumber.postln;

noEndNumbers
returns fullPath without any numbers at the end.

PathName("floating1").noEndNumbers.postln;

PathName("floating").noEndNumbers.postln;


nextName
generates a sensible next name for a file
by incrementing a number at the end of PathName,
or by adding one if there is none.


PathName("floating34").nextName.postln;

PathName("floating").nextName.postln;

PathName("floating12_3A4X_56.7").nextName.postln;

This is useful for recording files with consecutive names,
and e.g. to generate a new filename when you don't want to
overwrite an existing file with the current name.


Here is an example that uses many instance methods.
Just pick any file to see all the parts of its path.

/*
(
GetFileDialog.new(
	{ arg ok, path;
	var myPathName;
	if (ok,
		{
			 myPathName = PathName.new(path);
	
			 "New PathName object/  ".postc;
			 myPathName.postln;
			
			 "fileName only/  ".postc;
			 myPathName.fileName.postln;
			
			 "path up to file only/  ".postc;
			 myPathName.pathOnly.postln;
			
			 "folder Name/  ".postc;
			 myPathName.folderName.postln;
		}
	)
	}
)
)


Choose a soundfile to put into the library,
using its foldername and filename/

(
GetFileDialog.new(
	{ arg ok, path;
	var myPathName, myFile;
	if (ok,
		{
			myPathName = PathName.new(path);
			
			// read your file from disk, e.g. a soundFile/
			
			myFile = SoundFile.new;	
			if (myFile.readHeader(path),
				{	
					Library.put(
						[ myPathName.folderName.asSymbol, myPathName.fileName.asSymbol ],
						myFile);
					("Check LibMenu/ " ++ myPathName.folderName ++ " please.").postln;
				},
				{ ("Could not read soundfile " ++ path ++ ".").postln; }
			);
		}
	)
	}
)
)


Save three tables in the same folder:
Note: The file name chosen in the dialog is ignored!
The files are always named table1, table2, table3.
(
var table1, table2, table3;

table1 = Wavetable.sineFill(1024, [1,2,3]);
table2 = Signal.newClear.asWavetable;
table3 = Wavetable.sineFill(1024, Array.rand(64, 0.0, 1.0));

PutFileDialog.new(
	"Pick a folder for tables1-3/", "table1",
	{ arg ok, path;
	var myPathName, myPathOnly;
	if (ok,
		{
			myPathName = PathName.new(path);
			
			myPathOnly = myPathName.pathOnly;
			
			table1.write(myPathOnly ++ "table1");
			table2.write(myPathOnly ++ "table2");
			table3.write(myPathOnly ++ "table3");
		}
	)
	}
)
)


*/



