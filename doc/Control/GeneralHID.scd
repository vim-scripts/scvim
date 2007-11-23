
GeneralHID			
A uniform class to access HID devices
	

Inherits from: Object

GeneralHID is a cross platform wrapper for accessing HID devices. Currently the MacOSX and Linux HID support has been wrapped. Some of the code is inspired by the GUI wrapper.

It is advised to use this class instead of the platform specific classes: HIDDeviceService (on MacOSX) and LID (on Linux)
There are intermediate "bridge" classes MXHID (on MacOSX) and GLID (on Linux), which should not be used directly, but their names will show up in the output of some of the methods of GeneralHID.

Some outstanding issues

This class is not completely finished yet. Common slot numbers across platforms are not yet guaranteed. On Windows there is not yet a proper implementation available.


Creation / Class Methods

	*scheme , *current
		Get the current scheme
	

	*scheme.id , *current.id
		Get the current scheme ID
	

	*buildDeviceList

		Look for all connected devices and build a device list. This returns the devicelist as an Array.
	

	*deviceList

		Returns the device list if it has already been built before.
	

	*postDevices

		Posts a readable list of devices.
	

	*postDevicesAndProperties

		Posts a readable list of devices and their properties.
	

	*startEventLoop( arg rate=0.005 )

		Start the eventloop with a update rate (or rather update time in seconds). (Note: this is only really needed on MacOSX, but for crossplatform code you should include it in your code).
	

	*stopEventLoop

		Stop the eventloop.
	

	*eventLoopIsRunning

		Check status of eventloop.
	

Further information:

See  GeneralHIDDevice for a documentation of the methods to access an HID device.



Example

// General structure to access a device
// Look for the devices that are attached:
GeneralHID.buildDeviceList;
// Get the list of devices:
d = GeneralHID.deviceList;
// Check which devices have been found:
GeneralHID.postDevices;
// Pick the 6th device and open it and create an instance of it:
a = GeneralHID.open( d[5] )
// Get info on the device:
a.info;
// Start eventloop:
GeneralHID.startEventLoop
// Get the capabilities of the device in a readable format:
a.caps;
// See if data is coming in:
a.debug_( true );
// Stop it:
a.debug_( false );

// Debugging can be turned on for each slot individually, if necessary:
//(IBM trackpoint)
a.slots[1].at( 272 ).debug_( true );

// (external mouse on macbook pro)
a.slots[3][1].debug_(true);

(external mouse on ibm thinkpad)
a.slots[2][1].debug_(true);

// Turn it off again:
// (IBM trackpoint)
a.slots[1].at( 272 ).debug_( false );
//(external mouse on macbook pro)
a.slots[3][48].debug_(false);
//(external mouse on ibm thinkpad)
a.slots[3][1].debug_(false);

// The current value of a slot can be checked:


a.slots[1].at( 272 ).value;
a.slots[2].at( 1 ).value;
a.slots[3][1].value



//If the slot is an LED, you can set the value:

a.slots[11][0].value = 1;
a.slots[11][0].value = 0;


// Actions can be mapped to each slot individually.

a.slots[1].at( 272 ).action_( { "hello".postln; } );
a.slots[1].at( 273 ).action_( { "hi".postln; } );
a.slots[3].at( 1 ).action_( { "hi".postln; } );

with an input to the function

a.slots[3].at( 1 ).action_( { |v| "hi, my value is ".post; v.value.postln; } );
a.slots[1].at( 272 ).action_( { |v| "hi, my value is ".post; v.value.postln; } );


To stop the action, assign it to an empty function.

a.slots[1].at( 272 ).action_( {} );
a.slots[1].at( 273 ).action_( {} );
a.slots[3].at( 1 ).action_( {} );




// If the server is running you can create a control bus for the HID data to go to, so that a synth can immediately read the data:


s = Server.local.boot;

// To create the bus:

a.slots[1].at( 272 ).createBus( s );
a.slots[2].at( 8 ).createBus( s );



SynthDef( \hidbus_help, { |out=0,amp=0|
	Out.ar( out, SinOsc.ar( 300, 0, 0.01*amp.abs ) );
}).load( s );
)




x = Synth.new( \hidbus_help );
x.map( \amp, a.slots[2].at( 8 ).bus );
x.free;



( // a nicer version:
SynthDef( \hidbus_help, { |out=0,amp=0,amp2=0|
	Out.ar( out, SinOsc.ar( 300, 0, 0.01*amp.abs.lag( 0.1 ) * amp2.lag(0.01,0.99) ) );
}).load( s );
)


x = Synth.new( \hidbus_help );
x.map( \amp, a.slots[2].at( 8 ).bus );
x.map( \amp2, a.slots[1].at( 272 ).bus );
x.free;



( // an even nicer version:
SynthDef( \hidbus_help, { |out=0,freqadd=0,amp=0|
	Out.ar( out, SinOsc.ar( 300 + (freqadd.lag(0.2,1)*40), 0, 0.2*amp.lag(0.01,0.99) ) );
}).load( s );
)


x = Synth.new( \hidbus_help );
x.map( \freqadd, a.slots[2].at( 8 ).bus );
x.map( \amp, a.slots[1].at( 272 ).bus );
x.free;



// To free the bus:

a.slots[1].at( 272 ).freeBus;
a.slots[2].at( 8 ).freeBus;



// Close the device after use:
a.close;
GeneralHID.stopEventLoop



