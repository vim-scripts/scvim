CrucialLibrary
 
Higher level interfaces for managing musical objects.

AbstractPlayer
 This encapsulates things that play. you can stop them, start them, record them and save them
 to disk. They handle all the messy details of loading their resources to the server, and getting
 them off again when you are done.
 
 Patch
 The most common and well known Player. This patches inputs into a function. Inputs can be floats,
 other players, Envs (envelopes), Samples, or SFP (sound file player).
 A Patch plays continously and infinitely (until you stop it).
 
 InstrSpawner, InstrGateSpawner
 a Patch that plays successive events. The inputs are taken as streams and interated.
 
 Interface
 specify a player and interface elements and how they are connected.
 allows custom gui and midi functions.
 
 introspection tools
 .insp - a debugging tool
 "any object".insp
 class browser
 AbstractPlayer.gui

It is not advisable to use "the whole library"--don't think of it as a single entity. Try out one or two things and work them into what you are normally doing; as time goes on, learn some more objects.
It should not be an all or nothing commitment. If you perceive it as that, then you are approaching it wrong.

Although there is a convienient system for instantly making guis for instrument functions, the purpose of the library is not "a gui system". It is flexible, and can be used in any coding situation.


INSTALLATION

crucial is distributed with SC and should not needed further installation. frequent updates are maintained through CVS.



[ double click to select, command-h to open help file ]

Instr
Patch

InstrSpawner
InstrGateSpawner

Interface

gui

SynthConsole

NumberEditor


AbstractPlayer

StreamKrDur
Tempo
TempoBus
TempoPlayer
BeatClockPlayer
Stream2Trig
PlayerEfxFunc


PlayerPool





What you can do for Me:

send me a copy of any record/CD you put out using this stuff
write Instr and offer them to me or to everyone
Write Usable Classes and share them with me
suggest or implement improvements
build things i wouldn't build
identify issues
report bugs
fix bugs
hook me up with gigs. i rock the house. honest.
buy my album

