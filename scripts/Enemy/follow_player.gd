extends Behavior
class_name FollowPlayer

@export var speed: float = 2.0

func tick(_delta: float, physics: Physics) -> void:
	if not owner:
		return
	var player = owner.get_node_or_null("/root/base/player")
	if player:
		var direction = (player.global_position - owner.global_position).normalized()
		owner.physics.velocity += direction * speed
