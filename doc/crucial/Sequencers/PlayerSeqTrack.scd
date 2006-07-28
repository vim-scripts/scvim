PlayerSeqTrack

Play a series of Players in a sequence, with individual control over duration, 
attack,release and level.

This is only designed to work with Players that already saved to disk.

The primary design difference between this and CyclePlayers is that 
PlayerSeqTrack does not need to know all of its players before play/editing. 
They can be added and removed dynamically, even while playing.

PlayerSeqTrack( arrayOfPlayerPaths, arrayOfBeatDurations,arrayOfEnvelopes, loop)

 arrayOfPlayerPaths - or nil (players can be added later )
 or they can be actual players. if you use paths, then identical paths
 in the array will play the identical player (only one copy is loaded).
 so the sequence can contain repeats:
 [ path1, path2, path1, path2, path3 ...]

(
// locate some players on your hard drive and add them to a list
// hit cancel when you have enough
l = List.new;
f = {
 GetFileDialog({ arg ok,path;
 if(ok,{
 l.add(loadPath(path));
 f.value;
 })
 });
};
f.value
)


(

p = PlayerSeqTrack.new;

6.do({
 p.insertLast(Properties(\working).wchoose.asString.loadDocument);
});

p.setDuration(0,4);
p.setDuration(1,4);
p.setDuration(2,4);
p.setDuration(3,4);
p.setDuration(4,4);
p.setDuration(5,4);

p.gui
)



p.play;

p.free;
)

p.insp


PlayerSeqTrackGui

now while watching the pretty visuals:

(
 p.gui;
 p.changed; // update the gui
)


// while playing is fine, weve already loaded the players
p.insert( 3, l.choose ).changed;
p.insert( 8.rand, l.choose ).changed;


(
 5.do({ arg i;
 p.insert(i, l.choose );
 });
 p.changed;
)
(
 5.do({ arg i;
 p.setDuration( p.playerSeq.size.rand, [4,8,16,32].choose );
 });
 p.changed;
)
(
 5.do({ arg i;
 p.setRelease( i, rrand(0.01,5.0) );
 });
 // no gui display of release times
)
(
 5.do({ arg i;
 p.setLevel( i, rrand(0.1,2.0) );
 });
 // no gui display of levels
)


p.deleteAt(6).changed;


Note that the duration display changes also. It also changes when you change the tempo.

GUI Hot-Keys

While selected on any of the sequences these keys are active:

<- select previous
-> select next
opt -> move selected left
opt <- move selected right
up increase dur by 1 bar
down decrease dur by 1 bar
opt-up double duration
opt-down half duration
shift-opt-up double durations of all steps
shift-opt-down half durations of all steps
` relocate (while playing) to this step
delete delete this step
g gui the player at this step
i open information window

escape focus on the first focusable view in this window that is not one of the sequence steps
 
 
The information window

 in the information window you can edit
 duration, attack,decay,level, envelope
 in three selectable scopes:
 this step, all steps with this player, all steps
 
It is also possible to embed the info window on the same layout:

(
 Sheet({ arg f;
 PlayerSeqTrack.new.topGui(f).infoGui(f);
 })
)

Note that topGui returns the PlayerSeqTrackGui object, which responds to infoGui(layout);


Its turtles all the way down
 
It is of course possible to put a PlayerSeqTrack inside of another PlayerSeqTrack.

Multiple tracks are obtainable via the use of PlayerMixer, though they won't easily
remained synchronized if you relocate while playing. 
And the gui will be not lined up verticle.
Eventually i will write a multi-track version that holds and synchronizes multiple PlayerSeqTrack.


Live Insert of Players

( // insert players at the selected step, even while playing
Sheet({ arg f;

 p = PlayerSeqTrack.new;
 g = p.topGui(f); // return the gui itself
 
 Label(f,"insert:");
 l.do({ arg player;
 ActionButton(f,player.name,{ p.insert(g.selected ? 0 , player).changed })
 })
})
)


(
 // insert players NOW at the presently playing step
 // 808 style
Sheet({ arg f;

 p = PlayerSeqTrack.new;
 p.topGui(f);
 
 Label(f,"insertNow:");
 l.do({ arg player;
 ActionButton(f,player.name,{ p.insertNow( player,round: 1.0).changed })
 })
})

)


insert(step,player,duration,env)
step- index to insert at
player - the player object or path to insert
 in the example above, i used the actual player because its faster, you share
 the same player instance, and it doesn't have to load anything from disk while
 its playing.
duration - the number of beats it should play for
 if nil,
 use the duration of any previous appearance of this player in the sequence
 if that is nil,
 use the natural beatDuration of the player
 if that is nil,
 use 128.0 beats
env - the envelope to use
 if nil,
 use the envelope of any previous appearance of this player in the sequence
 if that is nil,
 use default envelope


All players that you insert must have a path (must have been loaded from disk).

When this example saves, notice that the steps 0 and 3 repeat the same player. On reloading, they will
share the same copy.

 PlayerSeqTrack.new(
 [ ":Patches:footfist:dawhohop", ":Patches:footfistwhisker:dhallooo", ":Patches:footfist:dawhohop",
 ":Patches:footfistwhisker:buggercraft", ":Patches:footfistwhisker:basscl", ":Patches:footfist:simp" ], 
 [ 16, 16, 16, 16, 16, 16 ], 
 [ Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil) ]
 )

Actually PlayerSeqTrack could play players without a path, but the gui would display them
all as "nil" "nil" etc.
And it would save as something like this:
 
 PlayerSeqTrack.new(
 [ Patch.new(
 [ 'minimoog', 'detune' ], 
 [ 440, -4, 0, 0.4, 1 ]
 ), Patch.new(
 [ 'synths', 'stereo', 'SyncSaw' ], 
 [ BeatClockPlayer(16) 
 , 440, 447.214, 0.5, 0.4, Env.new([ 0, 1, 0.5, 0 ], [ 0.01, 0.3, 1 ], -4, 2, nil), 4, 2 ]
 ), Patch.new(
 [ 'minimoog', 'detune' ], 
 [ 440, -4, 0, 0.4, 1 ]
 ) ], 
 [ 16, 16, 16 ], 
 [ Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil), Env.new([ 0, 1, 1, 0 ], [ 0.01, 1, 0.1 ], [ -2, -2, -2 ], 2, nil) ]
 )


And on reload the identical steps 0 and 3 would not be able to share the same copy.
