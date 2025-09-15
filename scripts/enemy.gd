extends CharacterBody3D

var directionToPlayer = Vector3(0,0,0)
var moveSpeed = 2.5
var health = 5

func _process(_delta): 
	pass
	
	#update label
#	$Label.text = "Health: "+str(health)
#	$Label.global_position = $"../palyer/camera".unproject_position(self.global_position + Vector3(0,1.2,0)) + Vector2(-64,-16)
	$Label3D.text = "Health: "+str(health)
	
	#move towards player
#	directionToPlayer = $"../palyer".global_position - self.global_position
#	directionToPlayer = directionToPlayer.normalized()
#	velocity.x = directionToPlayer.x * moveSpeed
#	velocity.z = directionToPlayer.z * moveSpeed
#	move_and_slide()

func _hit(dmg, _kbk, _dir): #called by projectiles on enemies - information is damage, knockback force, and shot direction
	print("hit for: "+str(dmg)+" damage")
