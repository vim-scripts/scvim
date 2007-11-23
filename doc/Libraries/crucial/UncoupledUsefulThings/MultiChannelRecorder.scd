
MultiChanRecorder

MultiChanRecorder(busses)

Will record multiple busses into separate files.
Optionally can mix them back onto the main output for monitoring.


b = [
	Bus(\audio,2,2),
	Bus(\audio,4,2),
	Bus(\audio,6,2)
	];
	
m = MultiChanRecorder(b);

// each file is named: basePath + _chanNum
// if basePath is nil : "recordings/SC_" ++ Date.localtime.stamp
m.prepareForRecord(basePath);

// mix the busses onto the main outs if desired
m.monitor;

m.record;
// record may also specify a start time :
// m.record(atTime)
// see atTime help

m.stop;


<>limiter

By default it uses a Limiter on each channel. Set limit to false to defeat this.

<>recHeaderFormat
<>recSampleFormat



