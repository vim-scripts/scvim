
AbstractPlayerProxy

Defers all responsiblities for playing to another object.
This is a superclass.



a = AbstractPlayerProxy.new;
a.source = Patch({ Saw.ar });

a.play;

a.stop;



see PlayerSocket


