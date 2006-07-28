


play
 prepareToBundle(group,bundle)
 loadDefFileToBundle(bundle,server)
 children loadDefFileToBundle(bundle,server)
 asSynthDef 
 //children prepareToBundle
 makeResourcesToBundle
 makePatchOut
 children makePatchOut
 
 
 makePatchOut(group,public)
 numChannels
 rate
 
 childrenMakePatchOut(group,public)
 children makePatchOut
 
 spawnAtTime(atTime)
 spawnToBundle(bundle)
 children spawnToBundle(bundle)
 defName
 synthDefArgs
 
 didSpawn
 
 
as a child of something else

loadDefFileToBundle(bundle,server)
 children loadDefFileToBundle(bundle,server)
 asSynthDef 

spawnToBundle(bundle)
 children spawnToBundle(bundle)
 defName
 synthDefArgs

makePatchOut(group,public)
 numChannels
 rate
 
