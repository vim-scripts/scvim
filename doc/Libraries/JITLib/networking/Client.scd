
Client				represents a remote sclang application



	Client and LocalClient together represent a sender / reciever pair for sclang side osc messages.
	Using SynthDef like global function definitions, ClientFunc, an sclang application
	can evaluate code on a remote sclang app.




Class Methods

	*new(name, netAddr)
			returns a new instance and stores it in a global dictionary
			the port is set to defaultPort, which is hardcoded presently.
			if no address is passed in, localhost is used.


Instance Methods

	send(key, args ...)
		evaluates a client function that is stored at that key
	
	password_ (symbol)
		set the password for interpreter access
	
	cmdName_
		set the cmdName under which the client sends (default: '/client')
		this cmdName must be the same like the LocalClient reciever cmdName
	
	interpret(string)
		if the remote client has the same password, it interprets the string






LocalClient		represents a listener to a remote sclang application
	
	superclass: Client

	
	Note that passing a nil address to LocalClient will make it respond to any remote client
	and try to match any message that is sent from a client object.
	If it is expected to listen to a specific remote client, the address of that client should be used.

Instance Methods	
	
	start
		start listening to the world
		
	stop
		stop listening to the world
	
	remove
		remove from client list
		
	isListening
		returns whether it is listening to the world
		
	password_ (symbol)
		set the password for interpreter access from outside
		
	cmdName_
		set the cmdName under which the client recieves (default: '/client')
		this cmdName must be the same like the Client sender cmdName
		
	allowInterpret
		open the interpreter to the world (potential hacking danger)
		
	disallow
		close the interpreter access
	
	
	
	
ClientFunc		similar to SynthDef - represents a client side stored function
	
	*new(name, func)
		
	global function that is accessed by LocalClient when a message is recieved.
	the key sent is a key of the ClientFunc that is evaluated.
	the other args are passed to the function: time, responder, args...
		
Note:

	for accessing a gui element or a document from an OSCResponder such as the one
	in LocalClient, one has to defer the action:
	
	ClientFunc(\ok, { defer({ ... }) });




// example
// instantiate a remote-local pair (in this case both are local of course)
a = LocalClient.default; 	// this one listens to any remote client and evaluates the functions.
b = Client.new;		// this one sends the messages

// eqivalent to the above defaults:
a = LocalClient(\default, nil); //addr is nil : listen to all
b = Client(\default, NetAddr("127.0.0.1", 57120));

// store some client functions to be accessible from outside (analogous to SynthDef)
ClientFunc(\ok, { arg ... args; args.postln });
ClientFunc(\yes, { arg ... args; \ok2.postln });

// start the local client
a.start;

// send messages
b.send(\ok, "rrere", 39);
b.send(\ok, "rrxxxre");
b.send(\ok, 2, 3, 4, 5, 6);
b.send(\yes, "rrere", 39);
b.send(\yes);


opening remote interpreter access is risky, because
anyone can access the interpreter (also unix commands)
if you do not set the password, this is not possible.

// open interpreter
a.password = \xyz;
b.password = \xyz;
a.allowInterpret;

// remote interpret
b.interpret(" Array.fill(8, { [1,0].choose }).postln ");
b.interpret(" String.fill(80, { [$u, $n].choose }).postln");

// remote GUI
b.interpret(" SCWindow.new(\"aLl uR mAchIneZ are bEloNg to us!\").front;{ SinOsc.ar(500, 0, LFPulse.kr(4)) }.play;"); 

// close interpret
a.disallow

//test: this should not interpret
b.interpret(" String.fill(8, { [$u, $n].choose }).postln");

a.stop; //stop local responder



writing a chat


(
// hit tab for sending
var n, d, e, b;
n = "John";
d = Document("chat").background_(Color.rand).bounds_(Rect(30, 10, 400, 200));
e = Document("chat-write").background_(Color.rand).bounds_(Rect(30, 210, 400, 50));

a = LocalClient.default.start;	
b = Client.new;
ClientFunc(\chat, { arg str; { d.string = d.string ++ str ++ "\n" }.defer });

e.keyDownAction_({arg doc, char;
	var string;
	 if(char === Char.tab)
	 {
	 	string = n + ":" + e.currentLine;		
	 	b.send(\chat, string.copy);
	 	AppClock.sched(0.1, { e.string = "" }); // time is the original crime. remove the tab.
	 }
});
e.onClose_({ AppClock.sched(0.1, { a.remove; d.close; nil }) }); // sched, otherwise sc crashes
)



