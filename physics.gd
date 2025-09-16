extends Object
class_name Physics

@export var enable_gravity := true
@export var enable_friction := true
@export var GRAVITY := Vector3(0, -10, 0)
@export var FRICTION := Vector3()

var velocity:= Vector3.ZERO
var acceleration:= Vector3.ZERO

func tick(delta: float, phys_obj: CharacterBody3D) -> void:
	acceleration = Vector3.ZERO
	
	if enable_gravity:
		acceleration += GRAVITY
	
	velocity += acceleration * delta
	
	if enable_friction:
		velocity = velocity.move_toward(Vector3.ZERO, FRICTION.length() * delta)
	
	if phys_obj:
		phys_obj.velocity += velocity * delta
		phys_obj.move_and_slide()
