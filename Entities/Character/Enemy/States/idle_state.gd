extends State
class_name IdleState

func enter() -> void:
	var enemy : Enemy = $"../.."
	enemy.acc = Vector3.ZERO

func exit() -> void:
	pass

func input(_event) -> void:
	return

func update(_delta) -> void:
	return
