ZArchive

superclass: File

A safe binary archive format. Supports large file sizes.

Compresses strings and symbols using a string lookup table.
 (limit: 65536 different strings/symbols maximum)

Compresses repeated values
 (limit: 4294967296 consecutive repeated items)

The text archive written by Object.writeArchive will store an object and
restore all of its internal variables. However, it will break with large file sizes
because it actually writes compilable code and there is a limit to that.

The binary archives written by Object.writeBinaryArchive will break if the
instance variables change in any of the classes you have archived.

This class is designed for raw data storage that you manually and explictly control.

You manually write to the archive and then should read from the archive in the same
order you wrote in. You could also write a Dictionary and then not worry about order.
This would also let you add or remove fields later without breaking the archives.

*write(path)
 open an archive for writing
 
writeItem(item) -
 this will write a character specifying the class type of the object and then will write the object
 in the smallest possible format. 
 Floats, Integers, Strings, Symbols, SequenceableCollections and Dictionaries all have 
 support to write to the archive. eg. a Float writes a float to the file.
 Strings and Symbols write using a string table, so your 10000 Events with \degree in them will only
 need to save the word "degree" once.
 All other objects will be saved asCompileString.

writeClose
 finish the write session and close the file.
 
*read(path)
 open an archive for reading
 
 readItem(expectedClass) -
 read an item from the file. If expectedClass is non-nil, it will throw an error if the item is of 
 a different class.

<>version -
 you may set the version number so that your various objects can check the version of the archive.
 you need to store and retrieve the version number yourself, the ZArchive won't do it automatically.
 Its just a convienient variable.
 

(

a = ZArchive.write("archiveTest");

a.writeItem(1.0.rand);
a.writeItem([1,2,3,4,5].choose);
a.writeItem("hello");
a.writeItem(
 Event.make({
 ~a = \a;
 ~b = \b;
 })
);
a.writeItem([1,2,3,4,5]);
a.writeItem( Ref(4.0) );
a.writeItem([
 Event[
 ('time' -> 149.797), ('delta' -> 0.453), ('m' -> [ 'setVolAt', 0, 0.415356 ])
 ],
 Event[ 
 ('time' -> 150.25), ('delta' -> 0.478), ('m' -> [ 'setVolAt', 0, 0.37382 ])
 ],
 Event[ 
 ('time' -> 150.728), ('delta' -> 0.428), ('m' -> [ 'setVolAt', 0, 0.336438 ])
 ]
]);
a.writeItem([
 IdentityDictionary[
 \a -> "b",
 "b" -> \c
 ]
]); 
a.writeClose;

)


(
b = ZArchive.read("archiveTest");
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;
b.readItem.postln;


b.close;

)



(

a = ZArchive.write("archiveTest");

a.writeItem(5);
a.writeItem( [ Event[ 
 ('time' -> 0), ('delta' -> 7.68278), ('m' -> [ 'state_', Environment[ 
 ('efxpath' -> ":Patches:justefx:4subtleDisturb er"), ('mixes' -> [ 0, 0.328532, 1, 0 ]), ('subject' -> Environment[ 
 ('subject' -> Environment[ 
 ('paths' -> [ ":Patches:splash:chewy", ":Patches:twisters:wahfunk", ":Patches:riddims:slowrollzghet", nil ]), ('amps' -> [ 0.177931, 0.42807, 0.219667, 0.7 ])
 ]), ('filterObjects' -> [ nil, nil, nil, nil ])
 ])
 ] ])
 ], Event[ 
 ('time' -> 7.68278), ('delta' -> 2.0898), ('m' -> [ 'selectByPath', 2, ":Patches:riddims:geekslut" ])
 ], Event[ 
 ('time' -> 9.77257), ('delta' -> 0.41796), ('m' -> [ 'setVolAt', 2, 0.197701 ])
 ], Event[ 
 ('time' -> 10.1905), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 2, 0.177931 ])
 ], Event[ 
 ('time' -> 10.5853), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 2, 0.160138 ])
 ], Event[ 
 ('time' -> 10.98), ('delta' -> 0.32508), ('m' -> [ 'setVolAt', 2, 0.144124 ])
 ], Event[ 
 ('time' -> 11.3051), ('delta' -> 8.75393), ('m' -> [ 'setVolAt', 2, 0.129711 ])
 ], Event[ 
 ('time' -> 20.059), ('delta' -> 8.96291), ('m' -> [ 'selectByPath', 2, ":Patches:riddims2:jRunnin" ])
 ], Event[ 
 ('time' -> 29.0219), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 2, 0.142683 ])
 ], Event[ 
 ('time' -> 29.4167), ('delta' -> 5.61923), ('m' -> [ 'setVolAt', 2, 0.156951 ])
 ], 
 Event[ 
 ('time' -> 35.0359), ('delta' -> 0.41796), ('m' -> [ 'setVolAt', 2, 0.172646 ])
 ], Event[ 
 ('time' -> 35.4539), ('delta' -> 2.71674), ('m' -> [ 'setVolAt', 2, 0.18991 ])
 ], Event[ 
 ('time' -> 38.1706), ('delta' -> 1.36998), ('m' -> [ 'setMixOnVoice', 2, 1 ])
 ], Event[ 
 ('time' -> 39.5406), ('delta' -> 0.3483), ('m' -> [ 'setMixOnVoice', 2, 0.85 ])
 ], Event[ 
 ('time' -> 39.8889), ('delta' -> 0.41796), ('m' -> [ 'setMixOnVoice', 2, 0.722501 ])
 ], Event[ 
 ('time' -> 40.3068), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.614126 ])
 ], Event[ 
 ('time' -> 40.6784), ('delta' -> 1.161), ('m' -> [ 'setMixOnVoice', 2, 0.522007 ])
 ], Event[ 
 ('time' -> 41.8394), ('delta' -> 2.85606), ('m' -> [ 'setMixOnVoice', 1, 1 ])
 ], Event[ 
 ('time' -> 44.6954), ('delta' -> 1.7415), ('m' -> [ 'setMixOnVoice', 1, 1 ])
 ], Event[ 
 ('time' -> 46.4369), ('delta' -> 2.85606), ('m' -> [ 'wakeEffectByPath', ":Patches:justefx:pitchCasStereoSprd" ])
 ], 
 Event[ 
 ('time' -> 49.293), ('delta' -> 0.41796), ('m' -> [ 'setMixOnVoice', 1, 0.85 ])
 ], Event[ 
 ('time' -> 49.7109), ('delta' -> 0.696599), ('m' -> [ 'setMixOnVoice', 1, 0.7225 ])
 ], Event[ 
 ('time' -> 50.4075), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 1, 0.385263 ])
 ], Event[ 
 ('time' -> 50.8023), ('delta' -> 0.44118), ('m' -> [ 'setVolAt', 1, 0.346736 ])
 ], Event[ 
 ('time' -> 51.2435), ('delta' -> 11.4707), ('m' -> [ 'setVolAt', 1, 0.312063 ])
 ], Event[ 
 ('time' -> 62.7141), ('delta' -> 1.46286), ('m' -> [ 'selectByPath', 0, ":Patches:clouds:newjetengine" ])
 ], Event[ 
 ('time' -> 64.177), ('delta' -> 0.673379), ('m' -> [ 'setVolAt', 0, 0.160138 ])
 ], Event[ 
 ('time' -> 64.8504), ('delta' -> 0.51084), ('m' -> [ 'setVolAt', 0, 0.144124 ])
 ], Event[ 
 ('time' -> 65.3612), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 0, 0.129711 ])
 ], Event[ 
 ('time' -> 65.7559), ('delta' -> 8.89325), ('m' -> [ 'setVolAt', 0, 0.11674 ])
 ], 
 Event[ 
 ('time' -> 74.6492), ('delta' -> 4.50468), ('m' -> [ 'setVolAt', 0, 0.128414 ])
 ], Event[ 
 ('time' -> 79.1539), ('delta' -> 1.92726), ('m' -> [ 'selectByPath', 0, ":Patches:clouds:screamspac" ])
 ], Event[ 
 ('time' -> 81.0811), ('delta' -> 10.449), ('m' -> [ 'setVolAt', 0, 0.115573 ])
 ], Event[ 
 ('time' -> 91.5301), ('delta' -> 9.84527), ('m' -> [ 'sleepVoice', 0 ])
 ], Event[ 
 ('time' -> 101.375), ('delta' -> 0.3483), ('m' -> [ 'setVolAt', 2, 0.208902 ])
 ], Event[ 
 ('time' -> 101.724), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 2, 0.229792 ])
 ], Event[ 
 ('time' -> 102.118), ('delta' -> 2.06658), ('m' -> [ 'setVolAt', 2, 0.252771 ])
 ], Event[ 
 ('time' -> 104.185), ('delta' -> 0.32508), ('m' -> [ 'setMixOnVoice', 2, 0.443706 ])
 ], Event[ 
 ('time' -> 104.51), ('delta' -> 0.39474), ('m' -> [ 'setMixOnVoice', 2, 0.377151 ])
 ], Event[ 
 ('time' -> 104.905), ('delta' -> 2.322), ('m' -> [ 'setMixOnVoice', 2, 0.320578 ])
 ], 
 Event[ 
 ('time' -> 107.227), ('delta' -> 1.161), ('m' -> [ 'setMixOnVoice', 2, 0.272492 ])
 ], Event[ 
 ('time' -> 108.388), ('delta' -> 1.95048), ('m' -> [ 'setMixOnVoice', 2, 1 ])
 ], Event[ 
 ('time' -> 110.338), ('delta' -> 0.41796), ('m' -> [ 'setMixOnVoice', 1, 0.614125 ])
 ], Event[ 
 ('time' -> 110.756), ('delta' -> 0.928799), ('m' -> [ 'setMixOnVoice', 1, 0.73695 ])
 ], Event[ 
 ('time' -> 111.685), ('delta' -> 10.1471), ('m' -> [ 'setMixOnVoice', 1, 1 ])
 ], Event[ 
 ('time' -> 121.832), ('delta' -> 1.71828), ('m' -> [ 'setVolAt', 1, 0.280856 ])
 ], Event[ 
 ('time' -> 123.55), ('delta' -> 2.0898), ('m' -> [ 'setVolAt', 1, 0.252771 ])
 ], Event[ 
 ('time' -> 125.64), ('delta' -> 6.13007), ('m' -> [ 'setVolAt', 1, 0.227494 ])
 ], Event[ 
 ('time' -> 131.77), ('delta' -> 1.99692), ('m' -> [ 'selectByPath', 2, ":Patches:plusefx:musiqueConcrete" ])
 ], Event[ 
 ('time' -> 133.767), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 1 ])
 ], 
 Event[ 
 ('time' -> 134.139), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.85 ])
 ], Event[ 
 ('time' -> 134.51), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.722501 ])
 ], Event[ 
 ('time' -> 134.882), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.614126 ])
 ], Event[ 
 ('time' -> 135.253), ('delta' -> 0.41796), ('m' -> [ 'setMixOnVoice', 2, 0.522007 ])
 ], Event[ 
 ('time' -> 135.671), ('delta' -> 0.30186), ('m' -> [ 'setMixOnVoice', 2, 0.443706 ])
 ], Event[ 
 ('time' -> 135.973), ('delta' -> 0.3483), ('m' -> [ 'setMixOnVoice', 2, 0.377152 ])
 ], Event[ 
 ('time' -> 136.321), ('delta' -> 0.3483), ('m' -> [ 'setMixOnVoice', 2, 0.32058 ])
 ], Event[ 
 ('time' -> 136.67), ('delta' -> 0.3483), ('m' -> [ 'setMixOnVoice', 2, 0.272493 ])
 ], Event[ 
 ('time' -> 137.018), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.231619 ])
 ], Event[ 
 ('time' -> 137.39), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 2, 0.196877 ])
 ], 
 Event[ 
 ('time' -> 137.761), ('delta' -> 0.39474), ('m' -> [ 'setMixOnVoice', 2, 0.167345 ])
 ], Event[ 
 ('time' -> 138.156), ('delta' -> 0.39474), ('m' -> [ 'setMixOnVoice', 2, 0.142243 ])
 ], Event[ 
 ('time' -> 138.551), ('delta' -> 1.8576), ('m' -> [ 'setMixOnVoice', 2, 0.120907 ])
 ], Event[ 
 ('time' -> 140.408), ('delta' -> 0.3483), ('m' -> [ 'setVolAt', 2, 0.278048 ])
 ], Event[ 
 ('time' -> 140.756), ('delta' -> 0.32508), ('m' -> [ 'setVolAt', 2, 0.305853 ])
 ], Event[ 
 ('time' -> 141.082), ('delta' -> 0.37152), ('m' -> [ 'setVolAt', 2, 0.336438 ])
 ], Event[ 
 ('time' -> 141.453), ('delta' -> 0.3483), ('m' -> [ 'setVolAt', 2, 0.370082 ])
 ], Event[ 
 ('time' -> 141.801), ('delta' -> 0.37152), ('m' -> [ 'setVolAt', 2, 0.40709 ])
 ], Event[ 
 ('time' -> 142.173), ('delta' -> 2.73996), ('m' -> [ 'setVolAt', 2, 0.447799 ])
 ], Event[ 
 ('time' -> 144.913), ('delta' -> 60.5577), ('m' -> [ 'setVolAt', 2, 0.492579 ])
 ], 
 Event[ 
 ('time' -> 205.471), ('delta' -> 1.48608), ('m' -> [ 'setVolAt', 2, 0.541837 ])
 ], Event[ 
 ('time' -> 206.957), ('delta' -> 1.90404), ('m' -> [ 'setVolAt', 2, 0.59602 ])
 ], Event[ 
 ('time' -> 208.861), ('delta' -> 0.39474), ('m' -> [ 'setMixOnVoice', 1, 1 ])
 ], Event[ 
 ('time' -> 209.255), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 1, 0.85 ])
 ], Event[ 
 ('time' -> 209.627), ('delta' -> 0.37152), ('m' -> [ 'setMixOnVoice', 1, 0.7225 ])
 ], Event[ 
 ('time' -> 209.998), ('delta' -> 1.20744), ('m' -> [ 'setMixOnVoice', 1, 0.614126 ])
 ], Event[ 
 ('time' -> 211.206), ('delta' -> 0.41796), ('m' -> [ 'setMixOnVoice', 1, 0.522007 ])
 ], Event[ 
 ('time' -> 211.624), ('delta' -> 0.719819), ('m' -> [ 'setMixOnVoice', 1, 0.443706 ])
 ], Event[ 
 ('time' -> 212.344), ('delta' -> 0.39474), ('m' -> [ 'setMixOnVoice', 1, 0.37715 ])
 ], Event[ 
 ('time' -> 212.738), ('delta' -> 0.32508), ('m' -> [ 'setMixOnVoice', 1, 0.320578 ])
 ], 
 Event[ 
 ('time' -> 213.063), ('delta' -> 0.32508), ('m' -> [ 'setMixOnVoice', 1, 0.272492 ])
 ], Event[ 
 ('time' -> 213.389), ('delta' -> 0.3483), ('m' -> [ 'setMixOnVoice', 1, 0.231618 ])
 ], Event[ 
 ('time' -> 213.737), ('delta' -> 0.39474), ('m' -> [ 'setVolAt', 1, 0.204744 ])
 ], Event[ 
 ('time' -> 214.132), ('delta' -> 0.37152), ('m' -> [ 'setVolAt', 1, 0.18427 ])
 ], Event[ 
 ('time' -> 214.503), ('delta' -> 0.32508), ('m' -> [ 'setVolAt', 1, 0.165843 ])
 ], Event[ 
 ('time' -> 214.828), ('delta' -> 0.3483), ('m' -> [ 'setVolAt', 1, 0.149259 ])
 ], Event[ 
 ('time' -> 215.176), ('delta' -> 0.37152), ('m' -> [ 'setVolAt', 1, 0.134333 ])
 ], Event[ 
 ('time' -> 215.548), ('delta' -> 0.44118), ('m' -> [ 'setVolAt', 1, 0.1209 ])
 ], Event[ 
 ('time' -> 215.989), ('delta' -> 1.92726), ('m' -> [ 'setVolAt', 1, 0.10881 ])
 ], Event[ 
 ('time' -> 217.916), ('m' -> [ 'setVolAt', 1, 0.0979286 ])
 ]] );

a.writeClose;

)
(
b = ZArchive.read("archiveTest");
b.readItem.postln;
b.readItem.postln;

b.close;

)

Repetition compression
identical values or objects that repeat are compressed.
(
a = ZArchive.write("archiveTest");

a.writeItem( [ 
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 1,1,1,1,1,1,1,1,1,1,
 2,2,2,2,2,2,2,2,2,2,
 2,2,2,2,2,2,2,2,2,2,
 2,2,2,2,2,2,2,2,2,2,
 2,2,2,2,2,2,2,2,2,2,
 2,2,2,2,2,2,2,2,2,2,
 2,2,2,2,2,2,2,2,2,2
 ]);

a.writeClose;

)
this is about 42 bytes.

Identical objects get reconstituted as equal but independant objects.
 

(
b = ZArchive.read("archiveTest");
b.readItem.postln;
b.close;
)


(

a = ZArchive.write("archiveTest");

a.writeItem(nil);
a.writeItem("word");
a.writeClose;

)


(
b = ZArchive.read("archiveTest");
b.readItem.postln;
b.readItem.postln;
// one more
b.readItem.postln;


b.close;

)


asZArchive
relative to your Document directory
(
a = "archiveTest".asZArchive;


a.writeItem(1.0.rand);
a.writeItem([1,2,3,4,5].choose);
a.writeItem("hello");
a.writeItem(
 Event.make({
 ~a = \a;
 ~b = \b;
 })
);
a.writeItem([1,2,3,4,5]);
a.writeItem( Ref(4.0) );
a.writeItem([
 Event[
 ('time' -> 149.797), ('delta' -> 0.453), ('m' -> [ 'setVolAt', 0, 0.415356 ])
 ],
 Event[ 
 ('time' -> 150.25), ('delta' -> 0.478), ('m' -> [ 'setVolAt', 0, 0.37382 ])
 ],
 Event[ 
 ('time' -> 150.728), ('delta' -> 0.428), ('m' -> [ 'setVolAt', 0, 0.336438 ])
 ]
]);
a.writeItem([
 IdentityDictionary[
 \a -> "b",
 "b" -> \c
 ]
]); 
a.writeClose;

)


adding support for your custom class

SomeClass {

 writeZArchive { arg akv;
 // turn a path into an archive if needed
 akv = akv.asZArchive;
 
 akv.writeItem(columns.size);
 // we know the column objects have their own support
 columns.do({|c| c.writeZArchive(akv) });
 
 akv.writeItem(name);
 akv.writeItem(beats);
 akv.writeItem(beatsPerBar);
 }
 readZArchive { arg akv;
 columns = Array.fill( akv.readItem(Integer) ,{ arg i;
 // call the custom column object read
 Tracker.readZArchive(akv) 
 });

 name = akv.readItem; // could be an Integer or a String !
 beats = akv.readItem(Float);
 beatsPerBar = akv.readItem(Float);
 }
 

 
When you have large arrays of floats etc., you can bypass writeItem (which will
write a character to specify the class type) and directly use
putFloat, putInt32 etc. (methods of File)

but you must call saveCount before starting to use any of these methods. This is because
any counted repetitions need to be closed off and written to the file before you start manually
putting floats etc.



 
 