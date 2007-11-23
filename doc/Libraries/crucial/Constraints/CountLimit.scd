
CountLimit				

counts how many items have been presented to it. returns true until the limit has
been reached, thereafter returns false.

superclass: AbstractConstraint


(
s = CountLimit.new(10);

100.do({ arg i;
	var r;
	r = 100.rand;
	if(s.value(r),{
		[i,r].postln;
	})
});


[ 0, 58 ]
[ 1, 37 ]
[ 2, 39 ]
[ 3, 82 ]
[ 4, 99 ]
[ 5, 93 ]
[ 6, 27 ]
[ 7, 38 ]
[ 8, 20 ]
[ 9, 77 ]
)



