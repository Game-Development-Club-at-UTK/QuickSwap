extends CharacterBody3D

@export var defaultAcceleration : float = 5.4
@export var maxSpeed : float = 5.4
@export var friction : float = 5.4
@export var jumpVelocity : float = 4.5

var acceleration : float
var currentDirectionX : float = 0.0
var currentDirectionZ : float = 0.0

@onready var neck : Node3D = $Neck

func _ready():
	acceleration = defaultAcceleration

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		#print("Get down here")
		velocity += get_gravity() * delta
		
	#print(is_on_floor())
	
	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		#print("Jump!")
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#print(input_dir)
	#print(direction)
	if direction:
		if (direction.x > 0 and velocity.x < 0) or (direction.x < 0 and velocity.x > 0):
			acceleration *= 8
		if (direction.z > 0 and velocity.z < 0) or (direction.z < 0 and velocity.z > 0):
			acceleration *= 8
		acceleration = defaultAcceleration
		velocity.x = lerpf(velocity.x, direction.x * maxSpeed, acceleration * delta)
		velocity.z = lerpf(velocity.z, direction.z * maxSpeed, acceleration * delta)
		#print(velocity.x)
		#print(velocity.z)
		
	else:
		#print(velocity)
		if velocity and is_on_floor():
			velocity.x = lerpf(velocity.x, 0.0, friction * delta)
			velocity.z = lerpf(velocity.z, 0.0, friction * delta)
	
	move_and_slide()
