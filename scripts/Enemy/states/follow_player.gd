# Follows the player with no path finding
extends State

@export var enemy : Enemy
var player : CharacterBody3D

@export var friction : float = 0.5
@export var acc_speed : float = 5
@export var move_speed : float = 3
@export var min_dist : float = 2

# Gets player from global group
func enter():
	var node_from_group = get_tree().get_first_node_in_group("player")
	if node_from_group is CharacterBody3D:
		player = node_from_group

func physics_update(_delta):
	if player && enemy:
		var delta_svec: Vector3 = delta_from_player()
		var dist: float = magnitude(delta_svec)
		var dir: Vector3 = delta_svec.normalized()
		#var speed: float = magnitude(enemy.vel)
		#print(speed)
		#print(dist)
		
		# Move enemy closer to player and stop when close
		if dist <= min_dist:
			# Apply acc backwards
			enemy.vel.x = lerpf(enemy.vel.x, 0, acc_speed * _delta)
			enemy.vel.z = lerpf(enemy.vel.z, 0, acc_speed * _delta)
			
			# Apply Friction when stopping
			enemy.vel.x *= 1.0 -friction * _delta
			enemy.vel.z *= 1.0 -friction * _delta
		else:
			# Move Towards Player
			enemy.vel.x = lerpf(enemy.vel.x, dir.x * move_speed, acc_speed * _delta)
			enemy.vel.z = lerpf(enemy.vel.z, dir.z * move_speed, acc_speed * _delta)

# Returns distance between enemy & player as Vector3
func delta_from_player() -> Vector3:
	var player_loc : Vector3 = player.position
	var enemy_loc : Vector3 = enemy.position
	return player_loc - enemy_loc

# Returns the magnitude of a Vector3
func magnitude(dist: Vector3) -> float:
	return sqrt(pow(dist.x, 2) + pow(dist.z, 2))
