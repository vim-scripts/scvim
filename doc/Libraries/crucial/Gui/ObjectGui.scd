
ObjectGui

The guiClass is the class used to build a gui for an object.

In the MVC architecture it is the Controller, which creates Views for manipulating the properties of your Model, and receives messages from the View and enacts the changes on the Model.

The default guiClass for an Object is ObjectGui. 


Many subclasses overide the guiClass method to specify a different class. All gui classes should inherit from ObjectGui.

see [gui]

It is the simplest display, just the the object asString.

if you click on the "nameplate", you will open object's inspector.



an example gui class

YourSimpleGuiClass : ObjectGui {

	guiBody { arg layout;
	
		// we refer to the model and
		// access its variable howFast.
		// if its a simple number, it will display
		// using the default ObjectGui class, which
		// will simply show its value as a string.
		model.howFast.gui(layout);
	}
}


// more complex
YourGuiClass : ObjectGui {
	
	var numberEditor;
	
	//for example
	guiBody { arg layout;
		var r;
		// the object you are making a gui for is referred to as the model
		
		// display some param on screen.
		// here we assume that someParam is something that
		// has a suitable gui class
		// implemented, or that the default ObjectGui is sufficient.
		model.someParam.gui(layout);
		
		// using non 'gui' objects
		r = layout.layRight(300,300); // allocate yourself some space
		ButtonView(layout.win,r)
			.action_({ arg butt;
				model.goApeShit;
			});
			
		numberEditor = NumberEditor(model.howFast,[0,100])
			.action_({ arg val;
				model.howFast = val;
				model.changed(this);
				// tell the model that this gui changed it
			});
		numberEditor.gui(layout);
	}
	
	// your gui object will have update called any time the .changed message
	// is sent to your model
	update { arg changed,changer;
	
		if(changer !== this,{
			/* if it is this gui object that changed the value
				using the numberEditor, then we already have a correct
				display and don't need to waste cpu to update it.
				if anyone else changed anything about the model,
				we will update ourselves here.
			*/
			numberEditor.value = model.howFast;
			/*
				note that
					numberEditor.value = model.howFast;
				is passive, and does not fire the numberEditor's action.	

					numberEditor.activeValue = model.howFast
				would fire the action as well, resulting in a loop that would
				probably crash your machine.
			*/
		}
	}

}


(// you can gui an object more than once.
// they are both active interfaces to the object.

	n = NumberEditor.new;

	Sheet({ arg f;
		n.gui(f);
		n.gui(f);
	})
)

When the PageLayout window closes that your gui object (Controller) is on, it will be removed as a dependent on the Model, so it will no longer be sent the update message, and will then be free for garbage collection.



