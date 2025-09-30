extends CharacterBody3D
class_name Enemy


@export var health : float = 100.0
@export var movementSpeed : float = 4.0
@export var gravity : float = 10
@export var friction : float = 0.5

@export var type : String = "enemy" # Ex. (trone, tobot, turret, etc.)



@export var facing : Vector3 = Vector3.ZERO
@export var vel : Vector3 = Vector3.ZERO
@export var acc : Vector3 = Vector3.ZERO

func _physics_process(delta):
	vel += acc * delta
	self.velocity = vel

	move_and_slide()
	acc = Vector3.ZERO
