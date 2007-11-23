
NotificationCenter


Objects can send notifications to the NotificationCenter, and all functions that were registered for
that notification will be excecuted.

implements the Notification pattern.
This is similar to MVC, except here the model object does not ever
know anything about who is dependant on it.
This allows any interested client object to be notified of special events such as the object being
saved to disk, the object recording a sound file version of itself etc.

For instance when a Sample is saved it emits a \didSave notification:
	NotificationCenter(notify,Sample,\didSave,soundFilePath);

You can listen for this:
	NotificationCenter.register(Sample,\didSave,\sampleWatcher, { arg path;
		path.postln;
	});


//in the following examples this is the interpreter
this.postln
an Interpreter

	
(
// nothing is yet registered
// so notify finds nothing to do
NotificationCenter.notify(this,\didRecord);

// register a function
NotificationCenter.register(this,\didRecord,\theRequestingObject, { "hello".postln; });

// now it has something to do
NotificationCenter.notify(this,\didRecord);
hello

// unregister, thus releasing yourself for GC
NotificationCenter.unregister(this,\didRecord,\theRequestingObject)

// theRequestingObject is no longer interested in this notification
NotificationCenter.notify(this,\didRecord);


)


The listener argument is somewhat unimportant as far as you the client is concerned. 
It is used to identify the notification and to find it later to remove it when needed.

There can only be one notification per listener, but you may use anything for the listener object, such
as an arbitrary symbol.

(// two symbols
NotificationCenter.register(this,\didRecord,\thingOne, { "this will get overwritten by the next registration".postln; });
NotificationCenter.register(this,\didRecord,\thingOne, { "do this".postln; });
NotificationCenter.register(this,\didRecord,\thingTwo, { "do this also".postln; });

NotificationCenter.notify(this,\didRecord);

do this
do this also
)


(
NotificationCenter.register(this,\didRecord,this, { arg path,comments; path.postln; comments.postln; });

// after the addressing, an array of arguments can be supplied to be passed into the function
NotificationCenter.notify(this,\didRecord,[":SoundFiles:blurb.aiff",'yo mama']);
:SoundFiles:blurb.aiff
yo mama

)


You can also remove the Notification registration by getting the layout to remove you
when the window closes:

guiBody { arg layout;
	layout.removeOnClose(
		NotificationCenter.register(model,\didRecord,this, {
			// do things
		});
	);
}





