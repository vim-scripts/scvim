Group client-side representation of a group node on the server 
superclass: Node

A Group is the client-side representation of a group node on the server, which is a collection of other nodes organized as a linked list. The Nodes within a Group may be controlled together, and may be both Synths and other Groups. Groups are thus useful for controlling a number of nodes at once, and when used as targets can be very helpful in controlling order of execution. (See Order-of-execution for more details on this topic).

For more on the crucial distinction between client objects and server nodes, see ClientVsServer. For information on creating nodes without using objects, see NodeMessaging.

N.B. Group is a subclass of Node, and thus many of its most useful and important methods are documented in the Node help file. Please refer to it for more information.

RootNode and the default group

When a Server is booted there is a top level group with an ID of zero that defines the root of the tree. This is represented by a subclass of Group: RootNode. If the Server was booted from within SCLang (as opposed to from the command line) then a default_group with an ID of 1 will be automatically created. This group is the default enclosing group for all Nodes, i.e. it's what you get if you don't specify. In general you should create new Nodes within the default group of a Server rather than in its RootNode. See Server, default_group and RootNode for more detail.

Bundling

Some of the methods below have two versions: a regular one which sends its corresponding message to the server immediately, and one which returns the message in an Array so that it can be added to a bundle. It is also possible to capture the messages generated by the regular methods using Server's automated bundling capabilities. See Server and bundledCommands for more detail.

Creation with Immediate Instantiation on the Server

 *new(target, addAction)
 
Create and return a Group.
 
target - A target for this Group. If target is not a Group or Synth, it will be converted as follows: If it is a Server, it will be converted to the default_group of that server. If it is nil, to the default_group of the default Server. Note: A Synth is not a valid target for \addToHead and \addToTail.
 
addAction - one of the following Symbols: 
 \addToHead - (the default) add at the head of the group specified by target
 \addToTail - add at the tail of the group specified by target
 \addAfter - add immediately after target in its server's node order
 \addBefore - add immediately before target in its server's node order
\addReplace - replace target and take its place in its server's node order
 
 
 s.boot;
 g = Group.new; // add a Group at the head of the default Server's default group
 h = Group.new(g, \addAfter);
 s.queryAllNodes; // note the Group within the default group (ID 1)
 g.free; h.free;
 
The following convenience methods correspond to the add actions above:

 *after(aNode)
 
Create and return a Group and add it immediately after aNode. 

 *before(aNode)
 
Create and return a Group and add it immediately before aNode.

*head(aGroup)
 
Create and return a Group. If aGroup is a Group add it at the head of that group. If it is a Server, add it at the head of the default_group of that server. If it is nil, add it at the head of the default_group of the default Server.
 
*tail(aGroup)
 
Create and return a Group. If aGroup is a Group add it at the tail of that group. If it is a Server, add it at the tail of the default_group of that server. If it is nil, add it at the tail of the default_group of the default Server.
 
*replace(nodeToReplace)
 
Create and return a Group and use it to replace nodeToReplace, taking its place in its server's node order.

Creation without Instantiation on the Server

For use in message bundles it is also possible to create a Group object in the client app without immediately creating a group node on the server. Once done one can call methods which create messages to add to a bundle, which when sent to the server will instantiate the group or perform other operations. (See Control, below.)

*basicNew(server, nodeID)
 
Create and return a Group object without creating a group node on the server. (This method is inherited from Node and is documented here only for convenience.)
 
server - An optional instance of Server. If nil this will default to the default Server. 
 
nodeID - An optional node ID number. If not supplied one will be generated by the Server's NodeIDAllocator. Normally you should not need to supply an ID.
 
s.boot;
 g = Group.basicNew(s); // Create without sending
 s.sendBundle(nil, g.newMsg;); // Now send a message; create at the head of s' default group
 s.queryAllNodes;
 g.free;
 
newMsg(target, addAction)
 
Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group. If target is nil, it will default to the default_group of the Server specified in *basicNew when this Group was created. The default addAction is \addToHead. (See *new above for details of addActions.
 
addToHeadMsg(aGroup)
 
 Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group. If aGroup is a Group it will be added at the head of that group. If it is nil, it will be added at the head of the default_group of this Group's server (as specified when *basicNew was called).
 
addToTailMsg(target)
 
 Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group. If aGroup is a Group it will be added at the tail of that group. If it is nil, it will be added at the tail of the default_group of this Group's server (as specified when *basicNew was called).
 
addBeforeMsg(aNode)
 
Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group, immediately before aNode.
 
addAfterMsg(aNode)
 
Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group, immediately after aNode.
 
addReplaceMsg(nodeToReplace)
 
Returns a message of the type g_new which can be bundled. When sent to the server this message will instantiate this group, replacing nodeToReplace in the server's node order.
 
Control

For further methods of controlling Groups (set, map, busMap, etc.), see the Node help file.
 
 moveNodeToHead(aNode)
 moveNodeToHeadMsg(aNode)
 
 Move aNode to the head of this group  
 
 moveNodeToTail(aNode)
 moveNodeToTailMsg(aNode)
 
 Move aNode to the tail of this group 
 
 freeAll
 freeAllMsg
 
 Free all the nodes in this group, but do not free this group itself.

 deepFree
 deepFreeMsg
 
 Free all Synths in the group, and all Synths in any enclosed groups, but do not free this group or any of its enclosed groups.


Examples

(
s = Server.default; // just to be sure
s.boot;
)

(
SynthDef("help-Group-moto-rev", { arg out=0,freq=100,ffreq=120;
 var x;
 x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, freq), [0,0.1], 0.1), 
 ffreq, 0.1).clip2(0.4);
 Out.ar(out, x);
}).send(s);


SynthDef("help-Group-wah", { arg out, rate = 1.5, cfreq = 1400, mfreq = 1200, rq=0.1;
 var zin, zout, q;

 zin = In.ar(out, 2);
 cfreq = Lag3.kr(cfreq, 0.1);
 mfreq = Lag3.kr(mfreq, 0.1);
 q = Ramp.kr(rq, 0.1);
 zout = RLPF.ar(zin, LFNoise1.kr(rate, mfreq, cfreq), q, 10).distort 
 * 0.15;

 // replace the incoming bus with the effected version
 ReplaceOut.ar( out , zout ); 
 
}).send(s);
)

g = Group.new;

(
l = Array.fill(3,{
 // random freq for each synth, added to g at the head
 Synth("help-Group-moto-rev",["out",0,"freq",rrand(10,120)],g,\addToHead);
});
)

// set all controls that match "ffreq" in all nodes in g to 90
g.set("ffreq",300);

g.set("freq",80);

// since we stored the Synths in an Array, we can also control them individually
(
r = Routine({
 inf.do({
 l.do({ arg node;
 node.set("freq",rrand(10,120));
 1.0.wait;
 });
 })
});

r.play;
)

// g is in a group too. Since we didn't specify it's the default group (ID 1) of the default Server
g.group.inspect;

// asking a wah to go order-of-execution after g, in the same group as g.
x = Synth.after(g,"help-Group-wah",["out",0]); 

x.free;

// free all nodes in g, but not g itself
g.freeAll;

// don't forget the Routine is still running...
r.stop;

// oh, and set l to nil so the Synths and Array can be garbage collected
l = nil;

// and i'm still on the server, its just my children that were freed
g.query;

// don't need the individual synth objects this time
(
3.do({
 // random freq for each synth, added to g at the head
 Synth("help-Group-moto-rev",["out",0,"freq",rrand(10,1200)],g,\addToHead);
});
)

// kill me and my children
g.free;

// see, I'm gone
g.query;