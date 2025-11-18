class_name PLayerWallRunState
extends State

@export var player : CharacterBody3D
@export var jumpVelocity : float = 4.5

@export var rightAntenna : RayCast3D
@export var leftAntenna : RayCast3D

var rightAntennaActive : bool

func enter() -> void:
	if rightAntenna.is_colliding():
		rightAntennaActive = true
	elif leftAntenna.is_colliding():
		rightAntennaActive = false
	else:
		print("Uh oh")
		transition.emit(self, "Falling")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
	
func _input(_event) -> void:
	pass
