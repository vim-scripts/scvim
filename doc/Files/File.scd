
File

Superclass: UnixFILE

A class for reading and writing files. Not sound files.

see also the superclass for further docs.

	*new(pathname, mode)
	
		Create a File instance and open the file. If the open fails, isOpen will return false.
	
	pathname
	
		a String containing the path name of the file to open.
	
	mode
		a String indicating one of the following modes:
	
		"r" - read only text
		"w" - read and write text
		"a" - read and append text
		"rb" - read only binary
		"wb" - read and write binary
		"ab" - read and append binary
		
		"r+" - read only text
		"w+" - read and write text
		"a+" - read and append text
		"rb+" - read only binary
		"wb+" - read and write binary
		"ab+" - read and append binary
	
	open
	
		Open the file. Files are automatically opened upon creation, so this call is only necessary
		if you are closing and opening the same file object repeatedly.
	
		NOTE: it is possible when saving files with a standard file dialog to elect to "hide the extension"
		and save it as RTF. When opening the file you must specify the real filename: "filename.rtf",
		even though you can't see in file load dialogs or in the Finder.
	
	
	close
		Close the file.


	*exists(pathName)
		answers if a file exists at that path.
	
	
	*delete(pathName)
		deletes the file at that path.
		use only for good, never for evil.
	
	
	*openDialog(prompt,sucessFunc,cancelFunc)
	
		
	*saveDialog("hello",{},{})
		not yet implemented
	
	
	*getcwd
		POSIX standard 'get current working directory'.
	
		// example;
		File.getcwd
	
	*use(function)
		open the file, evaluate the function with the file and close it.
		
	readAllString
		Reads the entire file as a String.
		
	readAllStringRTF
		Reads the entire file as a String, stripping RTF formatting.

Examples:

// write some string to a file:
(
var f, g;
f = File("test","w");
f.write("Does this work?\n is this thing on ?\n");
f.close;
)

// read it again:
(
g = File("test","r");
g.readAllString.postln;
g.close;
)

// try the above with File.use:

File.use("test", "w", { |f| f.write("Doesn't this work?\n is this thing really on ?\n"); })
File.use("test", "r", { |f| f.readAllString.postln })


// more file writing/reading examples:
(
var h, k;
h = File("test2", "wb");
h.inspect;
h.write( FloatArray[1.1, 2.2, 3.3, pi, 3.sqrt] );
h.close;

k = File("test2", "rb");
(k.length div: 4).do({ k.getFloat.postln; });
k.close;
)


(
var f, g;
f = File("test3","w");
100.do({ f.putChar([$a, $b, $c, $d, $e, $\n].choose); });
f.close;

g = File("test3","r");
g.readAllString.postln;
g.close;

g = File("test3","r");
g.getLine(1024).postln;
"*".postln;
g.getLine(1024).postln;
"**".postln;
g.getLine(1024).postln;
"***".postln;
g.getLine(1024).postln;
"****".postln;
g.close;

)

(
//var f, g;
f = File("test3","wb");
f.inspect;
100.do({ f.putFloat(1.0.rand); });

f.inspect;
f.close;

g = File("test3","rb");
100.do({
	g.getFloat.postln;
});
g.inspect;
g.close;

)

(
//var f, g;
f = File("test3","r");
f.inspect;

f.getLine(1024).postln;

f.close;


)




