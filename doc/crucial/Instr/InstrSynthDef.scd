InstrSynthDef

this is how Patch performs its magic.

how it works :

InstrSynthDef.build( instr, objects, outClass )
 
 each object is asked to initForSynthDef(synthDef,argIndex)
 BufferProxy classes use the argument index to build a unique key
 so they dont conflict with other BufferProxies.
 all other classes need do nothing.

 each object is asked to addToSynthDef(synthDef,argName)
 depending on the objects rate it asks the synthDef to
 addKr(argName,value,lag)
 addIr(argName,value)
 addInstrOnlyArg(argName,value)
 
 the object may choose which initial value to pass. if a Player does not yet
 know its bus assignment, it can safely pass a 0 as it will be asked what bus
 it is playing on when the actual synth is being started.
 objects such as Env or Float or Array will pass themselves as an instrOnly arg, 
 thus fixing them in the synthDef
 objects such as Sample can be used in the course of the ugenGraph evaluation
 to add 'secret' additional inputs. (see below)
 
 the synthDef builds Control objects from the kr and ir inputs.
 
 each object is asked to return an instrArgFromControl(control,argIndex)
 Players return In.ar(control, this.numChannels) or In.kr
 the control is a kr OutputProxy that indicates the bus that input 
 should listen to.
 KrNumberEditors return either the raw control or wrap it in a Lag
 Stream2Trig returns an InTrig.kr(control,1)
 Object returns itself
 so a Sample or an Env is passed into the instr function, and in 
 fact the control it was passed is nil since it would have used
 addInstrOnlyArg
 
 the instr function is valued with those objects.
 during the course of the ugenFunc evaluation,
 BufferProxy objects (Sample etc.) may request to addSecretIr or addSecretKr
 arguments. this is to request additional inputs to the synth that do not
 have arguments in the instr function. thus a Sample can pass itself to the
 instr function as an object, and then request a synth input that will be used
 to get the bufnum dynamically passed in when the synth actually plays.
 
 this can also be used to request a tempo bus input (not yet implemented)
 
 the Out.ar and a kr control of the name \out are added bassed on the rate and numChannels
 of the result of the ugenFunc.
 
 the unique synthDef name is calculated. the name should represent the instr name
 and the fixed inputs that were used to evaluate it. any Patch that uses the
 same fixed inputs (SimpleNumbers) should be able to share the synthDef,
 and all the variable inputs should be of compatible rate and numChannels.
 
 