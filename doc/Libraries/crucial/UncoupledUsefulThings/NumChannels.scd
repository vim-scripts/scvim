
NumChannels

	ensures the output has the stated number of channels,
		regardless of the number of input channels.

	NumChannels.ar( input, numChannels, mixdown)
	
		input 		- the audio signal
		numChannels 	- an integer
		mixdown 		- true/false, whether you want to mixdown
							or just use the first channel
	
(
	{
		NumChannels.ar(
			SinOsc.ar(100,0,0.2), // 1 becomes 2
			2)
	}.play
)

(
	{
		NumChannels.ar(
			SinOsc.ar([100,200,300],0,0.2), // 3 becomes 2
			2)
	}.play
)
	
(
	{
		NumChannels.ar(
			SinOsc.ar([100,200,300,100],0,0.2), // 4 becomes 2

			2)
	}.play
)
	
	
	mono input is copied
	multi-channels clumped and
		if mixdown is true
			mixed down
		else
			first channel used


see also [Mono]





