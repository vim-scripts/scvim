
PlayerSocket

a voice that is able to switch between different players.

when it switches to a new player, it sends .release to the old one.

a Patch with a \gate and an EnvGen will release. after releaseTime, it will be
sent .stop which will stop it and all its children.

a Patch with no \gate will not release, but after releaseTime it will be
sent .stop which will stop it abruptly.

the default releaseTime is 0.0 which will stop immediately. 

a releaseTime of nil will not send stop at all. if you use an EnvGen doneAction of 2, the node will be ended when the gate goes down. a PlayerNodeWatcher is planned to watch for this and stop all the children which would otherwise go on playing.

*new(rate,numChannels,round)
	rate - all players should be the same rate
	numChannels - all players should have the same numChannels
	round - for qspawnPlayer
	
preparePlayer(aPlayer)
prepareAndSpawn(aPlayer,releaseTime)
spawnPlayer(aPlayer)
	if you have already prepared the player
qspawnPlayer(aPlayer,releaseTime)
	spawn at the next clock division
releaseVoice(releaseTime)


(
q = Patch({ Saw.ar(600) * 0.2 });
r = Patch({ Saw.ar(800) * 0.2 });
p = PlayerSocket.new(\audio,1);
p.play;
)

p.prepareAndSpawn(q,0.1);
p.prepareAndSpawn(r,0.1);
p.prepareAndSpawn(q,0.1);
p.prepareAndSpawn(r,0.1);

(
p.prepareAndSpawn(
	Patch({ arg freq=400,gate=1.0;
		Saw.ar(freq) * EnvGen.kr(Env.adsr(0.1,2.0,0.3,2.0),gate)
	},[
		rrand(38,70).midicps,
		KrNumberEditor(1.0,\gate)
	]),
	1.0
)
)


p.releaseVoice(1.0);


//we are asleep now
p.isSleeping;

p.isPlaying;

p.free;

p.isSleeping;

p.isPlaying;




// too short time intervals is still catching it
(
q = Patch({ Saw.ar(600) * 0.2 });
r = Patch({ Saw.ar(800) * 0.2 });
p = PlayerSocket.new(\audio,1);
p.play;

Routine({
	2.0.wait;
	4.do({
		rrand(0.01,0.2).wait;
		p.prepareAndSpawn([r,q].choose,rrand(0.01,1.0));
	});
	2.0.wait;
	p.release;
	4.0.wait;
	p.stop;
	1.0.wait;
	p.free;
}).play(AppClock)
)





see PlayerPool which is a subclass of this


As an input to a Patch
(
q = Patch({ Saw.ar * 0.2 });
r = Patch({ Saw.ar(800) * 0.2 });
p = PlayerSocket.new(numChannels: 1);
e = Patch({ arg audio; RLPF.ar(audio,200) },[ p ]);
e.play;
)


p.prepareAndSpawn(q);

p.prepareAndSpawn(r);

p.prepareAndSpawn(q);

p.prepareAndSpawn(r);

// if you know that you have prepared it
p.spawnPlayer(q);

p.spawnPlayer(r);


p.releaseVoice

p.insp
e.insp
p.synthArg

e.free;




