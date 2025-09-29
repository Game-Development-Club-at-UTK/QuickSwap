class_name State
extends Node

"""
	State Documentation
	
	States are a way to modularly expand behavior, whether
	that be player, AI, or otherwise.  ALL states must be parented
	by a state machine for proper state logic flow.  The state
	machine should not altered.
	
	Methods:
		
		enter() - Runs when the state is transitioned into 
		
		exit() - Runs when the state is transitioned out of
		
		update() - Runs every frame
		
		physics_update() - Runs every physics update
		
	Built In Signal:
		
		transition - Emiting transition tells the state machine to change
					 to a different state.  In order to properly change 
					 states.  Emit should possess the arguments self, and
					 the next state that you would like to transition
					 to.
			
			# transition.emit(self, "newState")
			
"""

signal transition

#////////////#
func enter():
	transition.is_null()
	pass

#////////////#

#///////////#
func exit():
	pass

#///////////#

#//////////////////////////#
func update(_delta: float):
	pass

#//////////////////////////#

#///////////////////////////////////#
func physics_update(_delta: float):
	pass

#///////////////////////////////////#
