Orderan order of elements with an integer index

superclass: SequenceableCollection

keeps elements in an order. 

 put and at are slower than IdentityDictionary/PriorityQueue, do is faster.


inherits all methods from superclass.

the following messages change the content of the collection without returning a new one.
apart from this they work like collect/reject/select

collectInPlace(func) 

selectInPlace(func)

rejectInPlace(func)


//example

a = Order.new;

a[0] = \z;
a[0] = \y;
a[5] = \five;
a[4] = \four;

a.collectInPlace({ arg item, i; 700 + i });
a[0] = \z;
a[5] = \five;
a[4] = \four;

a.indices;
a.selectInPlace({ arg item; item.asString[0] === $f });
a.indices;

a[9] = 100;
a.rejectInPlace({ arg item; item.isNumber.not });
a.indices;


