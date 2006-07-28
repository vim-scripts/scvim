SaveConsole


a tool for managing .asCompileString based archiving of objects.

does a no-clobber check, makes a .bak copy of any previously existing file it finds. saves inside a TaskIfPlaying, so you don't have to stop play.

SaveConsole(object,path)

object:
 anything that can meaningfully respond to .asCompileString
path:
 if the object you are supplying was already loaded from disk and has a known path,
 tell the SaveConsole of this. (makes a difference for save/save as behavior)


(
 SaveConsole(
 Array.rand(16,10,200),
 nil, // no previous path
 nil) //no layout
 .print // prints object 
 .save
 .saveAs

)





