Patching

PatchIn
AudioPatchIn
ControlPatchIn
ScalarPatchIn

PatchOut
ControlPatchOut
AudioPatchOut
ScalarPatchOut

These objects hold information about a Player's inputs and outputs. They are used to make connections to other Players, and to manage that connection and all subsequent repatching or disconnections. 

PatchIn objects hold NodeControl objects that enable communication to one input of a Node (Synths and Groups), either for setting the value or mapping the input to read from a Bus.

PatchOut objects hold either Bus objects (for audio and control) or sources (for control and scalar). Bus objects hold the information about the Bus that the Player is playing onto. sources are client side objects that produce float values to send to the inputs of Nodes. Possible sources are gui objects like sliders or Patterns and other automatons. Anything that can respond to .value with a Float can be a source for a ScalarPatchOut.

aPatchIn.connectTo(aPatchOut)
aPatchOut.connectTo(aPatchIn)
 connect the input on the node to the output of the bus or source. 
 
Both PatchIn and PatchOut remember who they are connectedTo. PatchOuts may be connected to multiple PatchIns.


play(patchIn)

 server
 plays on top group at head
 group
 plays at group of head
 integer
 default server, audio output number
 
 
they should be even gui-able, a drag drop

maybe even a player makes ins and outs when created

prepare(group)
 sets the patchOut group, where it will be created
 
patchIn
 also hold source ?, search for synth
 
 
 
examples:
 drag output of player to some input
 patchOut.connectTo(patchIn)
 sets nodeControl if playing,
 else when it plays it will get the value

 if player is not playing anywhere else
 if input is reading from something else
 insert mixer


 drag filter to player

 if player is not playing anywhere else
 node after
 same buss for out
 filter reads from that buss

 this is a kind of player 
 
 if player is playing to another filter
 remove other
 node after
 same buss for out
 filter reads from that buss
 
 
 
 
 

 