extends State

@export var player : CharacterBody3D
@export var defaultAcceleration : float = 5.4
@export var maxSpeed : float = 5.4

var acceleration : float

func enter():
	acceleration = defaultAcceleration

func exit():
	pass

func update(_delta: float):
	if player.is_on_floor():
		if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
			transition.emit(self, 'Walking')
		else:
			transition.emit(self, 'Idle')

func physics_update(delta: float):
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
		
		player.velocity.x = lerpf(player.velocity.x, direction.x * maxSpeed, acceleration * delta)
		player.velocity.z = lerpf(player.velocity.z, direction.z * maxSpeed, acceleration * delta)
	
	player.move_and_slide()

func _input(event):
	#print(event.as_text())
	if event.is_action_pressed("dash"):
		transition.emit(self, 'Dash')
