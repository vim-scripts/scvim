
IsNotIn				answers whether an item is not included in a collection

superclass: AbstractConstraint


(

a = [1,3,6,8,9,0];
[1,2,3,4,5,6,7,8,9,0].select(IsNotIn(a)).postln

[ 2, 4, 5, 7 ]
)


