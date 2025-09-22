extends CharacterBody3D
class_name Enemy

@export var health : float = 100.0
@export var movementSpeed : float = 4.0
@export var gravity : float = 10
@export var friction : float = 0.5
@export var facing : Vector3 = Vector3.ZERO
@export var vel : Vector3 = Vector3.ZERO
@export var acc : Vector3 = Vector3.ZERO

@onready var stateMachine : StateMachine = $StateMachine

func _ready() -> void:
	pass

func _physics_process(delta):
	stateMachine.update(delta)
	if not is_on_floor():
		acc.y -= gravity
	else:
		pass #friction
	vel += acc
	self.velocity = vel * delta
	move_and_slide()
	acc = Vector3.ZERO
