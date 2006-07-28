NSObjectHolder


o = NSObjectHolder.alloc("NSWindow");

o.do("makeKeyAndOrderFront:",[0]);

o.do("close");

o.dealloc;


