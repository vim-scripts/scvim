
MultiLevelIdentityDictionary

superclass: Collection

A tree of IdentityDictionaries. Addresses within the tree are specified with a series of keys. Library is its most useful subclass.


at(key1,key2 ... keyN)
	retrieves a leaf node or nil if not found.
	
put(key1,key2 ... keyN, item)
	puts the item as a leaf node, internally creating new branches as needed to accommodate the list of keys.
	
choose
	choose a branch at each level, descend the tree until a leaf is chosen.
	
choose(key1,key2 ... keyN)
	starting at an address within the tree, descend the tree until a leaf is chosen.
	
putTree(key1,[
		key2a, item1-2a,
		key2b, item1-2b,
		[
			key3, item1-3
		] // etc...
	]);
	
	A way to insert objects into the tree with a syntax similar to the organization of the tree
	itself.


