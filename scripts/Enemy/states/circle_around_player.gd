extends State

@export var enemy : Enemy
var player : CharacterBody3D

func enter():
	var node_from_group = get_tree().get_first_node_in_group("player")
	if node_from_group is CharacterBody3D:
		player = node_from_group

func physics_update(_delta: float):
	pass
