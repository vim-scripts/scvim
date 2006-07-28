AbstractPlayerGui

superclass: ObjectGui

This is the parent class for all gui classes of AbstractPlayer subclasses.

to the standard ObjectGui it adds these visual elements:

server boot controls
play button
stop button [ ]
free button
tempo control
save button
save as
#path - post the path
# - post the object as a compile string






to the ObjectGui implementation it adds the methods

topGui
 does
 synthConsole
 saveConsole
 does writeName
 does guiBody
 then shrinks the window to fit
writeName
 write the name of the object as a label.
 the color of the name label is different if the object has a path (was loaded from disk)
saveConsole
 standard save controls. you can override this method in subclasses to customise.
synthConsole
 standard play/record/etc. controls. you can override this method in 
 subclasses to customise.
durationString
 returns a formatted string representing the minutes:seconds duration of the player
durationGui(layout)
 subclasses can call this to add a display of the duration of the player. it will
 update itself when the player changes and also when the Tempo (global) changes.




Usually the only method you need to implement in your subclass is guiBody

