IsEven 

answers whether the item is even.

superclass: AbstractConstraint


(
s = IsEven.new;

100.do({ arg i;
 if(s.value(i),{
 i.postln
 })
});

)


The class IsEven itself will respond to *value just as an instance will. So it can be used in place of functions in the same manner. This is faster than constructing a FunctionDef { }, and probably executes faster.

(

Array.fill(20,{rand(100)})
 .select(IsEven)
 .postln
 
[ 12, 76, 76, 8, 18, 26, 30, 44, 24, 84 ]
)

