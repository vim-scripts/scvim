
Maybe			referentially transparent proxy object	

superclass: FuncProxy

A Maybe object can contain either nil or some other object, and allows to construct calculations without knowing this other object yet. If the calculation fails, due to a loop or a not yet defined object, Maybe returns nil.

The name Maybe stems from the programming language Haskell, where it represents a somewhat similar thing.



	*new(object)
	
		create a new instance
		object - an object or nil.		
		
		// example:
		a = Maybe.new;
		b = Maybe(a + 6);
		b.value;
		a.value = 1;
		b.value;

	source
	
		return the contained object
		
	source_(obj)
	
		set the contained object
		
	value_(obj)
	
		set the contained object
	
	value(arg1, arg2...)
	
		return the source, or the value of the contained object, if it is a Maybe.
		If there is a recursion, return nil.
			
	
	apply(arg1, arg2...)
	
		return the value, or the value of the contained object, if it is a Maybe.
		This method allows recursion, so that recursive calcualtions can be made.
		
	doesNotUnderstand(selector, ... args) (called by any message that Maybe doesn't understand)
	
		returns a composition function that, when evaluated, returns the value.
		// example:
		a = Maybe.new;
		b = Maybe(a.flop);
		b.value;
		a.value = [1, 2, [2, 3]];
		b.value;		

			


// the following examples use a LazyEnvir with a Maybe as a proxy class.
// instead of writing a = Maybe.new; a.value = something;
// one can simply write ~a = something.
// the Maybe is implictly created for you.

(
	p.pop.clear;
	p = LazyEnvir.new.linkDoc;
	p.proxyClass = Maybe;
);


// sets
~a = Set[0, 4, 5, 7];
~b = Set[4, 5];
~c = ~a | ~b;
~c.value;
~b = Set[4, 5, 13, 0];
~c.value;
~b = Set[4, ~w, 5];
~c.value;
~w = Set[2, 3];
~c.value;
~a = Set[4, 5, Set[2, 4]];
~c.value;
~a = Set[4, 5, ~w];
~c.value;


// envirs
~a = (note: [1, 2]);
~b = (dur: 1);
~c = ~a.putAll(~b)
~c.value;
~a = (note: [1, 2, 4]);
~c.value;
~d = ~a.at(\note);
~d.value;
~a = (note: [7.5]);
~d.value; // [7.5]

// patterns
~a = Pseq([1, 2, 3]);
~b = Pseq([5, ~a, ~a + 10], inf);
~x = ~b.asStream

~x.nextN(10)

~a = Prand([100, 200]);
~x.nextN(10);


// to do : flop!

//////////////// deep recursion

// with normal functions:
f = { |x| if(x <= 1) { 1 } { x * f.(x - 1) } };
f.(11)


~faculty = { |x| if(x == 1) { 1 } { x * ~faculty.(x - 1) } };
~faculty.(12) // doesn't work. here we do want recursion ...

// for explicit recursion use "apply"
~faculty = { |x| if(x == 1) { 1 } { x * ~faculty.apply(x - 1) } };
~faculty.(12)

// safety:
Maybe.maxDepth = 1e2; // higher depth is risky..
~faculty = { |x| x * ~faculty.apply(x - 1) }; // infinite recursion
~faculty.(12)

Maybe.maxDepth = nil; // unsafe again.


//////////////// recursion prevention tests

~b = ~a;
~a = ~b;
~a.value;


~a = ~b;
~b = ~c;
~c = ~a;
~a.value;

~a = ~b + ~c;
~c = ~a;
~a.value;


~a = ~b;
~b = 19;
~a.value;
~b.value;

// function evaluation and argument passing

~a = { |x| x + 2 };
~a.value;

~a.value(~c);
~b = 2000;
~a.value(~b);
~x = [600, 1000];

(~a + 1).value(~b); // 2003
(~a + 1).value(~x); // [ 603, 1003 ]
(~a + 1).value({ 8 }); // binary op func.
(~a + 1).value({ 5 + 3 }).value // 11

~a = { |x| x + 2 + ~b };
~a.value(8);

~c = nil;
~a = { |x| x + 2 + ~c }; // ~c is undefined.
~a.value(8);

~c = 100; // define ~c

~a.value(8); // now returns a value.

~c = ~b; // now recursion?
~b = ~a;
~a.value(8); // caught recursion

~c = { 100.rand }; // ~c is a function

~a.value(8);
~a.value(8);

~c = { ~a + ~b };
~a.value(8);	// ~c is a recursion with ~a


// function composition
~a = {|x| x + 1 };
~v = ~a <> ~a <> ~a; // same as: { ~a.(~a.(~a)) }
~v.value(0);

~a = {|x| x + 2 };
~v.value(0); // transparent.

// {|x| x }.valueEnvir // doesn't work with current implementation of Function:valueEnvir


// calculations with functions:
~c = 0;
~a = { |ff| { ff = ff + 1; ~c + ff + 2 + ~c } };
~x = ~a.value(8);
~x.value; // return 11, 12, 13...
~x.value;
~x.value;
~c = 100;
~x.value; // return 214, 215 ...
~x.value;

// binary op functions:
~c = 0;
~a = { |ff| {[600, 800] } + { ff + 2 + ~c } };

~x = ~a.value(8);
~x.value; // return [ 610, 810 ]

~c = { [10, -10].rand };
~x.value; // return random between [ 610..620, 800..810 ]






		


