KrNumberEditor

superclass: NumberEditor

This is the defaultControl for a ControlSpec. a KrNumberEditor is like its superclass, except that if used in a Patch it will be a continously modulateable control. You can move the slider and it sends its 



IMPORTANT
if a KrNumberEditor is connected to a Patch playing on a server, the message to the server happens when the KrNumberEditor gets the .changed message and sends .update to all its depedants. This includes any NumberEditorGui and also any UpdatingScalarPatchOut, which is what actually sends the message to the server.


/*
s.boot;
(
// works as a stream .. convienient for patterns
 n=NumberEditor(440.0,\freq);
 n.gui;
 
 Pbind(
 \freq,n
 ).play
)
*/


from an email:

KrNumberEditors support lag. You can set lag to nil for no Lag.

I have added NoLagControlSpec, whose defaultControl sets the lag to nil.

I would prefer to just have a lag preference in ControlSpec
(clients that do lag eg. sliders can tell from the spec if they should do lag or not).

as Jan pointed out a while ago, binary things don't like lag.

\binary, \loop is registred as a NoLagControlSpec, and thus doesn't use any lag at all.
you can register others, or use a NoLagControlSpec when writing the Instr.

I am experimenting with different kinds of inertia Lag (hysterisis ?), so I'm not using LagControl
right now, but it might switch to that.
either way it violates the contract : it should be a function on the input object, not at the receiving end
inside of the function. but its more efficient.
