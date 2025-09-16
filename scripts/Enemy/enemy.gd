extends CharacterBody3D
class_name Enemy

@export var behavior_scenes: Array[Script] = []
@export var behaviors: Array[Behavior] = []
var physics:= Physics.new()

func _ready() -> void:
	for behavior in behavior_scenes:
		var b = behavior.new()
		behaviors.append(b)

func _physics_process(delta):
	for behavior in behaviors:
		if behavior:
			behavior.tick(delta, physics)
	physics.tick(delta, self)
