extends State

@export var player : CharacterBody3D

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	if player.is_on_floor():
		if Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
			transition.emit(self, 'Walking')
		else:
			transition.emit(self, 'Idle')

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	player.move_and_slide()
