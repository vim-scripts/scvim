
Just In Time Programming

"Passenger to taxtidriver: take me to number 37. I'll give you the street name when we are there."
						(an austrian math teacher's joke)


Disclaimer: there is no time, really; punctuality is your personal responsibility though.


Just in time programming (or: live coding<sup>1</sup>, on-the fly-programming, interactive programming <sup>2</sup>) is a paradigm that includes the programming activity itself in the program's operation. This means a program is not seen as a tool that is made first, then to be productive, but a dynamic construction process of description and conversation - writing code becomes a closer part of musical practice. SuperCollider, being a dynamic programming language, provides several possibilities for modification of a running program - this library attempts to extend, simplify and develop them, mainly by providing abstract placeholders (proxies) that can be modified and used in calculations while playing. There is some specific networking classes which are made to simplify the distribution of live coding activity.


Jitlib consists of a number of placeholders (server side and client side) and schemes of access.
These two aspects of space corresponding to inclusion and reference, depend on their context - here the placeholders are like roles which have a certain behaviour and can be fulfilled by certain objects.
It is useful to be aware of the three aspects of such a placeholder: a certain set of elements can be their source, they can be used in a certain set of contexts and they have a certain default source, if none is given.






Tutorial: Interactive Programming with SuperCollider and jitlib

This tutorial focusses on some basic concepts used in JITLib. There are many possibilities,
such as server messaging and pattern proxies which are not covered in tutorial form presently.


content:

	placeholders in sc 				jitlib_basic_concepts_01
	referencing and environments 	jitlib_basic_concepts_02
	internal structure of node proxy 	jitlib_basic_concepts_03
	timing in node proxy 			jitlib_basic_concepts_04






Overview of the different classes and techniques:


 One way or style of access is the 'def' classes (Pdef, Ndef etc.)
	it binds a symbol to an object in a specific way:
	Pdef(\name) returns the proxy
	Pdef(\name, object) sets the source and returns the proxy.
	the rest of the behaviour depends on its use.
	
	client side: 	Pdef Pdefn, Tdef, Pbindef, Psym, Pnsym
	server side: 	Ndef
	
 Another way, for server side NodeProxies, is an environment that returns placeholders on demand:
	ProxySpace.push
	~out = { ...}
	helpfile: 		ProxySpace for the use together with other environments, see jitlib_basic_concepts_02
	
 there is also direct access without using the access schemes: NodeProxy, TaskProxy etc. provide it.
	internally the former use these as base classes.

	client side: 	PatternProxy, EventPatternProxy, TaskProxy, PbindProxy, Pdict
	server side: 	NodeProxy, RecNodeProxy

 in remote and local networks thanks to sc-architecture node proxies can be used on any server,
	as long as it notifies the client and has a correctly initialized default node.
	note that the client id should be set.
	using the network classes, groups of participants can interfere into each other's composition
	by sharing a common server, using SharedNodeProxy and exchanging code and comments
	in a chat (see Client)
	networking classes:	
	
			experimental:
			Public distribute environments over networks.
			public_proxy_space how to distribute a ProxySpace	
			Client simplifies client-to-client networking.
			
			stable:
			BroadcastServer
			OSCBundle
	

								
tutorials:		proxyspace_examples
			jitlib_efficiency
			the_lazy_proxy
			jitlib_fading
			jitlib_asCompileString
			recursive_phrasing
			jitlib_networking
			
			
live coding without jitlib:	basic_live_coding_techniques


storage:			NodeMap storing control setting
				Order 	ordered collection




unconnected other classes:
	
UGens	
	TChoose
	TWChoose
	





for suggestions / comments contact me
Julian Rohrhuber, rohrhuber@uni-hamburg.de

Thanks a lot for all the feedback and ideas!

History and GUI classes are written by Alberto de Campo.


[1] see for example http://toplap.org
[2] dynamic programming would have been a good term, but it is in use for something else already
	compare:
		http://en.wikipedia.org/wiki/Dynamic_programming
		http://en.wikipedia.org/wiki/Dynamic_programming_language








RECENT CHANGES:

2007
	february		added prime method for NodeProxy to allow setting sources quietly
	march		errors in Pdef classes are handled correctly, so that proxy player stops.
				clear an remove messages added to PatternProxy.

2006	
	december		added quantize method
				fixed addAction bug in Monitor, updated helpfile
	august		EnvironmentRedirect (and so ProxySpace) now return the source when
				using the setter envirPut: ~out = 8; returns 8 now.
				NodeProxy adapts inputs to appropriate rate.
	
	july			optimized graph layout in NodeProxy to minimize latency



