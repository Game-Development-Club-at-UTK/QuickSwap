extends State

@export var enemy : Enemy
var player : CharacterBody3D

@export var friction : float = 0.98
@export var acc_speed : float = 0.5
@export var move_speed : float = 40
@export var min_dist : float = 2

func enter():
	var node_from_group = get_tree().get_first_node_in_group("player")
	if node_from_group is CharacterBody3D:
		player = node_from_group

func update(_delta):
	if player && enemy:
		var delta_svec: Vector3 = delta_from_player()
		var dist: float = magnitude(delta_svec)
		var dir: Vector3 = delta_svec.normalized()
		var speed: float = magnitude(enemy.vel)
		#print(speed)
		print(dist)
		if speed < move_speed:
			enemy.vel += dir * move_speed
		if dist < min_dist:
			enemy.acc -= dir * move_speed

func delta_from_player() -> Vector3:
	var player_loc : Vector3 = player.position
	var enemy_loc : Vector3 = enemy.position
	return player_loc - enemy_loc

func magnitude(dist: Vector3) -> float:
	return sqrt(pow(dist.x, 2) + pow(dist.z, 2))
