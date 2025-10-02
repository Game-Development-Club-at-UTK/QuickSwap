class_name Entity
extends CharacterBody3D

@onready var componentManager : ComponentManager = $ComponentManager

func _ready() -> void:
	for child in componentManager.get_children():
		if child is HealthComponent:
			child.connect("death", _onDeath)
			#print("Health Connected")
		elif child is HitboxComponent:
			child.connect("damageDealt", _onDamageDealt)
			#print("Hitbox Connected")
		elif child is HurtboxComponent:
			child.connect("damageTaken", _onDamageTaken)
			#print("Hurtbox Connected")
		else :
			print("Child component found with a non-compatible class!")

func _onDeath():
	print("Rest in peace")
	pass

func _onDamageDealt():
	#print("Take that")
	pass

func _onDamageTaken():
	#print("Ouch")
	pass
