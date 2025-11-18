class_name PlayerFallingState
extends State

@export var player : CharacterBody3D
@export var defaultAcceleration : float = 5.4
@export var maxSpeed : float = 5.4

@export var rightAntenna : RayCast3D
@export var leftAntenna : RayCast3D

var speed : float
var acceleration : float

func enter() -> void:
	acceleration = defaultAcceleration

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if player.is_on_floor():
		if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
			transition.emit(self, 'Walking')
		else:
			transition.emit(self, 'Idle')


func physics_update(delta: float) -> void:
		# Checks for wall-running
	if rightAntenna.is_colliding():
		if rightAntenna.get_collider().is_in_group("WallRunnable"):
			transition.emit(self, "WallRun")
	elif leftAntenna.is_colliding(): 
		if leftAntenna.get_collider().is_in_group("WallRunnable"):
			transition.emit(self, "WallRun")
		
		# Handles gravity
	player.velocity += player.get_gravity() * delta
	
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
		
		speed = sqrt(pow(player.velocity.x, 2) + pow(player.velocity.z, 2))
		
		if speed < sqrt(pow(direction.x * maxSpeed, 2) + pow(direction.z * maxSpeed, 2)):
			#print("Speeding Up")
			player.velocity.x = lerpf(player.velocity.x, direction.x * maxSpeed, acceleration * delta)
			player.velocity.z = lerpf(player.velocity.z, direction.z * maxSpeed, acceleration * delta)
		else:
			#print("Changin Dir")
			 
			#print("%f : %f" %[player.velocity.x, direction.x * abs(player.velocity.x)])
			#print("%f : %f" %[player.velocity.z, direction.z * abs(player.velocity.z)])
			
			player.velocity.x = lerpf(player.velocity.x, direction.x * speed, acceleration * delta)
			player.velocity.z = lerpf(player.velocity.z, direction.z * speed, acceleration * delta)
	
		
		"""
		if Vector2(player.velocity.x, player.velocity.z).normalized() < sqrt(pow(direction.x * maxSpeed, 2) + pow(direction.z * maxSpeed, 2)):
			#print("Speeding Up")
			player.velocity.x = lerpf(player.velocity.x, direction.x * maxSpeed, acceleration * delta)
			player.velocity.z = lerpf(player.velocity.z, direction.z * maxSpeed, acceleration * delta)
		else:
			#print("Changin Dir")
			player.velocity.x = lerpf(player.velocity.x, direction.x * abs(player.velocity.x), acceleration * delta)
			player.velocity.z = lerpf(player.velocity.z, direction.z * abs(player.velocity.z), acceleration * delta)
		"""
		
	player.move_and_slide()

func _input(event) -> void:
	#print(event.as_text())
	if event.is_action_pressed("dash") && Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
		transition.emit(self, 'Dash')
	elif event.is_action_pressed("slide"):
		transition.emit(self, 'GroundSmash')
