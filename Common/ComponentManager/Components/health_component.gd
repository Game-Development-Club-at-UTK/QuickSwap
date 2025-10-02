class_name HealthComponent
extends Node

signal death

@export var maxHealth : float

var health : float

func _ready() -> void:
	health = maxHealth

func damaged(damage : float) -> void:
	health -= damage
	
	print(health)
	
	if health <= 0:
		death.emit()
