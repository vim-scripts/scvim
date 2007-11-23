
BroadcastServer	dispatches osc messages to multiple servers


superclass: Object (adaptor class)


	*new(name, homeAddr, options, clientID)
		create a new instance. name, homeAddr, options and clientID are used for the
		home server's properties. The other servers are represented by their addresses (allAddr)
		in multiclient situation, clientID needs to be different with each participant!
	
	*for(homeServer, allAddr)
		like *new, but directly pass in an already existing server.
		

		
	addresses_(list of net addr)
		set the addresses the server is supposed to broadcast to.
		This usually should include the home address.
	
	homeServer
		return the home server, which is a server that is used for id allocation and all normal
		functions of a individual server model.
	
	name
		returns the name of the server. The name is always the homeServer's name extended by "broadcast"
	
	at(index)
		returns the nth web address.
		
	wrapAt(index)
		returns the nth web address, if index too large, starts from beginning.
		
	do(function)
		iterate over all addresses
		
		
	
	
	
	
// example
	
	
(
x = NetAddr("127.0.0.1", 57201);
y = NetAddr("127.0.0.1", 57202);

a = BroadcastServer(\broad1, x, nil, 0).addresses_( [x, y]);
b = BroadcastServer(\broad2, y, nil, 1).addresses_( [x, y]);

a.boot;
b.boot;
a.makeWindow;
b.makeWindow;
)


a.sendMsg("/s_new", "default", 1980); // create 2 synths, one on each server
b.sendMsg("/n_set", 1980, "freq", 300); // set both their freq control
a.homeServer.sendMsg("/n_set", 1980, "freq", 550); // set only the home server's synth control

// set them to different freqs, from a
(
a.do { arg addr;
	addr.sendMsg("/n_set", 1980, "freq", 450 + 100.rand2);
}
)


// set them to different freqs, from b
(
b.do { arg addr;
	addr.sendMsg("/n_set", 1980, "freq", 450 + 100.rand2);
}
)

b.sendMsg("/n_set", 1980, "gate", 0.0); // release all, from b







