
Index index into a table with a signal

Index.ar(bufnum, in, mul, add)
Index.kr(bufnum, in, mul, add)

The input signal value is truncated to an integer value and used as an index into the table.
Out of range index values are clipped to the valid range.
bufnum - index of the buffer
in - the input signal.


(
// indexing into a table
s = Server.local;
t = [ 200, 300, 400, 500, 600, 800 ];
b = Buffer(s,t.size,1);

// alloc and set the values
s.listSendMsg( b.allocMsg( b.setnMsg(0, t) ).postln );

SynthDef("help-Index",{ arg out=0,i_bufnum=0; 
 Out.ar(0,
 SinOsc.ar(
 Index.kr( 
 i_bufnum,
 LFSaw.kr(2.0).range(0.0,7.0)
 ),
 0,
 0.5
 ) 
 )
}).play(s,[\i_bufnum,b.bufnum]);

)


/*

(
// indexing into a table
var table;
table = [ 200, 300, 400, 500, 600, 800 ];
b = 
Synth.play({ 
 SinOsc.ar(
 Index.kr( 
 table, 
 MouseX.kr(0, table.size)
 ),
 0,
 0.1
 ) 
});
)


*/

