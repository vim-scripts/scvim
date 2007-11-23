
BufferProxy

Allocates and supplies a buffer for use in Patches. The buffer is unfilled, suitable for recording. See Sample (a subclass of BufferProxy) if you need to load soundfiles.

(

Instr([\recordPlay,\JemAudioIn], {arg buffer, input, trigRate = 0.5,offOn = 1, pitch = 1, start = 0;
	var offset,trig;
	trig = Impulse.kr(trigRate);
	RecordBuf.ar(input,buffer.bufnumIr, run: offOn,trigger: trig);
	offset = start * buffer.bufFramesKr;
	PlayBuf.ar(buffer.numChannels,buffer.bufnumIr,pitch,trig,offset,loop: 1);

},#[
	\buffer, // == BufferProxySpec(44100,2)
	\stereo, // == AudioSpec.new(2),
	[0.25,10,\linear],
	\unipolar,
	[-5,5,\linear],
	\unipolar
]);


Patch([\recordPlay,\JemAudioIn],[
	BufferProxy(44100 * 4, 2), // 4 secs in stereo
	AudioInPlayer.new
]).gui

)
Make sure your audio input and buffer numChannels match.

an argName of spec symbol of \buffer will create a BufferProxySpec with the default 44100 frames (1 second).
you can place a BufferProxySpec and specify any default size you would like.

this is the DEFAULT that will be used if you DON'T specify an input to a Patch. Usually you pass in a BufferProxy to the patch that is the size that you wish.





