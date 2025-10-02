class_name DashState
extends State

@export var player : CharacterBody3D
@export var dashTime : Timer

var input_dir : Vector2
var direction : Vector3

var dashSpeed : float = 15.0
var jumpVelocity : float = 4.5

func enter():
	#print("DASH!")
	input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	dashTime.start()
	player.velocity = direction * dashSpeed

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	player.move_and_slide()

func _on_dash_timer_timeout() -> void:
	#print("HALT!")
	if !player.is_on_floor():
		transition.emit(self, "Falling")
	elif Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
		transition.emit(self, "Walking")
	elif !Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack"):
		transition.emit(self, "Idle")
		
func _input(event):
	if event.is_action_pressed("jump") and player.is_on_floor():
		#print("Jump!")
		player.velocity.y = jumpVelocity
		transition.emit(self, "Falling")
	
