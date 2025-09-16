extends Object
class_name Physics

@export var enable_gravity := true

const GRAVITY = 10
var velocity:= Vector3(0, 10, 0)
var acceleration:= Vector3(0, 0, 0)

func tick(delta: float, phys_obj: CharacterBody3D) -> void:
	velocity += acceleration
	if enable_gravity:
		velocity[1] -= GRAVITY * delta
	if phys_obj:
		phys_obj.velocity += velocity * delta
		phys_obj.move_and_slide()
