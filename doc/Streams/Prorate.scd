Proratedivide stream proportionally

superclass: FilterPattern


*new(proportions, pattern)
 
proportions: a pattern that returns either numbers (divides the pattern into pairs)
 or arrays of size n which are used to split up the input into n parts.
pattern: a numerical pattern
 




// examples:


// divide 1 into various proportions
(
a = Prorate(Pseq([0.35, 0.5, 0.8]), 1);

x = a.asStream;

x.nextN(8)
)

// divide a pattern into various proportions
(
a = Prorate(Pseq([0.35, 0.5, 0.8]), Prand([20, 1], inf));

x = a.asStream;

x.nextN(8)
)


// divide 1 into several parts
(
a = Prorate(Pseq([[1, 2], [5, 7], [4, 8, 9]]).collect(_.normalizeSum), 1);

x = a.asStream;

x.nextN(8)
)

