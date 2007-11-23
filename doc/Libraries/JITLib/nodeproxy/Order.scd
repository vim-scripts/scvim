
Order		an order of elements with an integer index

superclass: SequenceableCollection

keeps elements in an order.

	put and at are slower than IdentityDictionary/PriorityQueue, do is faster.





//example

a = Order.new;

a[0] = \z;
a[0] = \y;
a[5] = \five;
a[4] = \four;

a[0] = \z;
a[5] = \five;
a[4] = \four;

a.indices;

a[9] = 100;
a.indices;




