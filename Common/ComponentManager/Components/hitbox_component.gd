class_name HitboxComponent
extends Area3D

signal damageDealt

@export var damage : float

func _on_hurtbox_area_entered(area: Area3D) -> void:
	
	print(area)
	
	if area is HurtboxComponent:
		damageDealt.emit()
		area.damage(damage)
