
Constraint

superclass: AbstractConstraint

Constraint takes a function that it evaluates whenever the constraint itself
is evaluated. Its main benefit then over a simple function is that it responds
to .not .or .and .xor .reject .select by returning the logical compound constraint.

see [AbstractConstraint] for examples of Constraint






