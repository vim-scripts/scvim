Just In Time Programming

"Passenger to taxtidriver: take me to number 37. I'll give you the street name when we are there." 
 (an austrian math teacher's joke)


Disclaimer: there is no time, really; punctuality is your personal responsibility though.


Just in time programming (or: live coding1, on-the fly-programming, interactive programming 2) is a paradigm that includes the programming activity itself in the program's operation. This means a program is not seen as a tool that is made first, then to be productive, but a dynamic construction process of description and conversation - writing code becomes a closer part of musical practice. SuperCollider, being a dynamic programming language, provides several possibilities for modification of a running program - this library attempts to extend, simplify and develop them, mainly by providing placeholders (proxies) that can be modified and used in calcuations while playing. There is some specific networking classes which are made to simplify the distribution of live coding activity.


Jitlib consists of a number of placeholders (server side and client side) and schemes of access.
These two aspects of space corresponding to inclusion and reference, depend on their context - here the placeholders are like roles which have a certain behaviour and can be fulfilled by certain objects.
It is useful to be aware of the three aspects of such a placeholder: a certain set of elements can be their source, they can be used in a certain set of contexts and they have a certain default source, if none is given.






Tutorial: Interactive Programming with SuperCollider and jitlib

This tutorial focusses on some basic concepts used in JITLib. There are many possibilities,
such as server messaging and pattern proxies which are not covered in tutorial form presently.


content:

placeholders in sc [jitlib_basic_concepts_01]
referencing and environments [jitlib_basic_concepts_02]
internal structure of node proxy[jitlib_basic_concepts_03]
timing in node proxy [jitlib_basic_concepts_04]






Overview of the different classes and techniques:


? One way or style of access is the 'def' classes (Pdef, Ndef etc.)
 it binds a symbol to an object in a specific way:
 Pdef(\name) returns the proxy
 Pdef(\name, object) sets the source and returns the proxy.
 the rest of the behaviour depends on its use.
 
 client side: [Pdef] [Pdefn], [Tdef], [Pbindef]
 server side: [Ndef]

? Another way, for server side NodeProxies, is an environment that returns placeholders on demand:
 ProxySpace.push
 ~out = { ...}
 helpfile: [ProxySpace] for the use together with other environments, see [jitlib_basic_concepts_02]

? there is also direct access without using the access schemes: NodeProxy, TaskProxy etc. provide it.
 internally the former use these as base classes.

 client side: [PatternProxy], [EventPatternProxy], [TaskProxy], [PbindProxy], [Pdict]
 server side: [NodeProxy], [RecNodeProxy]

? in remote and local networks thanks to sc-architecture node proxies can be used on any server, 
 as long as it notifies the client and has a correctly initialized default node.
 note that the client id should be set.
 using the network classes, groups of participants can interfere into each other's composition
 by sharing a common server, using SharedNodeProxy and exchanging code and comments 
 in a chat (see Client)
 networking classes: 
 experimental:
[Public] distribute environments over networks.
[public_proxy_space] how to distribute a ProxySpace 
 [Client] simplifies client-to-client networking. 
 
 stable:
 [BroadcastServer]
[OSCBundle]


 
tutorials:  [proxyspace_examples]
 [jitlib_efficiency]
 [the_lazy_proxy]
 [jitlib_fading]
 [jitlib_asCompileString]
 [recursive_phrasing]
 [jitlib_networking]
 
 
live coding without jitlib: [basic_live_coding_techniques]


storage: [NodeMap] storing control setting
 [Order] ordered collection




unconnected other classes:

UGens 
[TChoose]
 [TWChoose]
 





for suggestions / comments contact me
Julian Rohrhuber, rohrhuber@uni-hamburg.de

Thanks a lot for all the feedback and ideas!


[1] see for example http://toplap.org
[2] dynamic programming would have been a good term, but it is in use for something else already
 compare: 
 http://en.wikipedia.org/wiki/Dynamic_programming
 http://en.wikipedia.org/wiki/Dynamic_programming_language








RECENT CHANGES:

2005 
 october node proxy: developments with alberto de campo:
 added playN method for larger multichannel setups
 getKeysValues and controlKeys 
 
 september
 node proxy: 
 unset works (not tested for setn)
 nodeproxy.at now returns source, not play control object
 control rate proxies now crossfade really linearly.
 
 NodeProxy (BusPlug) can be passed a parentGroup now.
 also ProxySpace can play in a given group (proxyspace.group = ...)
 
 may
 pattern proxies: added de Campo suggestion:
 pattern proxies have now an update condition. reset method, if stuck.
 there is also an .endless method that will embed the proxy endlessly.
 
 node proxy multichannel expansion with arrays of numbers works now more like expected
 ~x = [~a, ~b, ~c]; expands into 3 channels
 ~x[0..] = [~a, ~b, ~c]; expands into 3 slots (mixing the inputs)
 
 april
 networking: removed PublicProxySpace, added a Dispatcher class [Public] that 
 does the same for any EnvironmentRedirect.
 
 march
 pattern proxies: all can have an environment, and take functions as arguments as well.
 Tdef/TaskProxy take also a pattern as argument (for time streams).
 Tdef .fork: fork a thread.
 defaults now end (no looping by default)
 nodeproxy.clear and proxyspace.have a fadeTime argument now
 
 nodeproxy / nodemap: mapEnvir now takes not an array of keys, but multiple arguments
 (.mapEnvir(\a, \b, \c) instead of .mapEnvir([\a, \b, \c])
 

 febuary
 improved network classes, PublicProxySpace
 added envir variable to pattern proxies, the respond to set / map now.
 

 january
 nodeproxy.source now returns the sources
 added tutorial 
 
2004
 december 
 fixed a bug when loading node proxy if the server is fresh.
 node proxy now removes its synthdefs from the server.
 Pdef: quant can now have the form [quant, offset]
 networking:
 removed Router class. see BroadcastServer helpfile.
 experimental network classes added, old ones changed.
 
 october
 fixed a bug in Tdef/Pdef where the clock wasn't passed in (.play) properly when it was set before.
 NodeProxy is more efficient in building SynthDefs.
 ProxySynthDef can be used independent of NodeProxy now
 
 september
 refactored Pdef: new subclasses
 improvements in NodeMap and NodeProxy
 added role scheme (helpfiles to come)
 
 august
 nodeProxy.mapn expands to multiple controls. (not by arrays of keys anymore!)
 some small efficiency improvements
 
 july
 Pdef/Tdef: pause and resume are now beat quantized
 embedInStream is more efficient now, fadeTime is only applied for transitions
 added recursive phrasing event
 corrected Client bundle size calculation
 NodeProxy remove/stop now differentiated, to allow ressource freeing in future (mainly cx players)
 nodeMap_( ) fixed (unmaps synth now)
 filter method for node proxy
 
 
 
 june
 removed N / Debug class to reduce number of classes.
 NodeProxy/ProxySpace:
 wrapForNodeProxy improved (Bus works now, NodeProxy more tolerant)
 simplified object wrapping
 added monitor class, separated monitoing from BusPlug
 channel expansion works with .play now (converting number of channels)
 removed toggle method. 
 onClear, monitorGroup, vol slots are removed (monitorGroup, vol is in monitor)
 node order in multi object node proxy works more efficiently
 multiple put: a[2..5] = { ... }
 Pdef:
 added fadeTime
 Pdefn default is 1.0 now, which is safer for use in time patterns.
 avoid occasional duplicate notes when changing pattern
 Tdef is more error proof.
 ProxySpace has a parent. the proto slot is used to store the tempo proxy.
 
 bugfixes:
 SynthDef-hasGateControl fixed
 InBus static float index works now
 bugfix in Order-detect
 fix unset/unmap bug
 supplementNodeMap also works for non functions.
 
 
 may
 loading large proxyspaces now works - no late messages anymore
 fixed bug in NodeProxy.clear when using patterns
 fixed group order
 added crossfade support for Patterns (EventStreams)
 added crossfaded input offset (using e.g. .ar(1, offset))
 removed Channel ugen, added XIn Ugens
 lineAt, xlineAt messages work now
 fixed the read example in [jitlib_efficiency]
 nodeProxy.send now sends all if no index is given
 refactoring, readability improved.
 
 april
 fixed bug on ProxySpace-reduce that caused infinite recursion in some cases
 fixed bug in BinaryOpPlug (account for function.rate returning \stream)
 
 new version of Pdef/Pdefn/Tdef
 
 experimental: 
 added .storeOn, .document methods for ProxySpace. see [jitlib_asCompileString] 
 
 
 march
 fixed Pattern support for NodeProxy/ProxySpace due to change in Event implementation
 fixed Prefn
 removed Penvir, Sfin etc, Ensemble etc. (removed classes can be found on sc-swiki)
 simplifications
 
 feb
 added garbage collector to ProxySpace
 fixed unmap
 control rate proxies do not wrap channels anymore.
 
 jan 
 Pref / Prefn are tested, update properly. I'm thinking of merging them with Pdef.
 fixed wakeUp bug in NodeProxy.
 fixed bug in load when no server is present
 
 embed control proxies in streams as bus index, allow multichannel mapping in patterns
 added possibility to use \offset key in event streams to have offset index in multichannel proxy
 fixed bug in lazy init
 
2003
 
 nov
 Pdef, Tdef work now, also with NodeProxy.
 NodeProxy-releaseAndFree is replaced by .end.
 
 oct
 symbol input is assumed to represent a synthdef that has a gate and frees.
 functions and synthdefs are searched for their inner envelopes and the appropriate
 method of freeing / releasing is chosen accordingly.
 
 earlier:
 input channels now wrap. so any number of channels can be set to any proxy.
 
 ar and kr take a second argument for the channel offset within the proxy
 checked all helpfiles
 
 put now has a different arg order! a.put(0, obj) or a[0] = obj
 prependargs were removed for now.
 lag can be set by name a.lag(\freq, 1)
 a shortcut was added to efficiently read from another proxy: a.read(b) or a.read([b, c])

 added granular / xtexture functionality: gspawner / spawner (experimental, might change)


 a.play now does not create multiple synths if evaluated repeatedly (unless multi: true)
 lazy init works now.
 
 bin/unops work fully now again like any math op.


