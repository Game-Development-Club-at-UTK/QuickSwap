class_name HurtboxComponent
extends Area3D

@export var health_component : HealthComponent

func damage(damage: float) -> void:
	if health_component:
		health_component.damaged(damage)
