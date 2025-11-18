class_name PlayerSlideState
extends State

@export var player : Player

var input_dir : Vector2
var direction : Vector3
var speed : float

var doesPlayerStartOnGround : bool = false
var baseSlideSpeed : float = 12.0
var jumpVelocity : float = 4.5

func enter() -> void:
	#print("Sliding")
	input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	speed = sqrt(pow(player.velocity.x, 2) + pow(player.velocity.z, 2))
	
	#if player.is_on_floor():
	#	doesPlayerStartOnGround = true
	
	if speed < sqrt(pow(direction.x * baseSlideSpeed, 2) + pow(direction.z * baseSlideSpeed, 2)):
		player.velocity = direction * baseSlideSpeed

func update(_delta: float) -> void:
	#print(player.is_on_floor())
	#if !doesPlayerStartOnGround && player.is_on_floor() && speed < sqrt(pow(direction.x * baseSlideSpeed, 2) + pow(direction.z * baseSlideSpeed, 2)):
		#direction = (player.transform.basis * Vector3(player.velocity.x, 0, player.velocity.y)).normalized()
		#player.velocity = direction * baseSlideSpeed
	
	if Input.is_action_just_pressed("dash"):
		if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
			transition.emit(self, "Dash")
	if Input.is_action_just_released("slide"):
		if player.is_on_floor() and !Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
			transition.emit(self, "Idle")
		elif player.is_on_floor():
			transition.emit(self, "Walking")
		else: 
			transition.emit(self, "Falling")

func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()

func exit() -> void:
	pass
