String

Superclass: RawArray

String represents an array of characters.
Strings can be written literally using double quotes:

"my string".class.postln;

Class Methods

*readNew(file)

Read the entire contents of a File and return them as a new String.

Instance Methods

at(index)

Strings respond to .at in a manner similar to other indexed collections. Each element is a Char.

"ABCDEFG".at(2).postln;

compare(aString)

Returns a -1, 0, or 1 depending on whether the receiver should be sorted before the argument,
is equal to the argument or should be sorted after the argument. This is a case sensitive compare.

< aString

Returns a Boolean whether the receiver should be sorted before the argument.

== aString

Returns a Boolean whether the two Strings are equal.

post

Prints the string to the current post window.

postln

Prints the string and a carriage return to the current post window.

postc postcln

As post and postln above, but formatted as a comment.

"This is a comment.".postcln;


postf

Prints a formatted string with arguments to the current post window. The % character in the format string is replaced by a string representation of an argument. To print a % character use \\% .

postf("this % a %. pi = %, list = %\n", "is", "test", pi.round(1e-4), (1..4))

this is a test. pi = 3.1416, list = [ 1, 2, 3, 4 ]

format

Returns a formatted string with arguments. The % character in the format string is replaced by a string representation of an argument. To print a % character use \\% .

format("this % a %. pi = %, list = %\n", "is", "test", pi.round(1e-4), (1..4))

this is a test. pi = 3.1416, list = [ 1, 2, 3, 4 ]


error

Prepends an error banner and posts the string

warn

Prepends a warning banner and posts the string.

inform

Posts the string.

++ aString

Return a concatenation of the two strings.

+ aString

Return a concatenation of the two strings with a space between them.

compile

Compiles a String containing legal SuperCollider code and returns a Function.

(
var f;
f = "2 + 1".compile.postln;
f.value.postln;
)

asCompileString

Returns a String formatted for compiling.

(
var f;
f = "myString";
f.postln;
f.asCompileString.postln;
)

postcs

As postln, but posts the compileString of the reciever

List[1, 2, ["comment", [3, 2]], { 1.0.rand }].postcs;

interpret

Compile and execute a String containing legal SuperCollider code, returning the result.

"2 + 1".interpret.postln;

interpretPrint

Compile, execute and print the result of a String containing legal SuperCollider code.

"2 + 1".interpretPrint;

asSymbol

Return a Symbol derived from the String.

(
var z;
z = "myString".asSymbol.postln;
z.class.postln;
)

asInteger

Return an Integer derived from the String. Strings beginning with non-numeric characters return 0.

"4".asInteger.postln;

asFloat

Return a Float derived from the String. Strings beginning with non-numeric characters return 0.

"4.3".asFloat.postln;

catArgs(... args)

Concatenate this string with the following args.

"These are some args: ".catArgs(\fish, SinOsc.ar, {4 + 3}).postln;

scatArgs(... args)

Same as catArgs, but with spaces in between.

"These are some args: ".scatArgs(\fish, SinOsc.ar, {4 + 3}).postln;

ccatArgs(... args)

Same as catArgs, but with commas in between.

"a String".ccatArgs(\fish, SinOsc.ar, {4 + 3}).postln;

catList(list) scatList(list) ccatList(list)

As catArgs, scatArgs and ccatArgs above, but takes a Collection (usually a List or an Array) as an argument. 

"a String".ccatList([\fish, SinOsc.ar, {4 + 3}]).postln;

split(separator)

Returns an Array of Strings split at the separator. The separator is a Char, and is not included in the output array. The default separator is $/, handy for Unix paths.

"This/could/be/a/Unix/path".split.postln;
"These are several words".split($ ).postln;

find(string)

Returns the index of the string in the receiver, or nil if not found.

"These are several words".find("are").postln;
"These are several words".find("fish").postln;

findAll(string)

Returns the indices of the string in the receiver, or nil if not found.

"These are several words which are fish".findAll("are").postln;
"These are several words which are fish".findAll("fish").postln;

contains(string)

Returns a Boolean indicating if the String contains string.

"These are several words".contains("are").postln;
"These are several words".contains("fish").postln;

containsi(string)

Same as contains, but case insensitive.

"These are several words".containsi("ArE").postln;

containsStringAt(index, string)

Returns a Boolean indicating if the String contains string beginning at the specified index.

"These are several words".containsStringAt(6, "are").postln;

icontainsStringAt(index, string)

Same as containsStringAt, but case insensitive.

escapeChar(charToEscape)

Add the escape character (\) at the location of your choice.

"This will become a Unix friendly string".escapeChar($ ).postln;

tr(from, to)

Transliteration. Replace all instances of from with to.

":-(:-(:-(".tr($(, $)).postln; //turn the frowns upside down

printOn(stream)

Print the String on stream.

"Print this on Post".printOn(Post);

// equivalent to:
Post << "Print this on Post";

storeOn(stream)

Same as printOn, but formatted asCompileString.

"Store this on Post".storeOn(Post);

// equivalent to:
Post <<< "Store this on Post";

inspectorClass

Returns class StringInspector.

stripRTF

Returns a new String with all RTF formatting removed.

(
// same as File-readAllStringRTF
g = File("/code/SuperCollider3/build/Help/UGens/Chaos/HenonC.help.rtf","r");
g.readAllString.stripRTF.postln;
g.close;
)

Unix Support

Where relevant, the current working directory is the same as the location of the SuperCollider app and the shell is the Bourne shell (sh). Note that the cwd, and indeed the shell itself, does not persist:

"echo $0".unixCmd; // print the shell (sh)
"pwd".unixCmd;
"cd Help/".unixCmd;
"pwd".unixCmd;

"export FISH=mackerel".unixCmd;
"echo $FISH".unixCmd;

It is however possible to execute complex commands:

"pwd; cd Help/; pwd".unixCmd;
"export FISH=mackerel; echo $FISH".unixCmd;

Should you need an environment variable to persist you can use setenv (see below).

unixCmd

Execute the String on the command line using the Bourne shell (sh) and send stdout to the post window. See man sh for more details.

"ls Help".unixCmd;

setenv(value)

Set the environment variable indicated in the string to equal the String value. This value will persist until it is changed or SC is quit. Note that if value is a path you may need to call standardizePath on it (see below).

// all defs in this directory will be loaded when a local server boots
"SC_SYNTHDEF_PATH".setenv("~/scwork/".standardizePath); 
"echo $SC_SYNTHDEF_PATH".unixCmd;

getenv

Returns the value contained in the environment variable indicated by the String.

"USER".getenv;

pathMatch

Returns an Array containing all paths matching this String. Wildcards apply, non-recursive.

Post << "Help/*".pathMatch;

loadPaths

Perform pathMatch (see above) on this String, then load and execute all paths in the resultant Array.

"Help/Collections/loadPaths example.rtf".loadPaths; //This file posts some text

load

Load and execute the file at the path represented by the receiver.

standardizePath

Expand ~ to your home directory, and resolve symbolic links. See PathName for more complex needs.

"~".standardizePath; //This will print your home directory

basename

Return the filename from a Unix path.

"Imaginary/Directory/fish.rtf".basename;

dirname

Return the directory name from a Unix path.

"Imaginary/Directory/fish.rtf".dirname;

splitext

Split off the extension from a filename or path and return both in an Array as [path or filename, extension].

"fish.rtf".splitext;
"Imaginary/Directory/fish.rtf".splitext;

Document Support

newTextWindow(title, makeListener)

Create a new Document with this.

"Here is a new Document".newTextWindow;

openDocument

Create a new Document from the path corresponding to this. Returns the Document.

(
d = "Help/Help.help.rtf".openDocument;
d.class;
)

openTextFile(selectionStart, selectionLength)

Create a new Document from the path corresponding to this. The selection arguments will preselect the indicated range in the new window. Returns this.

(
d = "Help/Help.help.rtf".openTextFile(0, 20);
d.class;
)

findHelpFile

Returns the path for the helpfile named this, if it exists, else returns nil.

"Document".findHelpFile;
"foobar".findHelpFile;

openHelpFile

Performs foundHelpFile(above) on this, and opens the file it if it exists, otherwise opens the main helpfile.

"Document".openHelpFile;
"foobar".openHelpFile;

Drawing Support

The following methods must be called within an SCWindow-drawHook or a SCUserView-drawFunc function, and will only be visible once the window or the view is refreshed. Each call to SCWindow-refresh SCUserView-refresh will 'overwrite' all previous drawing by executing the currently defined function.

See also: [SCWindow], [SCUserView], [Color], and [Pen].

draw
 
Draws the String at the current 0@0 [Point]. If not transformations of the graphics state have taken place this will be the upper left corner of the window. See also [Pen].

(
w = SCWindow.new.front;
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.draw
};
w.refresh
)

drawAtPoint(point, font, color)

Draws the String at the given [Point] using the [Font] and [Color] specified.

(
w = SCWindow.new.front;
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.drawAtPoint(
 100@100, 
 Font("Gadget", 30), 
 Color.blue(0.3, 0.5))
};
w.refresh
)

drawInRect(rect, font, color)

Draws the String into the given [Rect] using the [Font] and [Color] specified.

(
w = SCWindow.new.front;
r = Rect(100, 100, 100, 100);
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.drawInRect(r, Font("Gadget", 30), Color.blue(0.3, 0.5));
 Pen.strokeRect(r);
};
w.refresh
)

// drawCenteredIn(inRect)
 draws the String into the center of the given rect with font and color into the window.
 Unfortunately does not work for now...
(
w = SCWindow.new.front;
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.drawCenteredIn(
 Rect(100, 100, 100, 100), 
 Font("Gadget", 30), 
 Color.blue(0.3, 0.5)
 )
};
w.refresh
)

// drawLeftJustIn(inRect)
 Unfortunately does not work for now...
(
w = SCWindow.new.front;
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.drawLeftJustIn(
 Rect(100, 100, 100, 100), 
 Font("Gadget", 30), 
 Color.blue(0.3, 0.5)
 )
};
w.refresh
)

// drawRightJustIn(inRect)
 Unfortunately does not work for now...
(
w = SCWindow.new.front;
w.view.background_(Color.white);
w.drawHook = {
 "abababababa\n\n\n".scramble.drawLeftJustIn(
 Rect(100, 100, 100, 100), 
 Font("Gadget",30), 
 Color.blue(0.3, 0.5)
 )
};
w.refresh
)