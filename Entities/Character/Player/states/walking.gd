class_name PlayerWalkingState
extends State

@export var defaultAcceleration : float = 20.1
@export var maxSpeed : float = 5.4
@export var jumpVelocity : float = 4.5

@export var player : CharacterBody3D
@export var neck : Node3D

# @onready var velocity : Vector3 = player.velocity
# @onready var transform : Transform3D = player.transform

var acceleration : float
var doubleJumpVelocity : float

# var currentDirectionX : float = 0.0
# var currentDirectionZ : float = 0.0

func enter():
	doubleJumpVelocity = jumpVelocity / 2
	acceleration = defaultAcceleration

func exit():
	pass

func update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		#print("Jump!")
		player.velocity.y = jumpVelocity
	
	if not player.is_on_floor():
		transition.emit(self, 'Falling')

func physics_update(delta: float):
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#print(input_dir)
	#print(direction)
	if direction:
		if (direction.x > 0 and player.velocity.x < 0) or (direction.x < 0 and player.velocity.x > 0):
			acceleration *= 8
		if (direction.z > 0 and player.velocity.z < 0) or (direction.z < 0 and player.velocity.z > 0):
			acceleration *= 8
		acceleration = defaultAcceleration
		
		#player.velocity.x = maxSpeed * direction.x #* delta
		#player.velocity.z = maxSpeed * direction.z #* delta
		
		#print(player.velocity.normalized())
		
		player.velocity.x = lerpf(player.velocity.x, direction.x * maxSpeed, acceleration * delta)
		player.velocity.z = lerpf(player.velocity.z, direction.z * maxSpeed, acceleration * delta)
		# print(player.velocity.x)
		# print(player.velocity.z)
	else:
		#player.velocity.x = 0; player.velocity.z = 0
		transition.emit(self, 'Idle')
		
	player.move_and_slide()

func _input(event):
	#print(event.as_text())
	if event.is_action_pressed("dash"):
		transition.emit(self, 'Dash')
