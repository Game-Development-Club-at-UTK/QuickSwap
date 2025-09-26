extends State

@export var player : CharacterBody3D
@export var dashTime : Timer

var input_dir : Vector2
var direction : Vector3

var dashSpeed : float = 15.0

func enter():
	print("DASH!")
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
	transition.emit(self, "Idle")
