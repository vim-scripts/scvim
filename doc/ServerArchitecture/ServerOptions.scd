ServerOptionsencapsulates the commandline options for a Server

ServerOptions encapsulates the commandline options for a server app within an object. This makes it convienent to launch multiple servers with the same options, or to archive different sets of options, etc. Every Server has an instance of ServerOptions created for it if one is not passed as the options argument when the Server object is created. (This is the case for example with the local and internal Servers which are created at startup.)

A Server's instance of ServerOptions is stored in its options instance variable, which can be accessed through corresponding getter and setter methods.

Note: A ServerOptions' instance variables are translated into commandline arguments when a server app is booted. Thus a running Server must be rebooted before changes will take effect. There are also a few commandline options which are not currently encapsulated in ServerOptions. See Server-Architecture for more details.

Class Methods

*new

Create and return a new instance of ServerOptions.
 
Instance Variables (The Options)
 
The following instance variables can be changed through getter and setter methods. Note that the defaults listed below only apply to newly created instances of ServerOptions. The options for the local and internal Servers may have been changed at startup in Main-startup or in ~/scwork/startup.rtf.

numAudioBusChannels -  The number of internal audio rate busses. The default is 128.

numControlBusChannels - The number of internal control rate busses. The default is 4096.


The following two options need not correspond to the available number of hardware inputs and outputs.

numInputBusChannels - The number of audio input bus channels. The default is 8.

numOutputBusChannels - The number of audio output bus channels. The default is 8.


numBuffers - The number of global sample buffers available. (See Buffer.) The default is 1024.

maxNodes - The maximum number of Nodes. The default is 1024.

maxSynthDefs - The maximum number of SynthDefs. The default is 1024.

protocol - A symbol representing the communications protocol. Either\udp or \tcp. The default is udp.

blockSize - The number of samples in one control period. The default is 64.

hardwareBufferSize - The preferred hardware buffer size. If non-nil the server app will attempt to set the hardware buffer frame size. Not all sizes are valid. See the documentation of your audio hardware for details.
 
memSize - The number of kilobytes of real time memory allocated to the server. This memory is used to allocate synths and any memory that unit generators themselves allocate (for instance in the case of delay ugens which do not use buffers, such as CombN), and is separate from the memory used for buffers. Setting this too low is a common cause of 'exception in real time: alloc failed' errors. The default is 8192.

numRGens - The number of seedable random number generators. The default is 64.

numWireBufs - The maximum number of buffers that are allocated to interconnect unit generators. (Not to be confused with the global sample buffers represented by Buffer.) This sets the limit of complexity of SynthDefs that can be loaded at runtime. This value will be automatically increased if a more complex def is loaded at startup, but it cannot be increased thereafter without rebooting. The default is 64.

sampleRate - The preferred sample rate. If non-nil the server app will attempt to set the hardware sample rate.

loadDefs - A Boolean indicating whether or not to load the synth definitions in synthdefs/ (or anywhere set in the environment variable SC_SYNTHDEF_PATH) at startup. The default is true.
 
inputStreamsEnabled - A String which allows turning off input streams that you are not interested in on the audio device. If the string is "01100", for example, then only the second and third input streams on the device will be enabled. Turning off streams can reduce CPU load.

outputStreamsEnabled - A String  which allows turning off output streams that you are not interested in on the audio device. If the string is "11000", for example, then only the first two output streams on the device will be enabled. Turning off streams can reduce CPU load.

blockAllocClass - Specifies the class the server will use to allocate index numbers for buffers and audio and control buses. Should be given as a class name, not a symbol. Currently implemented choices are: 

PowerOfTwoAllocator: The original allocator. Intended for allocating these resources very quickly for relatively stable configurations. Not ideal for situations where buses or buffers will be allocated and deallocated frequently. 

ContiguousBlockAllocator: Designed for allocations that need to change frequently. Sacrifices a small amount of speed for reliability. See the [ContiguousBlockAllocator] helpfile.

PowerOfTwoAllocator is the default.

Instance Methods
 
firstPrivateBus- Returns the index of the first audio bus on this server which is not used by the input and output hardware.

asOptionsString- Returns a String specifying the options in the format required by the command-line scsynth app.


For further information see Server, Server-Architecture, and Server-Command-Reference.

Examples

// Get the local server's options

o = Server.local.options;

// Post the number of output channels

o.numOutputBusChannels.postln;

// Set them to a new number

o.numOutputBusChannels = 6; // The next time it boots, this will take effect

// Create a new instance of ServerOptions

o = ServerOptions.new;

// Set the memory size to twice the default

o.memSize = 4096;

// Create a new Server on the local machine using o for its options

t = Server(\Local2, NetAddr("127.0.0.1", 57111), o);
t.makeWindow;
t.boot;
t.quit;