EnvelopedPlayer

wraps the player with an envelope.
this allows any player to respond to .release with a smooth envelope release.

EnvelopedPlayer(player,env,numChannels)

if numChannels is not nil, the player's output will be duplicated or mixed down as
needed to ensure that many channels for output. so mono signals will be copied to 
a stereo image.

(

p = EnvelopedPlayer(
 Patch({
 SinOsc.ar * 0.1
 }),
 Env.adsr(releaseTime: 2.0),
 1
);

p.play;

/*
Group(0)
 Group(1)
 Synth("-tIRuC" : 1000) Patch[ f-1833258691 ]:synth
 Synth("EnvelopedPlayer1yeG~u" : 1001) an EnvelopedPlayer:synth
*/
)

p.release;

p.status


p.insp


p.group



(

x = PlayerSocket.new(\audio,1);
x.play;

p = EnvelopedPlayer(
 Patch({
 SinOsc.ar * 0.1
 }),
 Env.adsr(releaseTime: 2.0),
 1
);


x.prepareAndQSpawn(p)

)



x.preparePlayer(p)

p.insp

x.qspawnPlayer(p)



(

EnvelopedPlayer(
 EnvelopedPlayer(
 Patch({
 SinOsc.ar * 0.1
 }),
 Env.adsr(releaseTime: 2.0),
 1
 ),
 Env.adsr(releaseTime: 3.0),
 1
).play

/*
Group(0)
 Group(1)
 Synth("-15n~Em" : 1000) Patch[ f-33811036 ]:synth
 Synth("EnvelopedPlayer1yeG~u" : 1001) an EnvelopedPlayer:synth
 Synth("EnvelopedPlayer1-ysI-H" : 1002) an EnvelopedPlayer:synth
*/

)

(
 EnvelopedPlayer(
 Patch({
 SinOsc.ar * 0.1
 }),
 Env.adsr(releaseTime: 2.0),
 1
 ).play
)

