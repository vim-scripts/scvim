
HasPatchIns


not finished


p = Patch({ arg audio=0,ffreq=300;
	RHPF.ar(audio,ffreq,0.1)
});
q = Patch({
	Saw.ar(mul: 0.3)
});

p.play;
q.play;

// adds a connection
// but q is still out of main outs
p.connectInputToPlayer(0,q)


q.patchTo(p,0);


p.gui



