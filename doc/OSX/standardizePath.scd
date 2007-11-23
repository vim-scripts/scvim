
standardizePath

String Method


Returns a string with ~ replaced by the current user's home directory, and all symbolic links resolved. 

	"~/Documents".standardizePath

/Volumes/Macintosh HD/Users/cruxxial/Documents

	Note that my Documents folder is on a different partition than the boot,
	so the full path uses /Volumes
	
Resolves symbolic links, but does not resolve aliases.

	"~/Library/Favorites/SuperCollider3".standardizePath

/Volumes/Macintosh HD/Users/cruxxial/Library/Favorites/SuperCollider3

Removes extraneous . and .. and / but does not otherwise expand them.

	"./Help/".standardizePath

Help

From the Cocoa documentation:

 	Expand an initial tilde expression using stringByExpandingTildeInPath.
 	Reduce empty components and references to the current directory (that is, the sequences "//" and "/./") to single path separators.
 	In absolute paths only, resolve references to the parent directory (that is, the component "..") to the real parent directory if possible using stringByResolvingSymlinksInPath, which consults the file system to resolve each potential symbolic link.

In relative paths, because symbolic links can't be resolved, references to the parent directory are left in place.

 	Remove an initial component of "/private" from the path if the result still indicates an existing file or directory (checked by consulting the file system).






