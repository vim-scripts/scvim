Publicdispatch system


superclass: EnvirDispatch




experimental.


Dispatchers like Public can be used for any EnvironmentRedirect, such as LazyEnvir and ProxySpace. They cause a mirroring of parts of the environment to multiple locations. This done by sending the code itself, which is very flexible and leightweight but it also means that one has to be careful not to do harm to the other systems. Code is only sent if it interprets without error on the sender side. Timing is still not yet synchronized, although it works pretty well for not too costly code.

see also: [public_proxy_space]


class methods:

*new(envir) create a new instance (with an EnvironmentRedirect)
 
*all a dictionary of all available dispatchers. dispatchers with the same name 
 send to and receive from each other (alternative: provide a sendToName)
 
*startListen(addr) start to receive messages from the network
 addr: whom to listen to. nil: listen to all. (default)
 
*stopListen stop listening



instance methods:

 
addresses_(list) a list of addresses (NetAddr) to which to send to.
 this list can contain also the sender's address, which it then sends to,
 but does not get evaluated.
 
sendingKeys_(list) keys from which to send (list of symbols). If nil, do not send, if \all, send to all.
 
listeningKeys_(list) keys at which to receive (list of symbols). If nil, do not send, if \all, send to all.
 
 
put(key, obj) put an object in the space (see superclass).
 if this key is sending, send object to all. object must be reproducible
 as a compileString!. (closed functions, patterns with no open functions)
 
at(key) returns an object from the space at that key (see superclass).
 
 
join(channel, nickname) join a channel with a nickname
 
leave leave the channel
 
public_(bool)  if public is set to false, no broadcasting happens.
 
 basicSafety_(bool) if true (default), the "worst" commands are rejected - like unixCmd etc.
 
logSelf_(bool) if logSelf is set to true, my own changes are passed into
 the action function (e.g. the log window)
 
logAll_(bool) if logAll is true, I can see all messages that are coming in, 
 even if they do not effect me (listeningKeys != \all). 
 This is only allowed if sendingKeys are set to \all

channel_(name) set / get channel name

nickname_(string) set / get nickname
 
action_(func) action to be evaluated when receiving a message (optional) function args: dispatch, nickname, key, receivedString
note: if you want to call the os from this action (e.g. for GUI), you need to
 use defer { }
 
makeLogWindow create a log window. 
 
lurk / boss / merge change behaviour diametrically (just try it out)
 

 
// example
 
 

(
var addresses;

Public.startListen; // start an osc responder to dispatch the messages
addresses = [NetAddr("127.0.0.1", 57120)]; // this is loopback for now. Port must be 57120 (sc-lang)
d = Public.new; // create 2 new instances (one "remote" one "local")
e = Public.new;
d.addresses = addresses; // set the addresses - this can be done at any time laterto add new ones.
e.addresses = addresses;

e.join(\waitingroom, \eve); // join a channel, provide a unique nickname.
d.join(\waitingroom, \ade);
e.sendingKeys = \all; // if keys are set to \all, the spaces are enitirelly open.
d.sendingKeys = \all;
d.listeningKeys = \all;
e.listeningKeys = \all;

// create two new environment redirect (works basically like an environment)

a = EnvironmentRedirect.new; 
b = EnvironmentRedirect.new;

// set their dispatch variables. the envir is registered in the dispatch implicitly

a.dispatch = d; 
b.dispatch = e;



)

(
e.makeLogWindow; // see what is going on
d.makeLogWindow;
)



// using the environment

a[\x] = 5;
b[\x]; // 5 is in b now as well.

b[\x] = { 1.0.rand };
a[\x].postcs;

a[\x] = Array.rand(20, 0, 10);
b[\x];

b[\x] = "hi adam";

a[\x] = "hi eve";


// more to come...

a.clear;
b.clear;

