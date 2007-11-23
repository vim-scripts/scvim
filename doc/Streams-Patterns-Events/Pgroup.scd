
Pgroup

superclass: FilterPattern



Pgroup(pattern)

Starts a new group and plays the pattern in this group.
The group is released when the stream has ended.

Example:


(
var p, q, r, o;
p = Pbind(\degree, Prand((0..7),12), \dur, 0.3, \legato, 0.2);

Pgroup(p).play;

// post the node structure:
fork {
	s.queryAllNodes;
	3.wait;
	s.queryAllNodes;
	2.wait;
	s.queryAllNodes;
}
)
	


