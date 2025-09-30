extends State
class_name IdleState

func enter() -> void:
	var enemy : Enemy = $"../.."
	enemy.acc = Vector3.ZERO

func exit() -> void:
	pass

func input(_event) -> State:
	return null

func update(_delta) -> State:
	return null
