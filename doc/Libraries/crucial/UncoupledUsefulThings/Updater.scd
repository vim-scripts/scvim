
Updater			

superclass: Object

Updater(model, updateFunction)

An Updater can be used to implement a simple Model-View-Controller architecture
in situations where a full blown controller class is not needed.

It adds itself as a dependant to the model. When the model is issued a .changed message (after its state has been changed in some way) all of its dependants, including the Updater are sent the .update message.

The Updater class then simply evalutes the updateFunction

see also: SimpleController


Examples

The most common usage is to monitor a model for changes and to update a view.

(
Sheet({ arg layout;

		var bpmView, updater;
		
		bpmView= CXLabel(layout, "tempo:_____");

		updater = Updater(Tempo.default,{ // any change to Tempo
				bpmView.label_("tempo:" + Tempo.bpm).refresh;
			});
		
		// fire the function manually to initially set the bpmView label
		updater.update;
		
		// tell the layout to .remove this updater when the layout and windows close
		layout.removeOnClose( updater );
});

// every time you set the Tempo it will issue itself a .changed message
Tempo.tempo = 0.4

Tempo.tempo = 1.3

Tempo.tempo = 1.0

)		

The updater adds itself as a dependant to the model, so its important to at some point tell the updater to remove itself (as a dependant). Otherwise it will stay in the model's dependant dictionary and will not get garbage collected. It will also continue to respond to update messages. If the window has closed this means it will try to change views that no longer exist and you will get errors.

tell the layout to .remove this updater when the layout and windows close :

		layout.removeOnClose( updater );



Update the client of messages from server

The commonly used NodeWatcher class watches server notifications and issues .changed messages to the Node objects. Updater can be used to fire an updateFunction

model - the node which you want to receive server notifications for.
updateFunction -

(
// prep
s = Server.local;

n = SynthDef("Updater-help", {|out, freq|
			var sin;
			sin = SinOsc.ar(freq, 0.5)*EnvGen.kr(Env.triangle(4,1), doneAction:2);
			Out.ar(out, sin);
		}).send(s);
)

(
//create a new synth node on the server
n = Synth.new("Updater-help", [\out, 0, \freq, 220]);

//you need to register the synth with a NodeWatcher first
NodeWatcher.register(n);

//update the client of \n_end messages
Updater(n, {|node, msg|
		if(msg==\n_end, {
			"synth has ended".postln;
		});
	});
)

This could also be done using SimpleController, a related class that assumes that the second argument will be a symbol.

(
//create a new synth node on the server
n = Synth.new("Updater-help", [\out, 0, \freq, 220]);

//you need to register the synth with a NodeWatcher first
NodeWatcher.register(n);
c = SimpleController(n);

// map \n_end to an updateFunction
c.put( \n_end,{ arg node;
	"synth has ended".postln;
});

)





