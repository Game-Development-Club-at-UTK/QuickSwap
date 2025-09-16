extends CharacterBody3D
class_name Enemy

@export var behaviors: Array[Behavior] = []
var physics:= Physics.new()

func _ready() -> void:
	for behavior in behaviors:
		if behavior:
			behavior.owner = self

func _physics_process(delta):
	physics.tick(delta, self)
	for behavior in behaviors:
		if behavior:
			behavior.tick(delta)
