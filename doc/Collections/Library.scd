Library

superclass: MultiLevelIdentityDictionary

This is a single global MultiLevelIdentityDictionary.
There is only one of them ever.

The last argument to put is the object being inserted:

Library.put(\multi,\level,\addressing,\system,"i'm the thing you put in here");

Library.at(\multi,\level,\addressing,\system).postln;

Library.atList([\multi,\level,\addressing,\system]).postln;



postTree
 post a formatted description of the entire library
 
 Library.postTree;