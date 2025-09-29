extends State

@export var enemy : Enemy

func physics_update(_delta):
	if enemy:
		if not enemy.is_on_floor():
			enemy.acc += enemy.get_gravity()
		else:
			if enemy.vel.y < 0:
				enemy.vel.y = 0
			transition.emit(self, "FollowPlayer")
