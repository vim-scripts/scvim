SoundFile

In most cases you will wish to send commands to the server to get it to load SoundFiles directly into Buffers. You will not use this class for this. See Server-Command-Reference. 

This class is used to check the size, format, channels etc. when the client needs this information about a SoundFile.

Some manipulation of the sound file data is possible. Soundfile data can be read and written incrementally, so with properly designed code, there is no restriction on the file size.


(

f = SoundFile.new;

f.openRead("sounds/a11wlk01.wav");

f.inspect;

f.close;


)


Creating

new

Creates a new SoundFile instance. 

Read/Write

openRead(inPathname)

Read the header of a file. Answers a Boolean whether the read was successful.
sets the numFrames,numChannels and sampleRate. does not set the headerFormat and sampleFormat.
inPathname - a String specifying the path name of the file to read.

readData(rawArray)

Reads the sample data of the file into the raw array you supply. You must have already called openRead.

The raw array must be a FloatArray. Regardless of the sample format of the file, the array will be populated with floating point values. For integer formats, the floats will all be in the range -1..1.

The size of the FloatArray determines the maximum number of single samples (not sample frames) that will be read. If there are not enough samples left in the file, the size of the array after the readData call will be less than the original size.

When you reach EOF, the array's size will be 0. Checking the array size is an effective termination condition when looping through a sound file. See the method channelPeaks for example.

openWrite(inPathname)

Write the header of a file. Answers a Boolean whether the write was successful.
inPathname - a String specifying the path name of the file to write.


writeData(rawArray)

Writes the rawArray to the sample data of the file. You must have already called openWrite.

The raw array must be a FloatArray or Signal, with all values between -1 and 1 to avoid clipping during playback.

Example:

(
f = SoundFile.new.headerFormat_("AIFF").sampleFormat_("int16").numChannels_(1);
f.openWrite("sounds/sfwrite.aiff");
 // sawtooth
b = Signal.sineFill(100, (1..20).reciprocal);
 // write multiple cycles (441 * 100 = 1 sec worth)
441.do({ f.writeData(b) });
f.close;
)

isOpen
answers if the file is open

close
closes the file

duration
the duration in seconds of the file

Normalizing

*normalize(path, outPath, newHeaderFormat, newSampleFormat, startFrame, numFrames, maxAmp, linkChannels, chunkSize)

normalize(outPath, newHeaderFormat, newSampleFormat, startFrame, numFrames, maxAmp, linkChannels, chunkSize)

Normalizes a soundfile to a level set by the user. The normalized audio will be written into a second file. 

Note: While the normalizer is working, there is no feedback to the user. It will look like SuperCollider is hung, but it will eventually complete the operation.

Arguments:

path: a path to the source file
outPath: a path to the destination file
newHeaderFormat: the desired header format of the new file; if not specified, the header format of the source file will be used
newSampleFormat: the desired sample format of the new file; if not specified, the sample format of the source file will be used
startFrame: an index to the sample frame to start normalizing (default 0)
numFrames: the number of sample frames to copy into the destination file (default nil, or entire soundfile)
maxAmp: the desired maximum amplitude. Provide a floating point number or, if desired, an array to specify a different level for each channel. The default is 1.0.
linkChannels: a Boolean specifying whether all channels should be scaled by the same amount. The default is true, meaning that the peak calculation will be based on the largest sample in any channel. If false, each channel's peak will be calculated independently and all channels will be scaled to maxAmp (this would alter the relative loudness of each channel).
chunkSize: how many samples to read at once (default is 4194304, or 16 MB) 

Using the class method (SoundFile.normalize) will automatically open the source file for you. You may also openRead the SoundFile yourself and call normalize on it. In that case, the source path is omitted because the file is already open.

The normalizer may be used to convert a soundfile from one sample format to another (e.g., to take a floating point soundfile produced by SuperCollider and produce an int16 or int24 soundfile suitable for use in other applications).

Instance Variables

<path

Get the pathname of the file. This variable is set via the openRead or openWrite calls.

<>headerFormat

This is a String indicating the header format which was read by openRead and will be written by openWrite. In order to write a file with a certain header format you set this variable.

 Sound File Format symbols:
 header formats:
 read/write formats:
 "AIFF", - Apple's AIFF
 "WAV","RIFF" - MicrosSoft .WAV
 "Sun", - NeXT/Sun
 "IRCAM", - old IRCAM format
 "none" - no header = raw data
 A huge number of other formats are supported read only.
 


<>sampleFormat

A String indicating the format of the sample data which was read by openRead and will be written by openWrite. Not all header formats support all sample formats. The possible header formats are:

 sample formats:
 "int8", "int16", "int24", "int32"
 "mulaw", "alaw",
 "float32"
 
 not all header formats support all sample formats.


<numFrames

The number of sample frames in the file.

<numChannels

The number of channels in the file.

<>sampleRate

The sample rate of the file.

