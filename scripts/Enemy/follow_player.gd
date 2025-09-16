extends Behavior
class_name FollowPlayer

@export var speed: float = 0.1

func tick(_delta: float) -> void:
	if not owner:
		return
	var player = owner.get_node_or_null("/root/base/player")
	if player:
		var direction = (player.global_position - owner.global_position).normalized()
		owner.velocity = direction * speed
		owner.move_and_slide()
