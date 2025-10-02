class_name HurtboxComponent
extends Area3D

signal damageTaken

@export var health_component : HealthComponent

func damage(damage: float) -> void:
	if health_component:
		damageTaken.emit()
		health_component.damaged(damage)
