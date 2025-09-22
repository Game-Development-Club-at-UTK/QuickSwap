extends EnemyState
class_name FollowPlayerState

@export var speed : float = 4
var player : Player
var enemy : Enemy

func enter() -> void:
	print("hello")
	var player_node = get_tree().get_first_node_in_group("player")
	var enemy_node = get_parent().get_parent()
	player = player_node as Player
	enemy = enemy_node as Enemy

func exit() -> void:
	print("bye")

func update(_delta) -> State:
	if player:
		var loc = delta_from_player()
		enemy.vel += loc
	return null

func delta_from_player() -> Vector3:
	var player_loc : Vector3 = player.position
	var enemy_loc : Vector3 = enemy.position
	return player_loc - enemy_loc
