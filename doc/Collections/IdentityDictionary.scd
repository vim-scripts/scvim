IdentityDictionary

Superclass: Dictionary

An IdentityDictionary is an associative collection mapping keys to values.
Two keys match only if they are identical.

The contents of an IdentityDictionary are unordered. 
You must not depend on the order of items in a IdentityDictionary.

Often IdentityDictionaries are used with Symbols as the keys since
Symbols are guaranteed to be identical if they have the same character representation
(i.e. they are equal). Two equal Strings on the other hand might not be identical.

