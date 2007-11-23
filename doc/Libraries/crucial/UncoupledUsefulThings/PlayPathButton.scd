
PlayPathButton

Superclass: ActionButton


*new( layout, path,minx)

	when clicked, loads the object at path and plays it.
	if already playing, stops.	

	minx is the minimum x width of the button.
	
	// if you were to have something at :Patches:dhalf this would work

(
		PlayPathButton(nil, "Patches/sc3batch1/crazycrazySUnj" )
)





