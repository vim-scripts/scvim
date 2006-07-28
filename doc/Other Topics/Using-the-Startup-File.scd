Using the Startup File

Once the class library is finished compiling the interpreter looks for a file at the path "~/scwork/startup.rtf" and if such a file exists, executes any code within it. (This happens within Main-startup.) By creating a file in this location you can make user specific customizations. A common example would be to alter the options of the local and internal Servers:

// placing the following code in "~/scwork/startup.rtf" will cause these modifications to be made
// at startup

Server.local.options.numOutputBusChannels = 4; // change number of input and output channels
Server.local.options.numInputBusChannels = 4;
Server.internal.options.numOutputBusChannels = 4;
Server.internal.options.numInputBusChannels = 4;

Server.local.options.blockSize = 128; // increase block size
Server.internal.options.blockSize = 128;

Server.local.options.sampleRate = 96000; // increase sampling rate (if your hardware supports it)
Server.internal.options.sampleRate = 96000;

// change the standard synthDef directory to a custom one:
SynthDef.synthDefDir = "~/scwork/synthdefs".standardizePath;

// change the standard archive path to a custom one:
Archive.archiveDir = "~/scwork".standardizePath;
 
Naturally the file must contain only valid SC expressions.