
History			keeps a history of interpreted lines of code



History keeps track of all code lines that are being executed, in order to forward them to other players, to easily reuse earlier versions, or to store and reproduce a performance. Since it records everything that is interpreted, there is only one privileged instance of History - History.current.
(adc 2006/7)


	*start / *end	start/end adding interpreted code to (current) history
	
	*clear		remove all items from (current) history
	
	*enter(obj)	add an entry by hand
	
	*document	post the history in a new document (as story)
	
	*drop(n)		drop the newest n lines from history. if n is negative, drop the oldest n lines
	
	*keep(n)		keep only the newest n lines from history. if n is negative, keep the oldest n lines
	
	*saveCS(path, forward)	
				store history as one compileString
	*loadCS(path, forward)	
				load a history from (compilestring) file.
	*saveStory(path)	
				store in a file, in historical order as individual code snippets
	*loadStory(path)	
				read history into current, from a file in story format
				
	*play(start, end, verbose)	
				play back current history from start to end line, per default verbose
	*stop 		stop current history playback.
	

// example use:

History.clear.end;		// clear to start over
History.start; 		// starts recording, opens log file

				// execute these lines one by one
1 + 2;
p = ProxySpace.push(s.boot);
~a = {Dust.ar([1,1] * 30 ) * 0.3 }; //
~a.play;
~a.end;

History.end;		// NOTE: change of interface! History.end ends logging now.


History.document; // create a document with all the changes

History.showLogFile; //

g = History.makeWin(0@20); // make a gui window, put it where you like
g = History.makeWin(0@20, 5); // lines to see in textview

History.play;			// posts lines by default;

History.play(verbose: false); // just do it, no posting;

	// continue recording
History.start;

10 + 200;			// enter 5 more lines
p.push;
~b = { |freq=500| LFDNoise3.ar(freq.dup(2)) * 0.2 };
~b.play;
~b.set(\freq, 1000);
~b.end(2);

History.end;


	 // save current history to a file.
History.saveCS("~/Desktop/TestHist.scd");
h = History.new.loadCS("~/Desktop/TestHist.scd");
h.lines.printcsAll; "";

	// under the hood: History.someCommand goes to History.current:

	// History.current is where new codelines always go.
h = History.current;
h.lines.printcsAll; "";
h.lineShorts.printcsAll; ""; // lineshorts are for gui display

History.enter("2 + 2");		// make a simple entry by hand.
h.lines.printcsAll; "";

		// one can edit a history:

History.drop(-1); // drop the oldest memory
History.drop(1); // drop the newest memory

h.keep(9); 		h.lines.printAll; "";
h.drop(3); 		h.lines.printAll; "";
h.removeLast;		h.lines.printAll;"";
h.removeAt([3, 4]);	h.lines.printAll;"";


// more examples
History.clear.start;

1 + 2;			// code lines get stored

(nil + 2).postln;	// error lines are ignored 

	// comment-only line is kept, empty lines not:

	// save and load as text files


History.saveCS; // save as compilestring for reloading.
				// save with name, in forward time order.
History.saveCS("~/Desktop/testHist.scd", forward: true);
			// load back in from file
h = History.new.loadCS("~/Desktop/testHist.scd", forward: true);
h.lines.postcs; "";

	// save as human-readable/hand-playable story
History.saveStory			// write all to time-stamped file in historical order
History.saveStory("~/Desktop/myTestStory.scd");	// ... with given filename.
History.loadStory("~/Desktop/myTestStory.scd");	// load from story format file

Document.open("~/Desktop/myTestStory.scd");	// the story file is human-readable.


	// Various Internals
	// make a new instance of History by hand:
h = History([[0, \me, "1+2"], [1.234, \me, "q = q ? ();"], [3, \me, "\"History\".speak"]]);
h.lines.printcsAll; "";
h.lineShorts.printcsAll; "";

h.play;	// play it
h.stop;


	// string formatting utils
h.storyString;
History.formatTime(1234.56);
History.unformatTime("0:20:34.56");
(
History.prettyString("
/* removes line returns at start and end of code strings ... */

").postcs;
)	// convert a line to a short string of n characters for gui display
History.shorten(h.lines.first.postcs, 60).postcs;

	
	// in networked setups, one may turn off local recording and rely on remote recording:
History.recordLocally
History.localOff
History.recordLocally
History.localOn
History.recordLocally


	// by default, history always logs here (and makes the folder if not there yet):
History.logFolder;
History.showLogFolder;
History.logPath;
History.showLogFile; // current logfile...
	// todo: optionally, one should be able to turn logging off?

	// filtering lines, to get subsets of all lines by key and/or searchstring:

	// get indices for specific keys
h = History([[0, \me, "a=1+2"], [1, \me, "3+5"], [1.234, \you, "q = q ? ();"], [3, \her, "\"Herstory ==== \".speak"]]);
h.keys;
h.matchKeys(\me);
h.matchKeys(\you);
h.matchKeys(\her);
h.matchKeys; 			// nil if no test
h.matchKeys(\all); 	// all keys match
h.matchKeys([\me, \her])
h.matchKeys(\isidor)	// empty array if no line found

h.matchString("Herst");
h.matchString("q");
h.matchString("1+");
h.matchString("herStory", false); // ignoreCase is false by default
h.matchString("herStory", true); // ignoreCase

h.indicesFor([\me, \her], "="); // indices for line written by \me or \her AND containing "=";

	// searching is only an interface/access feature,
	// so please read on at HistoryGui help ...
h.makeWin; // HistoryGui.openHelpFile;


