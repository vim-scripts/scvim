SendTrig

On receiving a trigger (a non-positive to positive transition), send a trigger message from the server back to the client.

 SendTrig.kr( input, id, value )
input - the trigger
id - an integer that will be passed with the trigger message.
 this is useful if you have more than one SendTrig in a SynthDef
value - a UGen or float that will be polled at the time of trigger,
 and its value passed with the trigger message
 
The trigger message sent back to the client is this:  
/tr a trigger message
 int - node ID
 int - trigger ID
 float - trigger value

This command is the mechanism that synths can use to trigger events in clients.
The node ID is the node that is sending the trigger. The trigger ID and value are determined by inputs to the SendTrig unit generator which is the originator of this message.


s = Server.local;
s.boot;

SynthDef("help-SendTrig",{
 SendTrig.kr(Dust.kr(1.0),0,0.9);
}).send(s);

// register to receive this message
OSCresponder(s.addr,'/tr',{ arg time,responder,msg;
 [time,responder,msg].postln;
}).add;

Synth("help-SendTrig");


