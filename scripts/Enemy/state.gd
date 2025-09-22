@abstract
extends Node
class_name State

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func input(_event) -> State:
	return null
	
func update(_delta) -> State:
	return null
