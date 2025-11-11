class_name PlayerGroundSmashState
extends State

@export var player : CharacterBody3D

const groundSmashSpeed : float = -20.0

func enter():
	player.velocity.y = groundSmashSpeed

func exit():
	pass

func update(_delta: float):
	if player.is_on_floor():
		transition.emit(self, "Idle")

func physics_update(_delta: float):
	player.move_and_slide()

func _input(event):
	if event.is_action_pressed("dash"):
		transition.emit(self, "Dash")
