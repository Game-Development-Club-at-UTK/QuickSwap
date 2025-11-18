class_name PlayerGroundSmashState
extends State

@export var player : CharacterBody3D

@onready var groundSmashSlideTTime : Timer = $Timer

const groundSmashSpeed : float = -20.0

func enter() -> void:
	player.velocity.x = 0
	player.velocity.z = 0
	player.velocity.y = groundSmashSpeed
	groundSmashSlideTTime.start()
	

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if player.is_on_floor():
		if !groundSmashSlideTTime.is_stopped() && Input.is_action_pressed("slide"):
			transition.emit(self, "Slide")
		else:
			transition.emit(self, "Idle")

func physics_update(_delta: float) -> void:
	player.move_and_slide()

func _input(event) -> void:
	if event.is_action_pressed("dash"):
		transition.emit(self, "Dash")
