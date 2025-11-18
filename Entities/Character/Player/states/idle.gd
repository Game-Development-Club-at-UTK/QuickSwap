class_name PlayerIdleState
extends State

@export var player : CharacterBody3D
@export var jumpVelocity : float = 4.5
@export var friction : float = 0.4

var doubleJumpVelocity : float

#@onready var velocity : Vector3 = player.velocity

func enter() -> void:
	doubleJumpVelocity = jumpVelocity / 2

func exit() -> void:
	pass

func update(_delta: float) -> void:
	"""
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		#print("Jump!")
		player.velocity.y = jumpVelocity
	"""
	
	if not player.is_on_floor():
		transition.emit(self, 'Falling')
		
	if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
		transition.emit(self, 'Walking')

func physics_update(_delta: float) -> void:
	if player.velocity:
		player.velocity.x = lerpf(player.velocity.x, 0.0, friction)
		player.velocity.z = lerpf(player.velocity.z, 0.0, friction)
	
	player.move_and_slide()
	
func _input(event) -> void:
	#print(event.as_text())
	if event.is_action_pressed("jump") and player.is_on_floor():
		#print("Jump!")
		player.velocity.y = jumpVelocity
