
EventStreamPlayer

superclass: PauseStream

An EventStreamPlayer is used by Event based Patterns. 
You do not explictly create an EventStreamPlayers, they are created for you
when you call Pattern-play.

The EventStreamPlayer holds a stream which returns a series of Events, and a protoEvent. At each call to next, it copies the protoEvent, passes that to the stream, and calls play on the Event returned.

for more on EventStreamPlayer see [Streams-Patterns-Events4]



