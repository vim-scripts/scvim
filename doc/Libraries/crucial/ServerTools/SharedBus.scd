
SharedBus

superclass: Bus


This simple class solves a problem with sharing busses between players. When a player is stopped or freed, it frees its Bus, which frees the Bus number for reallocation. 

In the case of PlayerMixer, several players are using the same bus. Only the PlayerMixer itself should be able to free the Bus. 

In the case of PlayerSocket, each player that plays in the socket is given the bus, and they will free that Bus when the player is replaced by a new player in the socket. Again, only the PlayerSocket itself should be able to finally free the Bus.

A SharedBus will not free its bus number until given explicit permission by its owner by calling .releaseBus

If you are writing a class that for instance hosts various Players and you wish them to share busses or to keep ahold of the bus you are playing them on without having the Player free it:

	sbus = bus.as(SharedBus);
	
	.... use it ....
	
	sbus.releaseBus; // releases and frees the Bus index
	


