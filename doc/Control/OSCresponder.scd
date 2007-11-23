
OSCresponder				client side network responder


Register a function to be called upon receiving a specific command from a specific OSC address.


Examples: see [OSCresponderNode]

	*new(addr,cmdName,action);

	addr		
		the address the responder receives from (an instance of NetAddr, e.g. Server.default.addr)
		an address of nil will respond to messages from anywhere.
	
	cmdName
		an OSC command eg. '/done'
	
	action
		a function that will be evaluated when a cmd of that name is received from addr.
		arguments: time, theResponder, message, addr
		note that OSCresponder evaluates its function in the system process.
		in order to access the application process (e.g. for GUI access ) use { ... }.defer;
				
Note:
	A single OSCresponder may be set up for each addr and cmdName combination. 
	Subsequent registrations will overwrite previous ones. See OSCresponderNode.

	Whenever an OSC message is sent to the SuperCollider application (the language, not the server), either 	Main-recvOSCmessage or Main-recvOSCbundle is called. There, the messages are forwarded to the 	OSCresponder class using the OSCresponder-respond class method. 


	add
		add this responder instance to the list of active responders. 
		The OSCresponder is not active until this is done.

	remove
		remove and deactivate the OSCresponder

	removeWhenDone
		remove and deactivate the OSCresponder when action is done.
	
	//syntax:	
	OSCresponder(addr,cmdName,action).add.removeWhenDone;
	
	
	*add(oscResponder)
		 add the responder instance
	
	
	*remove(oscResponder)
		remove the responder instance
	
	
	*removeAddr(addr)
		remove all OSCresponders for that addr.









