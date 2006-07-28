SeenBefore 

keeps a history of all items and answers whether an item has been seen by the constraint
object before.

superclass: AbstractConstraint


(
s = SeenBefore.new;

100.do({ arg i;
 var r;
 r = 100.rand;
 if(s.value(r).not,{
 [i,r].postln;
 })
});

[ 0, 88 ]
[ 1, 19 ]
[ 2, 71 ]
[ 3, 83 ]
[ 4, 56 ]
[ 5, 97 ]
[ 6, 98 ]
[ 7, 78 ]
[ 8, 65 ]
[ 9, 63 ]
[ 10, 7 ]
[ 11, 5 ]
[ 12, 30 ]
[ 13, 53 ]
[ 14, 15 ]
[ 15, 70 ]
[ 16, 74 ]
[ 17, 44 ]
[ 18, 18 ]
[ 19, 66 ]
[ 22, 6 ]
[ 23, 60 ]
[ 24, 42 ]
[ 25, 95 ]
[ 26, 62 ]
[ 27, 96 ]
[ 28, 29 ]
[ 29, 81 ]
[ 30, 49 ]
[ 31, 13 ]
[ 32, 47 ]
[ 33, 59 ]
[ 34, 61 ]
[ 36, 34 ]
[ 37, 1 ]
[ 38, 0 ]
[ 43, 25 ]
[ 44, 3 ]
[ 46, 20 ]
[ 50, 16 ]
[ 51, 76 ]
[ 54, 87 ]
[ 55, 99 ]
[ 56, 90 ]
[ 57, 36 ]
[ 59, 57 ]
[ 60, 67 ]
[ 61, 45 ]
[ 62, 94 ]
[ 66, 86 ]
[ 69, 92 ]
[ 71, 80 ]
[ 72, 91 ]
[ 75, 89 ]
[ 79, 69 ]
[ 81, 35 ]
[ 84, 10 ]
[ 86, 73 ]
[ 87, 2 ]
[ 89, 8 ]
[ 93, 33 ]
[ 95, 31 ]
[ 98, 23 ]
)