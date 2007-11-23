
convertRhythm			convert a rhythm-list to durations

message for SequenceableCollection


supports a variation of Mikael Laurson's rhythm list RTM-notation.

see Laurson and Kuuskankare's 2003, "From RTM-notation to ENP-score-notation"
http://jim2003.agglo-montbeliard.fr/articles/laurson.pdf


The method converts a collection of the form [beat-count, [rtm-list], repeats] to a List of Floats. A negative integer within the rtm-list equates to a value tied over to the duration following. The method is recursive in that any subdivision within the rtm-list can itself be a nested convertRhythm collection (see Example below). The repeats integer has a default value of 1.

If the divisions in the rtm-list are events, the event durations are interpreted as relative durations, and a list of events is returned.

// Examples

// using numbers as score

[3, [1, 2, 1], 1].convertRhythm; // List[ 0.75, 1.5, 0.75 ]

[2, [1, 3, [1, [2, 1, 1, 1]], 1, 3], 1].convertRhythm;

[2, [1, [1, [2, 1, 1, 1]]], 1].convertRhythm;

[2, [1, [1, [2, 1, 1, 1]]], 2].convertRhythm; // repeat

[2, [1, [1, [2, 1, 1, -1]]], 2].convertRhythm; // negative value is tied over.


// sound example

Pbind(\degree, Pseries(0, 1, inf), \dur, Pseq([2, [1, [1, [2, 1, 1, -1]]], 2].convertRhythm)).play;


// using events as score

[3, [(dur:1, degree:0), (dur:2, degree:5), (dur:1, degree:3)], 1].convertRhythm;

(
a = (dur:1, degree:[0, 2, 5, 7]);
b = (dur:2, degree:5);
c = (dur:1, degree:[3, 6]);
);

[3, [a, b, c], 1].convertRhythm;
[2, [a, [1, [a, a, a, a]]], 1].convertRhythm;
[2, [a, [2, [a, c, b, c], 2], b], 1].convertRhythm;

// sound example

Pseq([2, [a, [2, [a, c, b, c], 2], c], 1].convertRhythm).play;



