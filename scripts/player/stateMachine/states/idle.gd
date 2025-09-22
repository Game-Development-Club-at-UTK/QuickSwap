extends State

@export var player : CharacterBody3D
@export var jumpVelocity : float = 4.5
@export var friction : float = 5.4

@onready var velocity : Vector3 = player.velocity

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		#print("Jump!")
		player.velocity.y = jumpVelocity
	
	if not player.is_on_floor():
		transition.emit(self, 'Falling')
		
	if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
		transition.emit(self, 'Walking')

func physics_update(delta: float):
	if player.velocity:
			player.velocity.x = lerpf(player.velocity.x, 0.0, friction * delta)
			player.velocity.z = lerpf(player.velocity.z, 0.0, friction * delta)
	
	player.move_and_slide()
