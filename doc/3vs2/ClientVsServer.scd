
Client versus Server Operations

Unlike in SC2 where language and synthesis were unified in a single application, SC3 divides its operations between a language application (the SuperCollider app on which you double-clicked to startup SC) and a synthesis-server application (a UNIX command-line application called scsynth, which is started when you press the boot button on the 'local' server window that is created by default at startup, or when you boot a Server from code). The two applications communicate between each other through UDP or TCP using a subset of CNMAT's Open Sound Control.

This is a radical departure from the previous architecture (a more detailed discussion of this and other matters can be found in the file sc3 intro 2 in the Examples folder) and yields several important advantages:

The server can be controlled by programs other than the language app.
The language app can crash and synthesis will not stop.
The server can crash and the language will not.
The language and server apps can be running on different machines, even in different parts of the world. This allows for efficient 'division of labour' and network interactivity.

There is one notable drawback: The messaging process introduces a small amount of latency. This should not be confused with audio latency which can be quite low. It only means that there is a small, usually insignificant delay between the one side sending a message and the other receiving it and acting upon it. (This can be minimized by using the 'internal' server. See Server for more detail.)

What is crucial to understand is the distinct functions of each side. The server app is a lean and efficient program dedicated to audio functions. It knows nothing about SC code, objects, OOP, or anything else to do with the SC language. It has (at least for the moment) little programmatic ability.

When one creates a Synth object in the language app, that object is only the clientside representation of a node on the server. The language app provides you with convienent OOP functionality to keep track of and manipulate things on the server. All of this functionality is possible to do 'by hand' using the sendMsg method of Server, and other similar messages. For instance:

	s = Server.default;
	s.boot;
	
// this
	n = s.nextNodeID;
	s.sendMsg("/s_new", "default", n); // use the SynthDef "default"
	s.sendMsg("/n_free", n);
	
// is equivalent to
	x = Synth("default");	// create a synth on the default server (s) and allocate an ID for it
	x.free;				// free the synth, its ID and resources
	
The latter method gives you certain functionality. It gets a node ID for you automatically, it allows you to control the Synth in syntactically elegant and efficient ways (see the Synth and Node helpfiles), and to access all the advantages of object oriented programming while doing so. Encapsulating the complexities and bookeeping greatly reduces the chance of bugs in your own code.

It also has a small amount of overhead. It requires clientside CPU cycles and memory to create and manipulate an object. Normally this is not significant, but there may be times when you would prefer to use the less elegant, and less expensive first method, for instance when creating large numbers of grains which will simply play and then deallocate themselves.

Thus it is possible to create synth nodes on the server without actually creating Synth objects, providing you are willing to do the required housekeeping yourself. The same is true of group nodes, buffers, and buses. A more detailed discussion of these concepts can be found in the NodeMessaging helpfile.

In conclusion, the crucial thing to remember is the distinction between things like nodes, busses, buffers, and servers and the objects that represent them in the language app (i.e. instances of Node, Bus, Buffer, and Server). Keeping these conceptually distinct will help avoid much confusion.


