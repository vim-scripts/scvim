
AbstractPlayer			a playable synthesis process

superclass: AbstractFunction

Players are things that play. Anything that you want to play, you can stick your concept into a subclass of AbstractPlayer and you will inherit powerful server management and patching abilities.

A Player can be told to play and to stop, and will allocate and load any resources needed. Many players have subplayers. PlayerMixer mixes several players together. Patch can take other players as inputs. PlayerSeqTrack can sequence successions of players.


play(group,atTime,bus)
	boots the server, prepares the player for play (loading samples etc.)
	and spawns the player
	
	all of these args are optional
	group - 	a Server (will use the root node)
			a Group
			nil (default server's root node)
	atTime - see atTime (Nil,Float,Integer or Date)
	
	bus - (Bus,Integer,Nil)
		a specific Bus to play on, otherwise will default to the main audio outs

spawn(atTime)
	assumes the player has been prepared
	
stop(atTime)
	stops playing but does not deallocate any resources (buffers etc.)
	
free
	stops playind and frees all allocated resources (buffers etc.)

release(releaseTime,atTime)
	call release on the synth, with the releaseTime
	then calls stop on the player, so even if the synthDef does not have a \gate
	input, it will function the same as stop after a short delay.

prepareForPlay(group,private,bus)
	group -	a Server, a Group or Nil
	private - if true, allocates a private bus (not the main audio outs)
	bus -  a specific Bus to play on. this will cause private to be ignored
	
	this loads the synthDef to the server for the player and all of its children,
	and allocates any resources such as buffers, loading sound files etc.
	
	
	
Patching

temporarily disabled. players now patch using .ir outputs,
since its more appropriate to modulate the input than to modulate
the output.
if people really want this, let me know.

/*
p = Patch({ SinOsc.ar(mul: 0.3) });
p.play;

// reassign the bus while playing
p.bus = 5;

p.bus = 0;

p.bus = Bus(\audio,3);

if using an Integer, it will create a Bus on the same server.

*/


Common players
	Patch			
		- specifies a function ( Instr ) and the arguments
		with which to play that function.
	SFP				
		- plays sound files	
	StreamKrDur Stream2Trig
		- renders a number stream to a .kr signal
	InstrSpawner InstrGateSpawner


Gui
AbstractPlayer also comes with a powerful gui class framework. Because of this, many people make the mistake of assuming that AbstractPlayer is primarily a way to get pretty windows. It has nothing to do with that.

But it is very nice to:
	hit the play button and have your sound play.
	select a format, choose a path by normal dialog and record your
		sound to disk as a soundfile.
	hit the save button and save your object with all its parameters to disk.
	change the tempo when you want to.


Methods

path - if loaded or saved, the player knows its path
name - if loaded or saved, the filename, else the name of the class (eg. "a Patch")



	
children - for players that hold other players or objects, return those children
	player classes should implement where appropriate.
	a Patch has its args as children
	SFP has its underlying object as child

	using this.children.do({arg item; .... }) can save you from having to muck up
	the Player class with extra methods.
	
allChildren - and all your children's children, and their children...	
deepDo(function) - do to allChildren




playing in patterns:
		
Players can be put inside of standard patterns:

/*
(

p = CropPlayer(
		Patch.new({ arg freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0;
				PMOsc.ar(freq,freq2,pmindex,phasemod,amp)
		},[
			150.06,
		 	27.7707,
		 	15.1163,
		 	0,
		 	0.616317
		 ]),0,4);
		
y = CropPlayer(
		Patch.new({ arg freq=400, freq2=500,pmindex=0,phasemod=0.0,amp=1.0;
				PMOsc.ar(freq,freq2,pmindex,phasemod,amp)
		},[
			200,
		 	97.7707,
		 	15.1163,
		 	0,
		 	0.616317
		 ]),0,4);
		

	Pseq([ p,y,p,y ],2).play

)
*/
	




Subclassing AbstractPlayer

	see [playerServerSupport] for a basic rundown of the complexities involved

	After that you would usually write a gui class for it.
	
	Then implement the storeParamsOn method which enables you
		to load and save your object.
	
	
	
	
	

Players to come

possible futures:
	Stream2Midi - renders a number stream to midi ( controllers etc.)
	EventStream2Midi - renders note/freq,amp/velocity, duration to midi note events




TimelineEventPlayer
	timecode based events. (rather than delta based event streams where each event
	is responsible for determing when the one succeeding it will happen).
	
Recording of events
	from midi, wacom, gui etc.

	
any Player could be triggered to play from midi or wacom. it can also go through
SchedPlayer to quantise the start time of its play.

All of that can be recorded. those event-recordings can in turn then be further played with.

SFP is the one player type that can be sub-located (asked to start play somewhere in the middle). Timeline based event recording would be another one.  the transport system would work very nicely.


AbstractPlayer is a subclass of AbstractFunction
therefore you can do math with them:

//right now this works, but only with simple ugenGraphs, no Samples,Envs etc.
(Patch({ Saw.ar(400) }).wrap2( 0.5) ).gui


// not yet
//(Patch({ Saw.ar(400) }).wrap2( KrNumberEditor(0.5,[0.0,1.0]) ) ).gui

//(somePatch * EnvPlayer.new(Env.newClear(10)) ).topGui




