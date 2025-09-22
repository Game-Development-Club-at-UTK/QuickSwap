extends StaticBody3D

#saves data realated to this panel

var targetHeight
var isMoving = false
var currentHeight = 0

func _target_lerp():
	self.position.y = lerpf(self.position.y, targetHeight, .15)
